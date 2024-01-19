using AutoMapper;
using Azure.Core;

using FitnessCentar.Model.Requests;
using FitnessCentar.Model.Responses;
using FitnessCentar.Model.SearchObject;
using FitnessCentar.Services.Base;
using FitnessCentar.Services.Database;
using FitnessCentar.Services.Interface;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System;
using System.CodeDom.Compiler;
using System.Collections.Generic;
using System.Linq;
using System.Security.Authentication;
using System.Security.Cryptography;
using System.Text;
using System.Threading;
using System.Threading.Tasks;



namespace FitnessCentar.Services
{
    public class KorisniciService : BaseService<Model.Korisnici, Database.Korisnici, KorisniciSearchObject, KorisniciInsertRequest, KorisniciUpdateRequest>, IKorisniciService
    {
        private readonly IRabbitMQProducer _rabbitMQProducer;
      
        public KorisniciService(Ib200005rs2Context context, IMapper mapper, IRabbitMQProducer rabbitMQProducer) : base(context, mapper)
        {
            _rabbitMQProducer = rabbitMQProducer;
        

        }

        public override async Task<Model.Korisnici> Insert(KorisniciInsertRequest request)
        {

            var entity = _mapper.Map<Database.Korisnici>(request);
            _context.Add(entity);


            entity.LozinkaSalt = GenerateSalt();
            entity.LozinkaHash = GenerateHash(entity.LozinkaSalt, request.Lozinka);
            _context.SaveChanges();
            Model.EmailModel emailModel = new()
            {
                Content = "Srdačno vas pozdravljamo u ime Fitnes Centra! Radujemo se što ste odabrali naš centar kao svoj prostor za postizanje svojih fitnes ciljeva.Trudimo se pružiti vam najbolje iskustvo i podršku na vašem putu ka zdravijem i aktivnijem životu. Naš tim stručnih trenera,moderna oprema i raznovrsni treninzi stvoreni su kako bismo vam omogućili inspirativno okruženje za postizanje vaših ciljeva.",
                Recipient = request.Email,
                Sender = "fitnesscentar25@gmail.com",
                Subject = "Poruka dobrodošlice"

            };
            _rabbitMQProducer.SendMessage(emailModel);

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
        public override async Task<PageResult<Model.Korisnici>> GetPage(KorisniciSearchObject? search = null)
        {

            var query = _context.Set<Database.Korisnici>().AsQueryable();

            var respons = new Model.Responses.PageResult<Model.Korisnici>();
            query = AddFilter(query, search);
            query = AddInclude(query);
            query = IncludeUserDetails(query);

            if (search?.Page is not null && search?.PageSize is not null)
            {


                var list = await query
                    .Skip((int)((search.Page - 1) * search.PageSize))
                    .Take((int)search.PageSize)
                    .ToListAsync();

                respons.Result = _mapper.Map<List<Model.Korisnici>>(list);


            }

            respons.Count = query.Count();

            return respons;
        }

        public virtual async Task<List<Korisnici>> Get(KorisniciSearchObject? search = null)
        {
            var query = _context.Set<Database.Korisnici>().AsQueryable();

            query = AddFilter(query, search);
            query = AddInclude(query);
            query = IncludeUserDetails(query);


            var list = await query.ToListAsync();

            return _mapper.Map<List<Korisnici>>(list);
        }


        public override IQueryable<Korisnici> AddInclude(IQueryable<Korisnici> query)
        {
            query = query.Include(x => x.Trener);
            return query;
        }
        public override async Task<Model.Korisnici> GetById(int id)
        {
            var query = _context.Korisnicis.Where(x => x.Id == id).AsQueryable();
            query = AddInclude(query);
            var entity = await query.FirstOrDefaultAsync();

            return _mapper.Map<Model.Korisnici>(entity);
        }

        public override IQueryable<Korisnici> AddFilter(IQueryable<Korisnici> query, KorisniciSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (search != null)
            {
                if (search.IsTrener)
                {
                    filteredQuery = filteredQuery.Where(x => x.Trener != null);
                }
                else
                {
                    filteredQuery = filteredQuery.Where(x => x.Trener == null);
                }

                if (!string.IsNullOrWhiteSpace(search.FTS))
                {
                    var ftsFilter = search.FTS.ToLower();
                    filteredQuery = filteredQuery.Where(x =>
                        x.Ime.ToLower().Contains(ftsFilter) ||
                        x.Prezime.ToLower().Contains(ftsFilter)
                    );
                }
            }

            return filteredQuery;
        }

        private static IQueryable<Korisnici> IncludeUserDetails(IQueryable<Korisnici> query)
        {
            return query.Include(x => x.Trener);

        }


        public async Task ChangePasswordAsync(KorisniciChangePassword userChangePass)
        {
            var user = await _context.Korisnicis.FindAsync(userChangePass.Id);

            if (user == null)
                throw new ($"User with ID {userChangePass.Id} not found.");

            if (!ByteArrayCompare(user.LozinkaHash, GenerateHash(user.LozinkaSalt, userChangePass.Password)))
                throw new ("Invalid password.");

            user.LozinkaSalt = GenerateSalt();
            user.LozinkaHash = GenerateHash(user.LozinkaSalt, userChangePass.NewPassword);

            _context.Update(user);
            await _context.SaveChangesAsync();
        }

        public async Task ChangeUsernameAsync(KorisniciChangeUsername userChangeUsername)
        {
            var user = await _context.Korisnicis.FindAsync(userChangeUsername.Id);

            if (user == null)
                throw new($"User with ID {userChangeUsername.Id} not found.");

            // You might want to add additional checks for username uniqueness, format, etc.

            user.KorisnickoIme = userChangeUsername.NewUsername;

            _context.Update(user);
            await _context.SaveChangesAsync();
        }





    }
}