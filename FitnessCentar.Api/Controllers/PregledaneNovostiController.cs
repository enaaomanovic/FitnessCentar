using FitnessCentar.Model;
using FitnessCentar.Model.Requests;
using FitnessCentar.Model.SearchObject;
using FitnessCentar.Services.Interface;
using Microsoft.AspNetCore.Mvc;

namespace FitnessCentar.Controllers
{
    [ApiController]

    public class PregledaneNovostiController : BaseController<Model.PregledaneNovosti, PregledaneNovostiSearchObject, PregledaneNovostiInsertRequest, PregledaneNovostiUpdate>
    {
        public PregledaneNovostiController(ILogger<BaseController<PregledaneNovosti, PregledaneNovostiSearchObject, PregledaneNovostiInsertRequest, PregledaneNovostiUpdate>> logger, IPregledaneNovosti service) : base(logger, service)
        {

        }

    }
}
