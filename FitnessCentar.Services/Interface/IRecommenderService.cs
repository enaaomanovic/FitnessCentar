using FitnessCentar.Model.Requests;
using FitnessCentar.Model.Responses;
using FitnessCentar.Model.SearchObject;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Services.Interface
{
   public interface IRecommenderService:IService<Model.Recommender,RecommenderSearchObject,RecommenderInsertRequest,RecommenderUpdateRequest>
    {
        Task<Model.Recommender?> GetByIdAsync(int id, CancellationToken cancellationToken = default);
      
        Task<List<Model.Responses.RecommenderResult>> TrainNovostiModelAsync(CancellationToken cancellationToken = default);
        Task DeleteAllRecommendation(CancellationToken cancellationToken = default);


    }
}
