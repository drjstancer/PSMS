export interface Meeting {
  meetingId: number;
  participantId: number;
  programId: number;
  staffId: number;
  meetingDate: string;
  meetingType: string;
  followUpNeeded: boolean;
  followUpDate?: string;
}
