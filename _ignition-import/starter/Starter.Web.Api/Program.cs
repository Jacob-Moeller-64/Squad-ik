using Fusion.Fx.App;
using Fusion.Fx.App.Web;

var builder = FusionWebBuilder.CreateBuilder(
    args,
    new FusionWebBuilderOptions() { Configure = AppConfiguration.Configure }
);

builder.AddMyApplication();

await builder.BuildAndRunAsync();
