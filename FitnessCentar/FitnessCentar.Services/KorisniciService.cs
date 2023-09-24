using AutoMapper;
using Azure.Core;
using FitnessCentar.Model.Requests;
using FitnessCentar.Model.SearchObject;
using FitnessCentar.Services.Database;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System;
using System.CodeDom.Compiler;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;



namespace FitnessCentar.Services
{
    public class KorisniciService : BasedService<Model.Korisnici, Database.Korisnici, KorisniciSearchObject, KorisniciInsertRequest, KorisniciUpdateRequest>, IKorisniciService
    {

        public KorisniciService(Ib200005rs2Context context, IMapper mapper) : base(context, mapper)
        {

        }

        public override async Task<Model.Korisnici> Insert(KorisniciInsertRequest request)
        {
            var entity = _mapper.Map<Database.Korisnici>(request);
            _context.Add(entity);


            entity.LozinkaSalt = GenerateSalt();
            entity.LozinkaHash = GenerateHash(entity.LozinkaSalt, request.Lozinka);
            _context.SaveChanges();

            return _mapper.Map<Model.Korisnici>(entity);
        }

        public static byte[] GenerateSalt()
        {
            var buf = new byte[16];
            (new RNGCryptoServiceProvider()).GetBytes(buf);
            //   return Convert.ToBase64String(buf);
            return buf;
        }
        public static byte[] GenerateHash(byte[] src, string password)
        {

            byte[] bytes = Encoding.Unicode.GetBytes(password);
            byte[] dst = new byte[src.Length + bytes.Length];

            System.Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            System.Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);

            HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
            byte[] inArray = algorithm.ComputeHash(dst);
            //   return Convert.ToBase64String(inArray);
            return inArray;
        }
        public Model.Korisnici Authenticiraj(string username, string pass)
        {
            var result = _context.Korisnicis.Where(x => x.KorisnickoIme == username);
            result = IncludeUserDetails(result);

            var user = result.FirstOrDefault();
            if (user != null)
            {
                var newHash = GenerateHash(user.LozinkaSalt, pass);

                if (ByteArrayCompare(newHash, user.LozinkaHash))
                {
                    return _mapper.Map<Model.Korisnici>(user);
                }

            }
            return null;
        }

        static bool ByteArrayCompare(byte[] a1, byte[] a2)
        {
            if (a1.Length != a2.Length)
                return false;

            for (int i = 0; i < a1.Length; i++)
                if (a1[i] != a2[i])
                    return false;

            return true;
        }
        public override async Task<List<Model.Korisnici>> Get(KorisniciSearchObject? search = null)
        {
            var query = _context.Set<Database.Korisnici>().AsQueryable();

            query = AddFilter(query, search);
            query = IncludeUserDetails(query);

            if (search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                query = query.Take(search.PageSize.Value).Skip(search.Page.Value * search.PageSize.Value);
            }

            var list = await query.ToListAsync();

            return _mapper.Map<List<Model.Korisnici>>(list);
            
        }
        public override IQueryable<Korisnici> AddFilter(IQueryable<Korisnici> query, KorisniciSearchObject? search = null)
        {
            if (search?.IsTrener ?? false)
            {
                query = query.Where(x => x.Trener != null);

            }
            else
            {
                query = query.Where(x => x.Trener == null);
            }
            return base.AddFilter(query, search);
        }
        private static IQueryable<Korisnici> IncludeUserDetails(IQueryable<Korisnici> query)
        {
            return query.Include(x => x.Trener);

        }

    }
}
