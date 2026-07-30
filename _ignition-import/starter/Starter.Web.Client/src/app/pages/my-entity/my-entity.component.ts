import { CommonModule } from '@angular/common';
import { Component, inject, OnInit, signal } from '@angular/core';
import { FormControl, FormGroup, ReactiveFormsModule, Validators } from '@angular/forms';
import {
    FusionBlockGridCellComponent,
    FusionBlockGridContainerComponent,
    FusionBlockGridRowComponent,
    FusionButtonComponent,
    FusionGridCellComponent,
    FusionGridContainerComponent,
    FusionGridRowComponent,
    FusionPageBaseComponent,
    FusionTextboxComponent
} from '@fusion/ngx-fusion';
import { MyEntitiesService } from '../../services/my-entities/my-entities.service';
import { MyEntity } from '../../types';

@Component({
    imports: [
        CommonModule,
        FusionBlockGridCellComponent,
        FusionBlockGridContainerComponent,
        FusionBlockGridRowComponent,
        FusionButtonComponent,
        FusionGridCellComponent,
        FusionGridContainerComponent,
        FusionGridRowComponent,
        FusionTextboxComponent,
        ReactiveFormsModule
    ],
    selector: 'app-my-entity',
    standalone: true,
    templateUrl: './my-entity.component.html',
    styleUrls: ['./my-entity.component.scss']
})
export class MyEntityComponent extends FusionPageBaseComponent implements OnInit {
    entities = signal<MyEntity[]>([]);
    entityForm = new FormGroup({
        id: new FormControl<string | null>(null),
        name: new FormControl<string | null>(null, Validators.required),
        description: new FormControl<string | null>(null)
    });

    private readonly _myEntities = inject(MyEntitiesService);

    edit(entity: MyEntity): void {
        this.entityForm.setValue(entity);
    }

    override ngOnInit(): void {
        void this.refresh();
    }

    async refresh(): Promise<void> {
        this.entities.set(await this._myEntities.get());
    }

    async submitEntity(): Promise<void> {
        if (this.entityForm.invalid) {
            this.entityForm.markAllAsTouched();
            return;
        }

        await this._myEntities.save(this.entityForm.value as MyEntity);

        this.entities.set(await this._myEntities.get());
        this.entityForm.reset();
    }
}
