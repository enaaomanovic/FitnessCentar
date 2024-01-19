using FitnessCentar.Model;
using FitnessCentar.Model.Requests;
using FitnessCentar.Model.SearchObject;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;



namespace FitnessCentar.Services.Interface
{
    public interface IKorisniciService : IService<Korisnici, KorisniciSearchObject, KorisniciInsertRequest, KorisniciUpdateRequest>
    {
        Korisnici? Authenticiraj(string username, string password);
        Task ChangePasswordAsync(KorisniciChangePassword userChangePass);
        Task ChangeUsernameAsync(KorisniciChangeUsername userChangePass);

    }
}
