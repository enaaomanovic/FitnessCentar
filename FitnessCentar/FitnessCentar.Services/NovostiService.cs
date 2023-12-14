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
    public class NovostiService : BaseService<Model.Novosti, Database.Novosti, NovostiSearchObject, NovostiInsertRequest, NovostiUpdateRequest>, INovostiServices
    {
        public NovostiService(Ib200005rs2Context context, IMapper mapper) : base(context, mapper)
        {
        }
        public override Task<Model.Novosti> Insert(NovostiInsertRequest insert)
        {
         
            insert.DatumObjave = DateTime.Now;
            return base.Insert(insert);
        }
    }
}
