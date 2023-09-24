using FitnessCentar.Model.Requests;
using FitnessCentar.Model.SearchObject;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Services
{
    public interface ITreningService : IService<Model.Trening, TreningSearchObject, TreningInsertRequest, TreningUpdateRequest>
    {
    }
}
