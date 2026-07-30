import { ChangeDetectionStrategy, Component, inject, signal } from '@angular/core';
import {
    FusionButtonComponent,
    FusionGridCellComponent,
    FusionGridContainerComponent,
    FusionGridRowComponent,
    FusionPageBaseComponent
} from '@fusion/ngx-fusion';
import { PublicTextService } from '../../services/public-text/public-text.service';

@Component({
    changeDetection: ChangeDetectionStrategy.OnPush,
    imports: [FusionButtonComponent, FusionGridCellComponent, FusionGridContainerComponent, FusionGridRowComponent],
    selector: 'app-home',
    standalone: true,
    templateUrl: './home.component.html',
    styleUrls: ['./home.component.scss']
})
export class HomeComponent extends FusionPageBaseComponent {
    private readonly _publicTextService = inject(PublicTextService);

    protected readonly publicText = signal('');

    protected async loadPublicText(): Promise<void> {
        const response = await this._publicTextService.get();
        this.publicText.set(response.message);
    }
}
