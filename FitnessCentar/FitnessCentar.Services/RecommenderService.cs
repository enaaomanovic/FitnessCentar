using AutoMapper;
using FitnessCentar.Model;
using FitnessCentar.Model.Requests;
using FitnessCentar.Model.Responses;
using FitnessCentar.Model.SearchObject;
using FitnessCentar.Services.Base;
using FitnessCentar.Services.Database;
using FitnessCentar.Services.Interface;
using Microsoft.EntityFrameworkCore;
using Microsoft.ML;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Services
{
    public class RecommenderService : BaseService<Model.Recommender, Database.Recommender, RecommenderSearchObject, RecommenderInsertRequest, RecommenderUpdateRequest>, IRecommenderService
    {
        protected readonly IMapper Mapper;
        static MLContext mlContext = null;
        static object isLocked = new object();
        static ITransformer model = null;

        public RecommenderService(IMapper mapper, Ib200005rs2Context context) : base(context, mapper)
        {


        }

        public async Task<Model.Recommender?> GetByIdAsync(int id, CancellationToken cancellationToken = default)
        {
            var entity = await _context.Recommender.FirstOrDefaultAsync(x=>x.NovostId==id, cancellationToken);
            if (entity is null)
                return null;
            return Mapper.Map<Model.Recommender>(entity);
         
        }





        public List<Model.Novosti> Recommend(int id)
        {
            lock (isLocked)
            {
                if (mlContext == null)
                {
                    mlContext = new MLContext();

                    
                    var tmpData = _context.Korisnicis.Include(x => x.PregledaneNovosti).ToList();
                  

                    var data = new List<NovostiPreporuka>();

                    foreach (var x in tmpData)
                    {
                        if (x.PregledaneNovosti.Count > 1)
                        {
                            var distinctItemId = x.PregledaneNovosti.Select(y => y.NovostId).ToList();

                            distinctItemId.ForEach(y =>
                            {
                                var relatedItems = x.PregledaneNovosti.Where(z => z.NovostId != y);

                                foreach (var z in relatedItems)
                                {
                                    data.Add(new NovostiPreporuka()
                                    {
                                        NovostId = (uint)y,
                                        CoNovostID = (uint)z.NovostId,
                                    });
                                }
                            });
                        }
                    }

                    var trainData = mlContext.Data.LoadFromEnumerable(data);

                    MatrixFactorizationTrainer.Options options = new MatrixFactorizationTrainer.Options();
                    options.MatrixColumnIndexColumnName = nameof(NovostiPreporuka.NovostId);
                    options.MatrixRowIndexColumnName = nameof(NovostiPreporuka.CoNovostID);
                    options.LabelColumnName = "Label";
                    options.LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass;
                    options.Alpha = 0.01;
                    options.Lambda = 0.025;
                   
                    options.NumberOfIterations = 100;
                    options.C = 0.00001;

                    var est = mlContext.Recommendation().Trainers.MatrixFactorization(options);

                    model = est.Fit(trainData);
                }
            }

            var novosti = _context.Novostis.Where(x => x.Id != id).ToList();

            var predictionResult = new List<Tuple<Database.Novosti, float>>();

            foreach (var novost in novosti)
            {

                var predictionengine = mlContext.Model.CreatePredictionEngine<NovostiPreporuka, CoNovosti_prediction>(model);
                var prediction = predictionengine.Predict(
                                         new NovostiPreporuka()
                                         {
                                             NovostId = (uint)id,
                                             CoNovostID = (uint)novost.Id
                                         });


                predictionResult.Add(new Tuple<Database.Novosti, float>(novost, prediction.Score));
            }


            var finalResult = predictionResult.OrderByDescending(x => x.Item2).Select(x => x.Item1).Take(3).ToList();

            return _mapper.Map<List<Model.Novosti>>(finalResult);

        }

        public async Task<List<Model.Responses.RecommenderResult>> TrainNovostiModelAsync(CancellationToken cancellationToken = default)
        {
            var novosti = await _context.Novostis.ToListAsync(cancellationToken);

            var brojZapisa = await _context.PregledaneNovostis.CountAsync(cancellationToken);


            if (novosti.Count() > 4 && brojZapisa > 8)
            {
                List<Database.Recommender> recommendList = new List<Database.Recommender>();

                foreach (var novost in novosti)
                {
                    var recommendedNovosti = Recommend(novost.Id);

                    var resultRecoomend = new Database.Recommender()
                    {
                        NovostId = novost.Id,
                        CoNovostId1 = recommendedNovosti[0].Id,
                        CoNovostId2 = recommendedNovosti[1].Id,
                        CoNovostId3 = recommendedNovosti[2].Id
                    };
                    recommendList.Add(resultRecoomend);
                }
                await CreateNewRecommendation(recommendList, cancellationToken);
                await _context.SaveChangesAsync();

                return _mapper.Map<List<Model.Responses.RecommenderResult>>(recommendList);
            }
            else
            {
                throw new Exception("Not enough data to do recommmedation");
            }


        }
        public async Task DeleteAllRecommendation(CancellationToken cancellationToken = default)
        {
            await _context.Recommender.ExecuteDeleteAsync(cancellationToken);
        }
       


        public async Task CreateNewRecommendation(List<Database.Recommender> results, CancellationToken cancellationToken = default)
        {
            var list = await _context.Recommender.ToListAsync();
            var novostiCount = await _context.Novostis.CountAsync(cancellationToken); 
            var recordCount = await _context.Recommender.CountAsync();

            if (recordCount != 0)
            {
                if (recordCount > novostiCount)
                {
                    for (int i = 0; i < novostiCount; i++)
                    {
                        list[i].NovostId = results[i].NovostId;
                        list[i].CoNovostId1 = results[i].CoNovostId1;
                        list[i].CoNovostId2 = results[i].CoNovostId2;
                        list[i].CoNovostId3 = results[i].CoNovostId3;
                    }

                    for (int i = novostiCount; i < recordCount; i++)
                    {
                        _context.Recommender.Remove(list[i]);
                    }


                }
                else
                {
                    for (int i = 0; i < _context.Recommender.Count(); i++)
                    {
                        list[i].NovostId = results[i].NovostId;
                        list[i].CoNovostId1 = results[i].CoNovostId1;
                        list[i].CoNovostId2 = results[i].CoNovostId2;
                        list[i].CoNovostId3 = results[i].CoNovostId3;
                    }
                    var num = results.Count() - _context.Recommender.Count();

                    if (num > 0)
                    {
                        for (int i = results.Count() - num; i < results.Count(); i++)
                        {
                            await _context.Recommender.AddAsync(results[i]);
                        }
                    }
                }

            }
            else
            {
                await _context.Recommender.AddRangeAsync(results);

            }

        }

     
    }

}






