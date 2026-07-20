import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';

@Component({
  preserveWhitespaces: true,
  selector: 'app-nav',
  standalone: true,
  imports: [RouterLink],
  templateUrl: './nav.component.html',
  styleUrls: ['./nav.component.css']
})
export class NavComponent { }
