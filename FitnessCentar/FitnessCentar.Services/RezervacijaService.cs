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
    public class RezervacijaService : BasedService<Model.Rezervacije, Database.Rezervacije, RezervacijaSearchObject, RezervacijaInsertRequest, RezervacijUpdateRequest>, IRezervacijaServices
    {
        public RezervacijaService(Ib200005rs2Context context, IMapper mapper) : base(context, mapper)
        {
        }


        public override IQueryable<Rezervacije> AddInclude(IQueryable<Rezervacije> query)
        {
            return base.AddInclude(query);
        }

        public override IQueryable<Rezervacije> AddFilter(IQueryable<Rezervacije> query, RezervacijaSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (search.rasporedId != null)
            {

                filteredQuery = filteredQuery.Where(x => x.RasporedId == search.rasporedId);

            }
            if (search.korisnikId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.KorisnikId == search.korisnikId);
            }
            if (search.status != null)
            {
                filteredQuery = filteredQuery.Where(x => x.Status == search.status);
            }
            return filteredQuery;

        }
    }
}
