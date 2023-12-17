using FitnessCentar.Model;
using FitnessCentar.Model.Requests;
using FitnessCentar.Model.SearchObject;
using FitnessCentar.Services.Interface;
using Microsoft.AspNetCore.Mvc;

namespace FitnessCentar.Controllers
{
    [ApiController]
 
    public class TreningController : BaseController<Model.Trening, TreningSearchObject, TreningInsertRequest, TreningUpdateRequest>
    {
        public TreningController(ILogger<BaseController<Trening, TreningSearchObject, TreningInsertRequest, TreningUpdateRequest>> logger, ITreningService service) : base(logger, service)
        {

        }

    }
}
