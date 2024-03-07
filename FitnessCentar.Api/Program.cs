using FitnessCentar.Filters;
using FitnessCentar.Security;
using FitnessCentar.Services;
using FitnessCentar.Services.Database;
using FitnessCentar.Services.Interface;
using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;
using Stripe;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.


builder.Services.AddTransient<ITreningService, TreningService>();
builder.Services.AddTransient<IKorisniciService, KorisniciService>();
builder.Services.AddTransient<INovostiServices, NovostiService>();
builder.Services.AddTransient<ITrenerService, TrenerService>();
builder.Services.AddTransient<IAktivnostiService, AktivnostiService>();
builder.Services.AddTransient<IOdgovoriNaKomentareService, OdgovoriNaKomentareService>();
builder.Services.AddTransient<IKomentariService, KomentariService>();
builder.Services.AddTransient<IPlacanjeService, PlacanjeServices>();
builder.Services.AddTransient<IRasporedService, RasporedService>();
builder.Services.AddTransient<IRezervacijaService, RezervacijaService>();
builder.Services.AddTransient<IRecommenderService, RecommenderService>();
builder.Services.AddTransient<IPregledaneNovosti, PregledaneNovostiService>();
builder.Services.AddTransient<INapredakService, NapredakService>();
builder.Services.AddScoped<IRabbitMQProducer, RabbitMQProducer>();




//builder.Services.AddTransient<IService<FitnessCentar.Model.Korisnici,object>,BasedService<FitnessCentar.Model.Korisnici,FitnessCentar.Services.Database.Korisnici,object>>();



builder.Services.AddControllers(
    x =>
    {
        x.Filters.Add<ErrorFilter>();
    }


    );
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(
    c =>
{
    c.AddSecurityDefinition("basicAuth", new Microsoft.OpenApi.Models.OpenApiSecurityScheme()
    {
        Type = Microsoft.OpenApi.Models.SecuritySchemeType.Http,
        Scheme = "basic"
    });
    c.AddSecurityRequirement(new Microsoft.OpenApi.Models.OpenApiSecurityRequirement()
    {
        {
            new OpenApiSecurityScheme()
            {
                Reference=new OpenApiReference{Type=ReferenceType.SecurityScheme,Id ="basicAuth"}
            },
            new string[]{}
        }
    });
}
);
builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<Ib200005rs2Context>(options =>
    options.UseSqlServer(connectionString));

//builder.Services.AddAutoMapper(typeof(IKorisniciService));
builder.Services.AddAuthentication("BasicAuthentication")
 .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);

var app = builder.Build();
app.UseHttpLogging();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

//app.UseHttpsRedirection();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

using (var scope = app.Services.CreateScope())
{
    var dataContext = scope.ServiceProvider.GetRequiredService<Ib200005rs2Context>();

    if (!dataContext.Database.CanConnect())
    {
        dataContext.Database.Migrate();

        var recommendResutService = scope.ServiceProvider.GetRequiredService<IRecommenderService>();
        try
        {
            await recommendResutService.TrainNovostiModelAsync();
        }
        catch (Exception)
        {

        }
    }
}
StripeConfiguration.ApiKey = "sk_test_51OKr40BH5DqSsJZplYyDKDiAxawWPMWYG0JGrg5ZnVutsPQFRGD14YdbuwKkKQPsWa3ULdlRe05JvcY2yndIsbc400BT4GyLwo";

app.Run();
