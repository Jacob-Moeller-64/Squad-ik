import { FusionRoutes } from '@fusion/ngx-fusion';
import { HomeComponent } from './pages/home/home.component';
import { CommonComponentsComponent } from './pages/common-components/common-components.component';
import { codeIcon, formElementIcon, homeIcon } from '@progress/kendo-svg-icons';

export const routes: FusionRoutes = {
    routes: [
        {
            path: 'home',
            component: HomeComponent,
            menu: {
                icon: homeIcon,
                label: 'Home',
                routerLink: 'home'
            }
        },
        {
            path: 'test-datastore',
            loadComponent: () => import('./pages/test-datastore/test-datastore.component').then((mod) => mod.TestDatastoreComponent),
            menu: {
                icon: codeIcon,
                label: 'Test Datastore',
                routerLink: 'test-datastore'
            }
        },
        {
            path: 'my-entity',
            loadComponent: () => import('./pages/my-entity/my-entity.component').then((mod) => mod.MyEntityComponent),
            menu: {
                icon: formElementIcon,
                label: 'My Entity',
                routerLink: 'my-entity'
            }
        },
        {
            path: 'common-components',
            component: CommonComponentsComponent,
            menu: {
                icon: codeIcon,
                label: 'Common Components',
                routerLink: 'common-components'
            }
        },
        // This stays at the bottom
        {
            path: '**',
            redirectTo: 'home'
        }
    ]
};
