using FitnessCentar.Model.SearchObject;
using FitnessCentar.Services;
using FitnessCentar.Services.Interface;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System.ComponentModel.DataAnnotations;

namespace FitnessCentar.Controllers
{
 
   

    public class RecommenderController
    {
        private readonly IRecommenderService _recommendService;

        public RecommenderController(IRecommenderService service, ILogger<RecommenderController> logger, IRecommenderService recommendResultsService)
        {
            _recommendService=recommendResultsService;
        }

        [Authorize]
        [HttpGet("RecommenderGet/{novostId}")]
        public virtual async Task<Model.Recommender?> Get(int novostId, CancellationToken cancellationToken = default)
        {


            return await _recommendService.GetByIdAsync(novostId, cancellationToken);

        }


        [Authorize]
        [HttpPost("TrainModelAsync")]
        public virtual async Task<List<Model.Responses.RecommenderResult>> TrainModel(CancellationToken cancellationToken = default)
        {
                return await _recommendService.TrainNovostiModelAsync(cancellationToken);
                
          
        }

        [Authorize]
        [HttpDelete("ClearRecommendation")]
        public virtual async Task ClearRecommendation(CancellationToken cancellationToken = default)
        {
            await _recommendService.DeleteAllRecommendation();


        }


      

    }








}

