import { AttendanceSummary } from './AttendanceSummary';
import { MeetingSummary } from './MeetingSummary';
import { DevelopmentSummary } from './DevelopmentSummary';

export interface ParticipantSnapshot {
  participantId: number;
  overallGpa?: number;
  scienceGpa?: number;
  mathScienceGpa?: number;
  attendance: AttendanceSummary;
  meetings: MeetingSummary;
  development: DevelopmentSummary;
  activeAlerts: number;
}
