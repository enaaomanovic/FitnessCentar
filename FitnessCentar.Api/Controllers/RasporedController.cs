using FitnessCentar.Model;
using FitnessCentar.Model.Requests;
using FitnessCentar.Model.SearchObject;
using FitnessCentar.Services.Interface;
using Microsoft.AspNetCore.Mvc;

namespace FitnessCentar.Controllers
{
    [ApiController]

    public class RasporedController : BaseController<Model.Raspored, RasporedSearchObject, RasporedInsertRequest, RasporedUpdateRequest>
    {
        public RasporedController(ILogger<BaseController<Raspored, RasporedSearchObject, RasporedInsertRequest, RasporedUpdateRequest>> logger, IRasporedService service) : base(logger, service)
        {

        }

    }
}
