using API.Interface;
using API.Services;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddSingleton<ISingleton, Services>();
builder.Services.AddScoped<IScoped, Services>();
builder.Services.AddTransient<ITransient, Services>();

builder.WebHost.ConfigureKestrel(serverOptions =>
{
    serverOptions.ListenAnyIP(80); // Ensure it's listening on port 80
});


var app = builder.Build();

app.UseHttpsRedirection();

app.MapGet("/doit", (ISingleton singletonService, IScoped scopedServices1, IScoped scopedServices2, ITransient transientService1, ITransient transientService2) =>
{

    return new 
    {
        singletonService = singletonService.Value(),
        scopedServices1 = scopedServices1.Value(),
        scopedServices2 = scopedServices2.Value(),
        transientService1 = transientService1.Value(),
        transientService2 = transientService2.Value()
    };
});

app.MapGet("/test", () => "API is working!");

app.Run();
