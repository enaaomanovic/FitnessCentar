using FitnessCentar.Model.Requests;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;



namespace FitnessCentar.Services
{
    public interface IKorisniciService
    {
        List<Model.Korisnici> Get();
        Model.Korisnici Insert(KorisniciInsertRequest request);
        Model.Korisnici Update(int id,KorisniciUpdateRequest request);



    }
}
