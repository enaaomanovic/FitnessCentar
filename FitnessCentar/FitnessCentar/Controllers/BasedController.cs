using FitnessCentar.Services;
using Microsoft.AspNetCore.Mvc;

namespace FitnessCentar.Controllers
{
   
    [Route("[controller]")]
    public class BasedController<T, TSearch> : ControllerBase where T : class where TSearch : class
    {
        private readonly IService<T,TSearch> _service;
        private readonly ILogger<BasedController<T, TSearch>> _logger;

        public BasedController(ILogger<BasedController<T, TSearch>> logger, IService<T, TSearch> service)
        {
            _logger = logger;
            _service = service;
        }
        [HttpGet()]
        public async Task<IEnumerable<T>> Get([FromQuery]TSearch? search=null)
        {
            return await _service.Get(search);
        }

        [HttpGet("{id}")]
        public async Task<T> GetById(int id)
        {
            return await _service.GetById(id);
        }


    }
}
