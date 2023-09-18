using FitnessCentar.Model;
using FitnessCentar.Model.Requests;
using FitnessCentar.Model.SearchObject;
using FitnessCentar.Services;
using Microsoft.AspNetCore.Mvc;
//using FitnessCentar.Model;
namespace FitnessCentar.Controllers
{
    [ApiController]

    public class KorisniciController : BasedController<Model.Korisnici,KorisniciSearchObject>
    {
        public KorisniciController(ILogger<BasedController<Korisnici,KorisniciSearchObject>> logger, IKorisniciService service) : base(logger, service)
        {
           
        }

    }

}
