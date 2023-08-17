using FitnessCentar.Model.Requests;
using FitnessCentar.Services;
using Microsoft.AspNetCore.Mvc;
//using FitnessCentar.Model;
namespace FitnessCentar.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class KorisniciController : ControllerBase
    {
        private readonly IKorisniciService _service;
        private readonly ILogger<KorisniciController> _logger;

        public KorisniciController(ILogger<KorisniciController> logger, IKorisniciService service)
        {
            _logger = logger;
            _service = service;
        }
        [HttpGet()]
        public IEnumerable<FitnessCentar.Model.Korisnici> Get()
        {
            return _service.Get();
        }
        [HttpPost]
        public Model.Korisnici Insert(KorisniciInsertRequest request)
        {
            return _service.Insert(request);
        }

        [HttpPut("{id}")]
        public Model.Korisnici Update(int id,KorisniciUpdateRequest request)
        {
            return _service.Update(id, request);
        }


    }
}