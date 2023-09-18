using AutoMapper;
using FitnessCentar.Model.Requests;
using FitnessCentar.Model.SearchObject;
using FitnessCentar.Services.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;



namespace FitnessCentar.Services
{
    public class KorisniciService : BasedService<Model.Korisnici, Database.Korisnici,KorisniciSearchObject>, IKorisniciService
    {

        public KorisniciService(Ib200005rs2Context context, IMapper mapper) : base(context, mapper)
        {

        }

    }
}
