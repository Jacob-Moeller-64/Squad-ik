import { provideHttpClient, withFetch, withInterceptors } from '@angular/common/http';
import { ApplicationConfig, EnvironmentProviders, Provider } from '@angular/core';
import { provideAnimationsAsync } from '@angular/platform-browser/animations/async';
import { UrlSerializer, provideRouter, withDisabledInitialNavigation, withInMemoryScrolling } from '@angular/router';
import {
    FUSION_CONFIG,
    FUSION_ROUTES,
    FusionHttpFromApiDateConverterInterceptorFn,
    FusionUrlSerializer,
    PACKAGE_INFO,
    provideNgxFusion
} from '@fusion/ngx-fusion';
import * as pack from '../../package.json';
import { fusionConfig } from './fusion.config';
import { routes } from './routes.config';
import { provideNgxFusionAuthOAuthOkta } from '@fusion/ngx-fusion-auth-oauth-okta';

export const appConfig: ApplicationConfig = {
    providers: createProviders()
};

function createProviders(): (Provider | EnvironmentProviders)[] {
    const providers = [
        provideAnimationsAsync(),
        provideHttpClient(withFetch(), withInterceptors([FusionHttpFromApiDateConverterInterceptorFn])),
        provideNgxFusion(),
        provideNgxFusionAuthOAuthOkta(),
        // withDisabledInitialNavigation - push initial route navigation until after initialization code completes
        // withInMemoryScrolling - allows anchor scrolling (https://localhost/home#id)
        provideRouter(routes.routes, withDisabledInitialNavigation(), withInMemoryScrolling({ anchorScrolling: 'enabled' })),
        {
            provide: FUSION_CONFIG,
            useValue: fusionConfig
        },
        {
            provide: FUSION_ROUTES,
            useValue: routes
        },
        {
            provide: PACKAGE_INFO,
            useValue: pack
        },
        {
            provide: UrlSerializer,
            useClass: FusionUrlSerializer
        }
    ];

    return providers;
}
