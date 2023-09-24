using FitnessCentar.Model.Requests;
using FitnessCentar.Model.SearchObject;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Services
{
    public interface INapredakService : IService<Model.Napredak, NapredakSearchObject, NapredakInsertRequest, NapredakUpdateRequest>
    {


    }
}
