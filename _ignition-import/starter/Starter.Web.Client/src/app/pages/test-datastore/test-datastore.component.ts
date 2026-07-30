import { CommonModule } from '@angular/common';
import { Component, inject, OnInit, signal } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { FusionButtonComponent, FusionGridCellComponent, FusionGridContainerComponent, FusionGridRowComponent, FusionPageBaseComponent, FusionTextareaComponent } from '@fusion/ngx-fusion';
import { TestDatastoreService } from '../../services/test-datastore/test-datastore.service';

@Component({
    imports: [
        CommonModule,
        FormsModule,
        FusionTextareaComponent,
        FusionGridCellComponent,
        FusionGridContainerComponent,
        FusionGridRowComponent,
        FusionButtonComponent,
    ],
    selector: 'app-test-datastore',
    standalone: true,
    templateUrl: './test-datastore.component.html',
    styleUrls: ['./test-datastore.component.scss']
})
export class TestDatastoreComponent extends FusionPageBaseComponent implements OnInit {
    private readonly _datastore = inject(TestDatastoreService);
    private readonly _payload = signal('');
    private readonly _storedText = signal<string | null>(null);
    private readonly _isLoading = signal(false);
    private readonly _isSaving = signal(false);

    get payloadValue(): string {
        return this._payload();
    }

    set payloadValue(value: string) {
        this._payload.set(value);
    }

    get displayedText(): string {
        const text = this._storedText();
        return text ? text : 'No value has been saved yet.';
    }

    get isLoading(): boolean {
        return this._isLoading();
    }

    get isSaving(): boolean {
        return this._isSaving();
    }

    override ngOnInit(): void {
        void this.loadStoredText();
    }

    async loadStoredText(): Promise<void> {
        this._isLoading.set(true);
        try {
            const text = await this._datastore.get();
            this._storedText.set(text);
        } finally {
            this._isLoading.set(false);
        }
    }

    async saveText(): Promise<void> {
        this._isSaving.set(true);
        try {
            await this._datastore.set(this._payload());
            this._payload.set('');
            await this.loadStoredText();
        } finally {
            this._isSaving.set(false);
        }
    }
}