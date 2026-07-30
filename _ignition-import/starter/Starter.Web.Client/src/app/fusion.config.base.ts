import { FusionConfig } from '@fusion/ngx-fusion';
import {} from '@fusion/ngx-fusion-auth-oauth-okta';

export const fusionConfigBase: FusionConfig = {
    api: {
        baseUrl: ''
    },
    auth: {
        clientId: '<OKTA_CLIENT_ID>',
        cookies: {
            secure: true
        },
        devMode: true,
        issuer: '<OKTA_ISSUER_URL>',
        logoutUrl: 'https://localhost:5001/logout/callback',
        pkce: true,
        redirectUri: 'https://localhost:5001/login/callback',
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
    theme: 'system'
};
