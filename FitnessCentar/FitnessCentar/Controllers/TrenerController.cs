using FitnessCentar.Model.Requests;
using FitnessCentar.Model.SearchObject;
using FitnessCentar.Model;
using FitnessCentar.Services;
using Microsoft.AspNetCore.Mvc;

namespace FitnessCentar.Controllers
{
    [ApiController]
 
    public class TrenerController : BaseController<Model.Treneri, TrenerSearchObject, TrenerInsertRequest, TrenerUpdateRequest>
    {
        public TrenerController(ILogger<BaseController<Treneri, TrenerSearchObject, TrenerInsertRequest, TrenerUpdateRequest>> logger, ITrenerService service) : base(logger, service)
        {

        }
        
        

    }




}
