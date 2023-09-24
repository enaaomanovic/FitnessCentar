using FitnessCentar.Model;
using FitnessCentar.Model.Requests;
using FitnessCentar.Model.SearchObject;
using FitnessCentar.Services;
using Microsoft.AspNetCore.Mvc;

namespace FitnessCentar.Controllers
{
    [ApiController]

    public class NovostiController : BaseController<Model.Novosti, NovostiSearchObject, NovostiInsertRequest, NovostiUpdateRequest>
    {
        public NovostiController(ILogger<BaseController<Novosti, NovostiSearchObject, NovostiInsertRequest, NovostiUpdateRequest>> logger, INovostiServices service) : base(logger, service)
        {

        }
        

    }
}
