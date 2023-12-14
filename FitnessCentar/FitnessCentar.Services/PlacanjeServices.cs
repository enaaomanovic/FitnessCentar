using AutoMapper;
using FitnessCentar.Model.Requests;
using FitnessCentar.Model.SearchObject;
using FitnessCentar.Services.Base;
using FitnessCentar.Services.Database;
using FitnessCentar.Services.Interface;
using Stripe;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Services
{
    public class PlacanjeServices : BaseService<Model.Placanja, Database.Placanja, PlacanjaSearchObject, PlacanjaInsertRequest, PlacanjaUpdateRequest>, IPlacanjeService
    {
        public PlacanjeServices(Ib200005rs2Context context, IMapper mapper) : base(context, mapper)
        {
        }

        public async override Task<Model.Placanja> Insert(PlacanjaInsertRequest insert)
        {
            string? transactionId = null;
            long iznosPlacanja=0;
            var charges = await getChargesByIntent(insert.PaymentIntentId!);
            foreach(var charge in charges.Data)
            {
                if (charge.Captured)
                {
                    transactionId = charge.BalanceTransactionId;
                    iznosPlacanja = charge.AmountCaptured/100;
                    break;
                }
            }
            if(transactionId is null) {
                throw new Exception("Transkacijski id null");
            }
            var set = _context.Set<Database.Placanja>();
            Database.Placanja entity = _mapper.Map<Database.Placanja>(insert);
            entity.TxnId = transactionId;
            set.Add(entity);
            List<Rezervacije> mojerezervacijes = _context.Rezervacijes
                .Where(x => x.KorisnikId == insert.KorisnikId && x.Status=="Aktivna").Take((int)iznosPlacanja/15)
                .ToList();
            foreach(var mojerezervacije in mojerezervacijes)
            {
                mojerezervacije.Status = "Plaćena";
                mojerezervacije.Placanje = entity;
            }
         

            await _context.SaveChangesAsync();

            return _mapper.Map<Model.Placanja>(entity);
        }

        private async Task<StripeList<Charge>> getChargesByIntent(string paymentIntentId)
        {
            var service = new ChargeService();
            var options = new ChargeListOptions()
            {
                PaymentIntent = paymentIntentId,
            };
            var list = await service.ListAsync(options);
            return list;
        }
        public override IQueryable<Placanja> AddFilter(IQueryable<Placanja> query, PlacanjaSearchObject? search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (search.korisnikId != null)
            {


                filteredQuery = filteredQuery.Where(x => x.KorisnikId ==search.korisnikId);
            }

            return filteredQuery;
        }
    }
}
