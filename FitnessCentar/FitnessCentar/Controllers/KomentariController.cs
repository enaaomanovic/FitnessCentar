using FitnessCentar.Model;
using FitnessCentar.Model.Requests;
using FitnessCentar.Model.SearchObject;
using FitnessCentar.Services;
using Microsoft.AspNetCore.Mvc;

namespace FitnessCentar.Controllers
{
    [ApiController]

    public class KomentariController : BaseController<Model.Komentari, KomentariSearchObject, KomentariInsertRequest, KomentariUpdateRequest>
    {
        public KomentariController(ILogger<BaseController<Komentari, KomentariSearchObject, KomentariInsertRequest, KomentariUpdateRequest>> logger, IKomentariService service) : base(logger, service)
        {

        }

    }
}
