using FitnessCentar.Model;
using FitnessCentar.Model.Requests;
using FitnessCentar.Model.SearchObject;
using FitnessCentar.Services.Interface;
using Microsoft.AspNetCore.Mvc;

namespace FitnessCentar.Controllers
{
    [ApiController]

    public class AktivnostiController : BaseController<Model.Aktivnosti, AktivnostiSearchObject, AktivnostiInsertRequest, AktivnostiUpdateRequest>
    {
        public AktivnostiController(ILogger<BaseController<Aktivnosti, AktivnostiSearchObject, AktivnostiInsertRequest, AktivnostiUpdateRequest>> logger, IAktivnostiService service) : base(logger, service)
        {

        }

    }
}
