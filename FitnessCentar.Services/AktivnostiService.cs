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
    public class AktivnostiService : BaseService<Model.Aktivnosti, Database.Aktivnosti, AktivnostiSearchObject, AktivnostiInsertRequest, AktivnostiUpdateRequest>, IAktivnostiService
    {
        public AktivnostiService(Ib200005rs2Context context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
