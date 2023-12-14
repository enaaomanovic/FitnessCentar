using FitnessCentar.Model.Requests;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Stripe;
using FitnessCentar.Model.Responses;

namespace FitnessCentar.Controllers
{

    [ApiController]
    public class PaymentIntentController : ControllerBase
    {

        [HttpPost ("[controller]/createPaymentIntent")]
        public async Task<ActionResult<CreatePaymentIntentResponse>> CreatePaymentIntent([FromBody] CreatePaymentIntentRequest request)
        {
            var service = new PaymentIntentService();
            var options = new PaymentIntentCreateOptions
            {
                Amount = request.Amount,
                Currency = "BAM",
            };
            var paymentIntent = await service.CreateAsync(options);
            return new CreatePaymentIntentResponse()
            {
                Id = paymentIntent.Id,
                ClientSecret = paymentIntent.ClientSecret
            };
        }


    }
}
