﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FitnessCentar.Model.Responses;

namespace FitnessCentar.Services.Interface
{
    public interface IService<T, TSearch, TInsert, TUpdate> where TSearch : class where TInsert : class where TUpdate : class where T : class
    {
        Task<List<T>> Get(TSearch sreach = null);
        Task<PageResult<T>> GetPage(TSearch sreach = null);
        Task<T> GetById(int id);
        Task<T> Insert(TInsert insert);
        Task<T> Update(int id, TUpdate update);


    }
}
