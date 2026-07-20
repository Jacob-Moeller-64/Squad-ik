// All API payloads are PascalCase (MVC5 JsonResult casing preserved by the
// modern API: PropertyNamingPolicy = null). Do not camelCase these — the
// goldens in artifacts/goldens/ pin this casing.

export interface WorkOrder {
  Id: string;
  Title: string;
  Status: string;
  Priority: string;
  Site: string;
}

export interface Technician {
  Id: number;
  Name: string;
  Skill: string;
  Region: string;
}

export interface Invoice {
  InvoiceId: string;
  IssuedAt: string;
  TotalCents: number;
}

export interface CreateWorkOrderRequest {
  Title: string;
  Priority: string;
  ContractTier: string;
  Weekend: boolean;
}

export interface CreateWorkOrderResult {
  WorkOrderId: string;
  Title: string;
  Priority: string;
  DueInHours: number;
}

export interface AssignRequest {
  WorkOrderId: string;
  TechnicianId: number;
}

export interface AssignResult {
  TechnicianId: number;
  WorkOrderId: string;
  ActiveLoad: number;
}

export interface QuoteRequest {
  LaborHours: number;
  HourlyRateCents: number;
  PartsCents: number[];
  Visits: number;
}

export interface QuoteResult {
  LaborCents: number;
  PartsCents: number;
  TravelCents: number;
  TaxCents: number;
  TotalCents: number;
}

export interface ApiError {
  Error: string;
}

/** Extracts the PascalCase Error message from an HTTP error body, like the
 *  legacy `(res.data && res.data.Error) || fallback` pattern. */
export function apiError(err: unknown, fallback: string): string {
  if (err && typeof err === 'object' && 'error' in err) {
    const body = (err as { error: unknown }).error;
    if (body && typeof body === 'object' && 'Error' in body) {
      const message = (body as ApiError).Error;
      if (typeof message === 'string' && message) {
        return message;
      }
    }
  }
  return fallback;
}
