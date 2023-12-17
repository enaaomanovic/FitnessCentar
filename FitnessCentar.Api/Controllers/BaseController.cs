using FitnessCentar.Model.Responses;
using FitnessCentar.Services.Interface;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Stripe;

namespace FitnessCentar.Controllers
{

    [Route("[controller]")]
    [Authorize]
    public class BaseController<T, TSearch, TInsert, TUpdate> : ControllerBase where T : class where TSearch : class where TInsert : class where TUpdate : class
    {
        private readonly IService<T, TSearch, TInsert, TUpdate> _service;
        private readonly ILogger<BaseController<T, TSearch, TInsert, TUpdate>> _logger;

        public BaseController(ILogger<BaseController<T, TSearch, TInsert, TUpdate>> logger, IService<T, TSearch, TInsert, TUpdate> service)
        {
            _logger = logger;
            _service = service;
        }
       
        [HttpGet("GetPage")]
        public  async Task<PageResult<T>> GetPage([FromQuery] TSearch? search = null)
        {
            return await _service.GetPage(search);
        }

        [HttpGet()]
        public async Task<IEnumerable<T>> Get([FromQuery] TSearch? search = null)
        {
            return await _service.Get(search);
        }


        [HttpGet("{id}")]
        public async Task<T> GetById(int id)
        {
            return await _service.GetById(id);
        }
        [HttpPost()]
        public  async Task<T> Insert(TInsert insert)
        {
            return await _service.Insert(insert);
        }
        [HttpPut("{id}")]
        public  async Task<T> Update(int id, TUpdate update)
        {
           
            return await _service.Update(id, update);
        }


    }
}
