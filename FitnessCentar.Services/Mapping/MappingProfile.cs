using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Services.Mapping
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<Database.Korisnici, Model.Korisnici>();
            CreateMap<Model.Requests.KorisniciInsertRequest, Database.Korisnici>();
            CreateMap<Model.Requests.KorisniciUpdateRequest, Database.Korisnici>();

            CreateMap<Database.Treningi, Model.Trening>();
            CreateMap<Model.Requests.TreningInsertRequest, Database.Treningi>();
            CreateMap<Model.Requests.TreningUpdateRequest, Database.Treningi>();

            CreateMap<Database.Novosti, Model.Novosti>();
            CreateMap<Model.Requests.NovostiInsertRequest, Database.Novosti>();
            CreateMap<Model.Requests.NovostiUpdateRequest, Database.Novosti>();

            CreateMap<Database.Treneri, Model.Treneri>().ReverseMap();
            CreateMap<Model.Requests.TrenerInsertRequest, Database.Treneri>();
            CreateMap<Model.Requests.TrenerUpdateRequest, Database.Treneri>();

            CreateMap<Database.Rezervacije, Model.Rezervacije>();
            CreateMap<Model.Requests.RezervacijaInsertRequest, Database.Rezervacije>();
            CreateMap<Model.Requests.RezervacijUpdateRequest, Database.Rezervacije>();

            CreateMap<Database.Placanja, Model.Placanja>();
            CreateMap<Model.Requests.PlacanjaInsertRequest, Database.Placanja>();
            CreateMap<Model.Requests.PlacanjaUpdateRequest, Database.Placanja>();


            CreateMap<Database.OdgovoriNaKomentare, Model.OdgovoriNaKomentare>();
            CreateMap<Model.Requests.OdgovoriNaKomentareInsertRequest, Database.OdgovoriNaKomentare>();
            CreateMap<Model.Requests.OdgovoriNaKomentareUpdateRequest, Database.OdgovoriNaKomentare>();

            CreateMap<Database.Napredak, Model.Napredak>();
            CreateMap<Model.Requests.NapredakInsertRequest, Database.Napredak>();
            CreateMap<Model.Requests.NapredakUpdateRequest, Database.Napredak>();

            CreateMap<Database.Komentari, Model.Komentari>();
            CreateMap<Model.Requests.KomentariInsertRequest, Database.Komentari>();
            CreateMap<Model.Requests.KomentariUpdateRequest, Database.Komentari>();

            CreateMap<Database.Aktivnosti, Model.Aktivnosti>();
            CreateMap<Model.Requests.AktivnostiInsertRequest, Database.Aktivnosti>();
            CreateMap<Model.Requests.AktivnostiUpdateRequest, Database.Aktivnosti>();


            CreateMap<Database.Raspored, Model.Raspored>();
            CreateMap<Model.Requests.RasporedInsertRequest, Database.Raspored>();
            CreateMap<Model.Requests.RasporedUpdateRequest, Database.Raspored>();


            CreateMap<Database.Recommender, Model.Responses.RecommenderResult>();
            CreateMap<Database.Recommender, Model.Recommender>();

            CreateMap<Model.Requests.RecommenderInsertRequest, Database.Recommender>();
            CreateMap<Model.Requests.RecommenderUpdateRequest, Database.Recommender>();

            CreateMap<Database.PregledaneNovosti, Model.PregledaneNovosti>();
            CreateMap<Model.Requests.PregledaneNovostiInsertRequest, Database.PregledaneNovosti>();
            CreateMap<Model.Requests.PregledaneNovostiUpdate, Database.PregledaneNovosti>();




        }
    }
}
