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
    }
}
