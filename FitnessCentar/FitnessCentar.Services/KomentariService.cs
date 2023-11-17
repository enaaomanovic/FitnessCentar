using AutoMapper;
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
    public class KomentariService : BasedService<Model.Komentari, Database.Komentari, KomentariSearchObject, KomentariInsertRequest, KomentariUpdateRequest>, IKomentariService
    {
        public KomentariService(Ib200005rs2Context context, IMapper mapper) : base(context, mapper)
        {


        }
        public override IQueryable<Komentari> AddFilter(IQueryable<Komentari> query, KomentariSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);


            if (search.novostId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.NovostId == search.novostId);
            }
            return filteredQuery;

        }
    }
}
