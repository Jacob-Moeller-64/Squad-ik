import { FusionConfig } from '@fusion/ngx-fusion';
import {} from '@fusion/ngx-fusion-auth-oauth-okta';
import { fusionConfigBase } from './fusion.config.base';

// const apiBaseUrl = `${window.location.origin}/api`;

export const fusionConfig: FusionConfig = {
    ...fusionConfigBase,
    api: {
        baseUrl: '/api'
    },
    auth: {
        authenticateOnStart: false,
        clientId: '<OKTA_CLIENT_ID_DVL>',
        cookies: {
            secure: true
        },
        devMode: true,
        issuer: '<OKTA_ISSUER_URL_DVL>',
        logoutUrl: 'https://<STARTER-DVL-HOST>/logout/callback',
        pkce: true,
        redirectUri: 'https://<STARTER-DVL-HOST>/login/callback',
        // authenticateOnStart: false,
        //     clientId: '<OKTA_CLIENT_ID_DVL>',
        // cookies: {
        //     secure: true
        // },
        // devMode: true,
        // issuer: '<OKTA_ISSUER_URL_CORP>',
        // logoutUrl: 'https://<INTERNAL-APP-HOST>/logout/callback',
        // pkce: true,
        // redirectUri: 'https://<INTERNAL-APP-HOST>/login/callback',
        scopes: [
            'openid',
            'profile',
            'email',
            'address',
            'phone',
            'offline_access',
            'groups',
            'okta.clients.read',
            'okta.groups.read',
            'okta.myAccount.profile.read',
            'okta.profileMappings.read',
            'okta.userTypes.read',
            'okta.users.read',
            'okta.users.read.self'
        ],
        signInAttempts: 2
    },
    isDebug: true,
};
