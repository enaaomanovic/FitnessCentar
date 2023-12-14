using AutoMapper;
using FitnessCentar.Model.Responses;
using FitnessCentar.Model.SearchObject;
using FitnessCentar.Services.Database;
using FitnessCentar.Services.Interface;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Services.Base
{
    public class BaseService<T, TDb, TSearch, TInsert, TUpdate> : IService<T, TSearch, TInsert, TUpdate> where TDb : class where T : class where TSearch : BaseSearchObject where TInsert : class where TUpdate : class
    {
        protected Ib200005rs2Context _context;
        protected IMapper _mapper { get; set; }

        public BaseService(Ib200005rs2Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }

        public virtual async Task<List<T>> Get(TSearch? search = null)
        {
            var query = _context.Set<TDb>().AsQueryable();

            query = AddFilter(query, search);
            query = AddInclude(query);



            var list = await query.ToListAsync();

            return _mapper.Map<List<T>>(list);
        }
        public virtual async Task<PageResult<T>> GetPage(TSearch? search = null)
        {
            var query = _context.Set<TDb>().AsQueryable();

            query = AddFilter(query, search);
            query = AddInclude(query);
            var respons = new Model.PageResult<T>();
            if (search?.Page is not null && search?.PageSize is not null)
            {
                var list = await query
                   .Skip((int)((search.Page - 1) * search.PageSize))
                   .Take((int)search.PageSize)
                   .ToListAsync();

                respons.Result = _mapper.Map<List<T>>(list);
            }
            else
            {

                var list = await query.ToListAsync();
                respons.Result = _mapper.Map<List<T>>(list);
            }
            respons.Count = query.Count();
            return respons;
        }



        //public virtual async Task<T> Update(int id, TUpdate update)
        //{

        //    var set = _context.Set<TDb>();
        //    var entity = await set.FindAsync(id);
        //    _mapper.Map(update, entity);

        //    await _context.SaveChangesAsync();

        //    return _mapper.Map<T>(entity);
        //}
        public virtual async Task<T> Update(int id, TUpdate update)
        {
            try
            {
                var set = _context.Set<TDb>();
                var entity = await set.FindAsync(id);
                _mapper.Map(update, entity);

                await _context.SaveChangesAsync();

                return _mapper.Map<T>(entity);
            }
            catch (Exception ex)
            {
                // Zabeleži izuzetak u logovima ili ga prikaži na konzoli radi dalje analize.
                Console.WriteLine($"Greška prilikom čuvanja promena u bazi podataka: {ex.Message}");
                throw; // Ponovno podizanje izuzetka kako bi se greška prenela na viši nivo.
            }
        }

        public virtual async Task<T> Insert(TInsert insert)
        {
            var set = _context.Set<TDb>();
            TDb entity = _mapper.Map<TDb>(insert);
            set.Add(entity);
            await _context.SaveChangesAsync();
            return _mapper.Map<T>(entity);
        }
        public virtual IQueryable<TDb> AddFilter(IQueryable<TDb> query, TSearch? search = null)
        {
            return query;
        }
        public virtual async Task<T> GetById(int id)
        {

            var entity = await _context.Set<TDb>().FindAsync(id);

            return _mapper.Map<T>(entity);
        }

        public virtual IQueryable<TDb> AddInclude(IQueryable<TDb> query)
        {
            return query;
        }



    }
}
