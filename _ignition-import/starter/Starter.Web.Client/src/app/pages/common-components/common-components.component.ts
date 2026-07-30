import { Component, OnInit } from '@angular/core';
import {
    FusionGridCellComponent,
    FusionGridContainerComponent,
    FusionGridRowComponent,
    FusionPageBaseComponent
} from '@fusion/ngx-fusion';

@Component({
    imports: [FusionGridCellComponent, FusionGridContainerComponent, FusionGridRowComponent],
    selector: 'app-common-components',
    standalone: true,
    templateUrl: './common-components.component.html',
    styleUrls: ['./common-components.component.scss']
})
export class CommonComponentsComponent extends FusionPageBaseComponent implements OnInit {}
