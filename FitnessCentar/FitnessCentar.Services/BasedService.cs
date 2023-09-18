using AutoMapper;
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
    public class BasedService<T,TDb, TSearch> :IService<T,TSearch> where TDb : class where T : class where TSearch :BaseSearchObject
    {
      protected Ib200005rs2Context _context;
        protected IMapper _mapper { get; set; }

        public BasedService(Ib200005rs2Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        public virtual async Task<List<T>> Get(TSearch? search=null)
        {
            var query = _context.Set<TDb>().AsQueryable();

            query = AddFilter(query, search);

            if(search?.Page.HasValue== true && search?.PageSize.HasValue == true)
            {
                query = query.Take(search.PageSize.Value).Skip(search.Page.Value * search.PageSize.Value);
            }

            var list = await query.ToListAsync();

            return _mapper.Map<List<T>>(list);
        }
        public virtual IQueryable<TDb> AddFilter(IQueryable<TDb>  query,TSearch? search = null)
        {
            return query;
        }
        public virtual async Task<T> GetById(int id)
        {
            var entity = await _context.Set<TDb>().FindAsync(id);

            return _mapper.Map<T>(entity);
        }


    }
}
