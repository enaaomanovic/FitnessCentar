﻿using AutoMapper;
using FitnessCentar.Model.Requests;
using FitnessCentar.Model.SearchObject;
using FitnessCentar.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Services
{
    public class OdgovoriNaKomentareService : BasedService<Model.OdgovoriNaKomentare, Database.OdgovoriNaKomentare, OdgovoriNaKomentareSearchObject, OdgovoriNaKomentareInsertRequest, OdgovoriNaKomentareUpdateRequest>,  IOdgovoriNaKomentareService
    {
        public OdgovoriNaKomentareService(Ib200005rs2Context context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}