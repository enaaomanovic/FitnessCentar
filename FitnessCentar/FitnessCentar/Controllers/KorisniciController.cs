using FitnessCentar.Model;
using FitnessCentar.Model.Requests;
using FitnessCentar.Model.SearchObject;
using FitnessCentar.Services.Interface;
using Microsoft.AspNetCore.Mvc;
//using FitnessCentar.Model;
namespace FitnessCentar.Controllers
{
    [ApiController]

    public class KorisniciController : BaseController<Model.Korisnici, KorisniciSearchObject, KorisniciInsertRequest, KorisniciUpdateRequest>
    {
        public KorisniciController(ILogger<BaseController<Korisnici, KorisniciSearchObject, KorisniciInsertRequest, KorisniciUpdateRequest>> logger, IKorisniciService service) : base(logger, service)
        {

        }

      

    }

}
