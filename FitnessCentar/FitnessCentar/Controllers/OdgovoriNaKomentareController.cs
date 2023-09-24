using FitnessCentar.Model;
using FitnessCentar.Model.Requests;
using FitnessCentar.Model.SearchObject;
using FitnessCentar.Services;
using Microsoft.AspNetCore.Mvc;

namespace FitnessCentar.Controllers
{
    [ApiController]

    public class OdgovoriNaKomentareController : BaseController<Model.OdgovoriNaKomentare, OdgovoriNaKomentareSearchObject, OdgovoriNaKomentareInsertRequest, OdgovoriNaKomentareUpdateRequest>
    {
        public OdgovoriNaKomentareController(ILogger<BaseController<OdgovoriNaKomentare, OdgovoriNaKomentareSearchObject, OdgovoriNaKomentareInsertRequest, OdgovoriNaKomentareUpdateRequest>> logger, IOdgovoriNaKomentareService service) : base(logger, service)
        {

        }


    }
}
