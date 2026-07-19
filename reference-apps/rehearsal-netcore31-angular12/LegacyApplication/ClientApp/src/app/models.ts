export interface Product {
  id: number;
  name: string;
  category: string;
  unitPriceCents: number;
  inStock: boolean;
  stockQty: number;
}

export interface OrderLine {
  productId: number;
  quantity: number;
  unitPriceCents: number;
}

export interface ShipTo {
  region: string;
}

export interface OrderRequest {
  lines: OrderLine[];
  promoCode: string;
  shipTo: ShipTo;
}

export interface OrderResult {
  orderId: number | string;
  subtotalCents: number;
  discountPercent: number;
  discountCents: number;
  shippingCents: number;
  totalCents: number;
}

export interface OrderHistoryItem {
  orderId: number | string;
  placedAt: string;
  totalCents: number;
}

export interface LoginResult {
  ok: boolean;
  user: string;
}
