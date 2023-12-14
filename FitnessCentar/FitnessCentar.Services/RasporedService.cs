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
    public class RasporedService : BaseService<Model.Raspored, Database.Raspored, RasporedSearchObject, RasporedInsertRequest, RasporedUpdateRequest>, IRasporedService
    {
        public RasporedService(Ib200005rs2Context context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
