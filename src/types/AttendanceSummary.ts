export interface AttendanceSummary {
  requiredEvents: number;
  attended: number;
  excused: number;
  unexcused: number;
  attendanceRate: number;
}
