import { inject, Injectable } from '@angular/core';
import { FusionHttpService } from '@fusion/ngx-fusion';
import { PublicTextResponse } from '../../types';

@Injectable({
    providedIn: 'root'
})
export class PublicTextService {
    private readonly _endpoint = 'PublicText';
    private readonly _fusionHttp = inject(FusionHttpService);

    async get(): Promise<PublicTextResponse> {
        return (await this._fusionHttp.get<PublicTextResponse>(this._endpoint, { useCache: false })) ?? { message: '' };
    }
}
