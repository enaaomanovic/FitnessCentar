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
    public class NapredakService : BasedService<Model.Napredak, Database.Napredak, NapredakSearchObject, NapredakInsertRequest, NapredakUpdateRequest>, INapredakService
    {
        public NapredakService(Ib200005rs2Context context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Napredak> AddFilter(IQueryable<Napredak> query, NapredakSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

           
            if (search.korisnikId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.KorisnikId == search.korisnikId);
            }
            return filteredQuery;

        }
    }
}
