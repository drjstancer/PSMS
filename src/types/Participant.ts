export interface Participant {
  participantId: number;
  muId?: string;
  pawPrint?: string;
  firstName: string;
  lastName: string;
  institution?: string;
  classification?: string;
  intendedEnteringClassYear?: number;
  participantStatus: string;
}
