export interface Alert {
  alertId: number;
  participantId: number;
  alertType: string;
  severity: 'Low' | 'Medium' | 'High' | 'Critical';
  resolved: boolean;
}
