using AutoMapper;
using FitnessCentar.Model.Requests;
using FitnessCentar.Model.SearchObject;
using FitnessCentar.Services.Database;
using Stripe;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Services
{
    public class PlacanjeServices : BasedService<Model.Placanja, Database.Placanja, PlacanjaSearchObject, PlacanjaInsertRequest, PlacanjaUpdateRequest>, IPlacanjeService
    {
        public PlacanjeServices(Ib200005rs2Context context, IMapper mapper) : base(context, mapper)
        {
        }

        public async override Task<Model.Placanja> Insert(PlacanjaInsertRequest insert)
        {
            string? transactionId = null;
            var charges = await getChargesByIntent(insert.PaymentIntentId!);
            foreach(var charge in charges.Data)
            {
                if (charge.Captured)
                {
                    transactionId = charge.BalanceTransactionId;
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
            foreach (var rezervacijaId in insert.RezervacijeId)
            {
                var rezervacija = _context.Rezervacijes.Find(rezervacijaId);
                if(rezervacija != null)
                {
                    rezervacija.Placanje = entity;
                    rezervacija.Status = "Plaćena";
                }

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

    }
}
