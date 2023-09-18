﻿using AutoMapper;
using FitnessCentar.Model;
using FitnessCentar.Model.SearchObject;
using FitnessCentar.Services.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Services
{
    public  class TreningService:BasedService<Model.Trening,Database.Treningi,TreningSearchObject>,ITreningService
    {

       

        public TreningService(Ib200005rs2Context context, IMapper mapper):base(context,mapper)
        {
           
        }

    
        public override IQueryable<Treningi> AddFilter(IQueryable<Treningi> query, TreningSearchObject? search = null)
        {
            if (!string.IsNullOrWhiteSpace(search?.Naziv))
            {
                query = query.Where(n => n.Naziv.StartsWith(search.Naziv));
            }
            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                query = query.Where(n => n.Naziv.Contains(search.FTS));

            }
            return base.AddFilter(query, search);
        }
    }
}
