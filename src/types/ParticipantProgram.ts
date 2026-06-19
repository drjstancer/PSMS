export interface ParticipantProgram {
  participantProgramId: number;
  participantId: number;
  programId: number;
  participantTypeId?: number;
  cohortId?: number;
  participationStatus: string;
}
