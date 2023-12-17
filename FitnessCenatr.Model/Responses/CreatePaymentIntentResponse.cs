using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FitnessCentar.Model.Responses
{
    public class CreatePaymentIntentResponse
    {
        public string Id { get; set; }
        public string ClientSecret { get; set; }

    }
}
