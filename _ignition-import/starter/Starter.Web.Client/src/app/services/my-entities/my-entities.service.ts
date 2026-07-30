import { inject, Injectable } from '@angular/core';
import { FusionHttpService } from '@fusion/ngx-fusion';
import { MyEntity } from '../../types';

@Injectable({
    providedIn: 'root'
})
export class MyEntitiesService {
    private readonly _fusionHttp = inject(FusionHttpService);

    async get(): Promise<MyEntity[]> {
        return (await this._fusionHttp.get<MyEntity[]>('MyEntities', { useCache: false })) ?? [];
    }

    async save(entity: MyEntity, actionName?: string): Promise<string> {
        let id: string;
        if (entity.id) {
            await this._fusionHttp.put(entity, `MyEntities/${entity.id}`, { actionName: actionName });
            id = entity.id;
        } else {
            id = await this._fusionHttp.post(entity, 'MyEntities', { actionName: actionName });
        }

        return id;
    }
}
