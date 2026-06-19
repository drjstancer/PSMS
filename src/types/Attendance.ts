export interface Attendance {
  attendanceId: number;
  participantId: number;
  eventId: number;
  attendanceStatus: 'Attended' | 'Excused' | 'Unexcused' | 'No Show';
}
