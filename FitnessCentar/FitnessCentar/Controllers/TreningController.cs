using FitnessCentar.Model;
using FitnessCentar.Model.SearchObject;
using FitnessCentar.Services;
using Microsoft.AspNetCore.Mvc;

namespace FitnessCentar.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class TreningController : BasedController<Model.Trening,TreningSearchObject>
    {
        public TreningController(ILogger<BasedController<Trening,TreningSearchObject>>logger, ITreningService service):base(logger, service)  
        {
           
        }
     
    }
}
