using AutoMapper;
using FitnessCentar.Model.Requests;
using FitnessCentar.Services.Database;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;



namespace FitnessCentar.Services
{
    public class KorisniciService : IKorisniciService
    {
        Ib200005rs2Context _context;
        public IMapper _mapper { get; set; }

        public KorisniciService(Ib200005rs2Context context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }


        public List<Model.Korisnici> Get()
        {
            var entitylist = _context.Korisnicis.ToList();
            return _mapper.Map<List<Model.Korisnici>>(entitylist);
        }

        public Model.Korisnici Insert(KorisniciInsertRequest request)
        {
            var korisnik = new Korisnici();
            _mapper.Map(request, korisnik);

            _context.Korisnicis.Add(korisnik);
            _context.SaveChanges();
            return _mapper.Map<Model.Korisnici>(korisnik);
        }


        public static string GenerateSalt()
        {
            RNGCryptoServiceProvider provider = new RNGCryptoServiceProvider();
            var byteArray = new byte[16];
            provider.GetBytes(byteArray);


            return Convert.ToBase64String(byteArray);
        }
        public static string GenerateHash(string salt, string password)
        {
            byte[] src = Convert.FromBase64String(salt);
            byte[] bytes = Encoding.Unicode.GetBytes(password);
            byte[] dst = new byte[src.Length + bytes.Length];

            System.Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            System.Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);

            HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
            byte[] inArray = algorithm.ComputeHash(dst);
            return Convert.ToBase64String(inArray);
        }
        public Model.Korisnici Update(int id, KorisniciUpdateRequest request)
        {
            var entity = _context.Korisnicis.Find(id);
            _mapper.Map(request,entity);

            _context.SaveChanges();
            return _mapper.Map<Model.Korisnici>(entity);
        }

    }
}
