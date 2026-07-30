using System;
using Fusion.Fx.App;
using Microsoft.Extensions.DependencyInjection;

namespace Fusion.Fx.App.Web;

/// <summary>
/// Example-specific Fusion builder extensions.
/// </summary>
public static class FusionWebBuilderExtensions
{
    /// <summary>
    /// Wires up the application services, including the PostgreSQL-backed entity repositories.
    /// </summary>
    public static IFusionWebBuilder AddMyApplication(this IFusionWebBuilder fusionWebBuilder)
    {
        fusionWebBuilder.AddMyLibrary();
        return fusionWebBuilder;
    }
}
