using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Starter.Library.Options;
using Starter.Library.Services;

namespace Fusion.Fx.App;

public static class FusionApplicationBuilderExtensions
{
    public static IFusionApplicationBuilder AddMyLibrary(
        this IFusionApplicationBuilder fusionApplicationBuilder
    )
    {
        // Add Options to services
        fusionApplicationBuilder.Services.Configure<MyOptions>(
            fusionApplicationBuilder.Configuration.GetSection(MyOptions.ConfigSection)
        );

        // Add Library services
        fusionApplicationBuilder.Services.AddSingleton<IMyService, DefaultMyService>();
        fusionApplicationBuilder.Services.AddSingleton<
            IPublicTextService,
            DefaultPublicTextService
        >();

        return fusionApplicationBuilder;
    }
}

public static class AppConfiguration
{
    public static void Configure(
        IHostApplicationBuilder _,
        IConfigurationManager configurationManager
    ) =>
        // Set this last to override all other sources
        configurationManager.AddJsonFile("appsettings.Override.json", true);
}
