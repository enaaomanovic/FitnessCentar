using FitnessCentar.Model;
using FitnessCentar.Model.Requests;
using FitnessCentar.Model.SearchObject;
using FitnessCentar.Services;
using Microsoft.AspNetCore.Mvc;

namespace FitnessCentar.Controllers
{
    [ApiController]

    public class NapredakController : BaseController<Model.Napredak, NapredakSearchObject, NapredakInsertRequest, NapredakUpdateRequest>
    {
        public NapredakController(ILogger<BaseController<Napredak, NapredakSearchObject, NapredakInsertRequest, NapredakUpdateRequest>> logger, INapredakService service) : base(logger, service)
        {

        }

    }
}
