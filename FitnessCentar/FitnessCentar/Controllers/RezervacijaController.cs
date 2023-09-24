using FitnessCentar.Model;
using FitnessCentar.Model.Requests;
using FitnessCentar.Model.SearchObject;
using FitnessCentar.Services;
using Microsoft.AspNetCore.Mvc;

namespace FitnessCentar.Controllers
{
    [ApiController]

    public class RezervacijaController : BaseController<Model.Rezervacije, RezervacijaSearchObject, RezervacijaInsertRequest, RezervacijUpdateRequest>
    {
        public RezervacijaController(ILogger<BaseController<Rezervacije, RezervacijaSearchObject, RezervacijaInsertRequest, RezervacijUpdateRequest>> logger, IRezervacijaServices service) : base(logger, service)
        {

        }

    }
}
