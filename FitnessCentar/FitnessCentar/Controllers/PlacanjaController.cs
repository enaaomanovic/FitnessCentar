using FitnessCentar.Model;
using FitnessCentar.Model.Requests;
using FitnessCentar.Model.SearchObject;
using FitnessCentar.Services;
using Microsoft.AspNetCore.Mvc;

namespace FitnessCentar.Controllers
{
    [ApiController]

    public class PlacanjaController : BaseController<Model.Placanja, PlacanjaSearchObject, PlacanjaInsertRequest, PlacanjaUpdateRequest>
    {
        public PlacanjaController(ILogger<BaseController<Placanja, PlacanjaSearchObject, PlacanjaInsertRequest, PlacanjaUpdateRequest>> logger, IPlacanjeService service) : base(logger, service)
        {

        }


    }
}
