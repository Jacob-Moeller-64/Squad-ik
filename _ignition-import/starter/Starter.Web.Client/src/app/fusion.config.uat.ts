import { FusionConfig } from '@fusion/ngx-fusion';
import { fusionConfigBase } from './fusion.config.base';

export const fusionConfig: FusionConfig = {
    ...fusionConfigBase,
    api: {
        baseUrl: '/api'
    }
};
