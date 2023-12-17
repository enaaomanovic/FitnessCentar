using AutoMapper;
using FitnessCentar.Model.Requests;
using FitnessCentar.Model.SearchObject;
using FitnessCentar.Services.Base;
using FitnessCentar.Services.Database;
using FitnessCentar.Services.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Services
{
    public class OdgovoriNaKomentareService : BaseService<Model.OdgovoriNaKomentare, Database.OdgovoriNaKomentare, OdgovoriNaKomentareSearchObject, OdgovoriNaKomentareInsertRequest, OdgovoriNaKomentareUpdateRequest>,  IOdgovoriNaKomentareService
    {
        public OdgovoriNaKomentareService(Ib200005rs2Context context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<OdgovoriNaKomentare> AddFilter(IQueryable<OdgovoriNaKomentare> query, OdgovoriNaKomentareSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);


            if (search.komentarId != null)
            {
                filteredQuery = filteredQuery.Where(x => x.KomentarId == search.komentarId);
            }
            return filteredQuery;

        }
    }
}
