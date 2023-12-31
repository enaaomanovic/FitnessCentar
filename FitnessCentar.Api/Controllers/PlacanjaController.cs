﻿using FitnessCentar.Model;
using FitnessCentar.Model.Requests;
using FitnessCentar.Model.SearchObject;
using FitnessCentar.Services.Interface;
using Microsoft.AspNetCore.Mvc;
using Stripe;

namespace FitnessCentar.Controllers
{
    [ApiController]

    public class PlacanjaController : BaseController<Model.Placanja, PlacanjaSearchObject, PlacanjaInsertRequest, PlacanjaUpdateRequest>
    {
        public PlacanjaController(ILogger<BaseController<Placanja, PlacanjaSearchObject, PlacanjaInsertRequest, PlacanjaUpdateRequest>> logger, IPlacanjeService service) : base(logger, service)
        {

        }
        
       
     


    }
}
