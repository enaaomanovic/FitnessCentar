using FitnessCentar.Model.Requests;
using FitnessCentar.Model.SearchObject;
using FitnessCentar.Model;
using Microsoft.AspNetCore.Mvc;
using FitnessCentar.Services.Interface;

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
