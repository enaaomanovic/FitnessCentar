﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Services
{
    public interface IService<T,TSearch> where TSearch : class
    {
        Task<List<T>> Get(TSearch sreach =null);
        Task<T> GetById(int id);


    }
}
