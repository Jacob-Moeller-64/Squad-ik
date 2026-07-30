import { Component } from '@angular/core';
import { FusionAppComponent, FusionFooterComponent, FusionHeaderComponent } from '@fusion/ngx-fusion';

@Component({
    imports: [FusionAppComponent, FusionFooterComponent, FusionHeaderComponent],
    selector: 'app-root',
    standalone: true,
    styleUrls: ['./app.component.scss'],
    templateUrl: './app.component.html'
})
export class AppComponent {}
