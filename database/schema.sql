-- PSMS Schema v0.2
-- Pathways Success Management System
-- Scope: participant success management, not admissions/application/interview tracking.

PRAGMA foreign_keys = ON;

-- ============================================================
-- Reference Tables
-- ============================================================

CREATE TABLE IF NOT EXISTS Institutions (
  InstitutionID INTEGER PRIMARY KEY AUTOINCREMENT,
  InstitutionName TEXT NOT NULL UNIQUE,
  InstitutionType TEXT CHECK (InstitutionType IN ('High School', 'College/University', 'Other')),
  City TEXT,
  State TEXT,
  ActiveStatus INTEGER NOT NULL DEFAULT 1,
  CreatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Programs (
  ProgramID INTEGER PRIMARY KEY AUTOINCREMENT,
  ProgramName TEXT NOT NULL UNIQUE,
  ProgramAbbreviation TEXT NOT NULL UNIQUE,
  ProgramStatus TEXT NOT NULL DEFAULT 'Active' CHECK (ProgramStatus IN ('Active', 'Inactive')),
  CreatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS ParticipantTypes (
  ParticipantTypeID INTEGER PRIMARY KEY AUTOINCREMENT,
  ProgramID INTEGER NOT NULL,
  ParticipantTypeName TEXT NOT NULL,
  ActiveStatus INTEGER NOT NULL DEFAULT 1,
  CreatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (ProgramID) REFERENCES Programs(ProgramID),
  UNIQUE (ProgramID, ParticipantTypeName)
);

CREATE TABLE IF NOT EXISTS Staff (
  StaffID INTEGER PRIMARY KEY AUTOINCREMENT,
  FirstName TEXT NOT NULL,
  LastName TEXT NOT NULL,
  Email TEXT NOT NULL UNIQUE,
  UserRole TEXT NOT NULL CHECK (UserRole IN ('Administrator', 'Program Coordinator', 'Program Advisor', 'Executive Leadership')),
  ProgramAffiliationID INTEGER,
  AssignedParticipantsAllowed INTEGER NOT NULL DEFAULT 0,
  ActiveStatus INTEGER NOT NULL DEFAULT 1,
  CreatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (ProgramAffiliationID) REFERENCES Programs(ProgramID)
);

-- ============================================================
-- Participant Core
-- ============================================================

CREATE TABLE IF NOT EXISTS Participants (
  ParticipantID INTEGER PRIMARY KEY AUTOINCREMENT,
  MUID TEXT,
  PawPrint TEXT UNIQUE,
  FirstName TEXT NOT NULL,
  LastName TEXT NOT NULL,
  PreferredName TEXT,
  Email TEXT,
  Phone TEXT,
  PermanentMailingAddress TEXT,
  LocalAddress TEXT,
  InstitutionID INTEGER,
  Major TEXT,
  Minor TEXT,
  Classification TEXT,
  ExpectedGraduationTerm TEXT,
  ExpectedGraduationYear INTEGER,
  IntendedEnteringClassYear INTEGER,
  ParticipantStatus TEXT NOT NULL DEFAULT 'Prospective' CHECK (ParticipantStatus IN ('Prospective', 'Active', 'Completed', 'Alumni', 'Inactive', 'Withdrawn')),
  AssignedCoordinatorID INTEGER,
  PrimaryAdvisorID INTEGER,
  CreatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (InstitutionID) REFERENCES Institutions(InstitutionID),
  FOREIGN KEY (AssignedCoordinatorID) REFERENCES Staff(StaffID),
  FOREIGN KEY (PrimaryAdvisorID) REFERENCES Staff(StaffID)
);

CREATE INDEX IF NOT EXISTS idx_participants_name ON Participants(LastName, FirstName);
CREATE INDEX IF NOT EXISTS idx_participants_pawprint ON Participants(PawPrint);
CREATE INDEX IF NOT EXISTS idx_participants_muid ON Participants(MUID);

-- ============================================================
-- Program Participation and Cohorts
-- ============================================================

CREATE TABLE IF NOT EXISTS Cohorts (
  CohortID INTEGER PRIMARY KEY AUTOINCREMENT,
  CohortCode TEXT NOT NULL UNIQUE,
  ProgramID INTEGER NOT NULL,
  IntendedEnteringClassYear INTEGER NOT NULL,
  CreatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (ProgramID) REFERENCES Programs(ProgramID),
  UNIQUE (ProgramID, IntendedEnteringClassYear)
);

CREATE TABLE IF NOT EXISTS ParticipantPrograms (
  ParticipantProgramID INTEGER PRIMARY KEY AUTOINCREMENT,
  ParticipantID INTEGER NOT NULL,
  ProgramID INTEGER NOT NULL,
  ParticipantTypeID INTEGER,
  ParticipationStatus TEXT NOT NULL DEFAULT 'Active' CHECK (ParticipationStatus IN ('Accepted', 'Active', 'Completed', 'Withdrawn')),
  StartDate TEXT,
  EndDate TEXT,
  CohortID INTEGER,
  CreatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (ParticipantID) REFERENCES Participants(ParticipantID),
  FOREIGN KEY (ProgramID) REFERENCES Programs(ProgramID),
  FOREIGN KEY (ParticipantTypeID) REFERENCES ParticipantTypes(ParticipantTypeID),
  FOREIGN KEY (CohortID) REFERENCES Cohorts(CohortID),
  UNIQUE (ParticipantID, ProgramID, ParticipantTypeID, CohortID)
);

CREATE INDEX IF NOT EXISTS idx_participant_programs_participant ON ParticipantPrograms(ParticipantID);
CREATE INDEX IF NOT EXISTS idx_participant_programs_program ON ParticipantPrograms(ProgramID);

-- ============================================================
-- Academic Tracking
-- ============================================================

CREATE TABLE IF NOT EXISTS CourseCatalog (
  CourseID INTEGER PRIMARY KEY AUTOINCREMENT,
  InstitutionID INTEGER NOT NULL,
  CourseNumber TEXT NOT NULL,
  CourseName TEXT NOT NULL,
  CreditHours REAL NOT NULL,
  CourseCategory TEXT NOT NULL CHECK (CourseCategory IN ('Biology', 'Chemistry', 'Physics', 'Mathematics', 'Other Science', 'Non-Science')),
  ScienceCourse INTEGER NOT NULL DEFAULT 0,
  IncludeInMSGPA INTEGER NOT NULL DEFAULT 0,
  ActiveStatus INTEGER NOT NULL DEFAULT 1,
  CreatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (InstitutionID) REFERENCES Institutions(InstitutionID),
  UNIQUE (InstitutionID, CourseNumber)
);

CREATE TABLE IF NOT EXISTS ParticipantCourses (
  ParticipantCourseID INTEGER PRIMARY KEY AUTOINCREMENT,
  ParticipantID INTEGER NOT NULL,
  CourseID INTEGER NOT NULL,
  Semester TEXT NOT NULL CHECK (Semester IN ('Fall', 'Spring', 'Summer')),
  Year INTEGER NOT NULL,
  Grade TEXT CHECK (Grade IN ('A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D', 'D-', 'F', 'CR', 'P', 'W')),
  GradePoints REAL,
  TransferType TEXT NOT NULL DEFAULT 'Native Credit' CHECK (TransferType IN ('Native Credit', 'Transfer Credit', 'Dual Credit', 'AP Credit')),
  RepeatedCourse INTEGER NOT NULL DEFAULT 0,
  IncludeInGPA INTEGER NOT NULL DEFAULT 1,
  CreatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (ParticipantID) REFERENCES Participants(ParticipantID),
  FOREIGN KEY (CourseID) REFERENCES CourseCatalog(CourseID)
);

CREATE INDEX IF NOT EXISTS idx_participant_courses_participant ON ParticipantCourses(ParticipantID);
CREATE INDEX IF NOT EXISTS idx_participant_courses_course ON ParticipantCourses(CourseID);

-- ============================================================
-- Requirements Tracking
-- ============================================================

CREATE TABLE IF NOT EXISTS Requirements (
  RequirementID INTEGER PRIMARY KEY AUTOINCREMENT,
  RequirementName TEXT NOT NULL,
  ProgramID INTEGER NOT NULL,
  RequirementDescription TEXT,
  RequiredForCompletion INTEGER NOT NULL DEFAULT 1,
  ActiveStatus INTEGER NOT NULL DEFAULT 1,
  CreatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (ProgramID) REFERENCES Programs(ProgramID),
  UNIQUE (ProgramID, RequirementName)
);

CREATE TABLE IF NOT EXISTS ParticipantRequirements (
  ParticipantRequirementID INTEGER PRIMARY KEY AUTOINCREMENT,
  ParticipantID INTEGER NOT NULL,
  RequirementID INTEGER NOT NULL,
  Status TEXT NOT NULL DEFAULT 'Not Started' CHECK (Status IN ('Not Started', 'In Progress', 'Completed', 'Waived')),
  CompletionDate TEXT,
  Notes TEXT,
  CreatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (ParticipantID) REFERENCES Participants(ParticipantID),
  FOREIGN KEY (RequirementID) REFERENCES Requirements(RequirementID),
  UNIQUE (ParticipantID, RequirementID)
);

-- ============================================================
-- Semester Experience Summaries
-- ============================================================

CREATE TABLE IF NOT EXISTS SemesterExperiences (
  SemesterExperienceID INTEGER PRIMARY KEY AUTOINCREMENT,
  ParticipantID INTEGER NOT NULL,
  ProgramID INTEGER,
  Semester TEXT NOT NULL CHECK (Semester IN ('Fall', 'Spring', 'Summer')),
  Year INTEGER NOT NULL,
  ShadowingHours REAL NOT NULL DEFAULT 0,
  ClinicalHours REAL NOT NULL DEFAULT 0,
  ResearchHours REAL NOT NULL DEFAULT 0,
  ServiceHours REAL NOT NULL DEFAULT 0,
  LeadershipHours REAL NOT NULL DEFAULT 0,
  ProfessionalDevelopmentHours REAL NOT NULL DEFAULT 0,
  ReflectionSubmitted INTEGER NOT NULL DEFAULT 0,
  DocumentationAttached INTEGER NOT NULL DEFAULT 0,
  DocumentationLink TEXT,
  SummaryNotes TEXT,
  DateSubmitted TEXT,
  ReviewedByStaffID INTEGER,
  CreatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (ParticipantID) REFERENCES Participants(ParticipantID),
  FOREIGN KEY (ProgramID) REFERENCES Programs(ProgramID),
  FOREIGN KEY (ReviewedByStaffID) REFERENCES Staff(StaffID),
  UNIQUE (ParticipantID, ProgramID, Semester, Year)
);

CREATE INDEX IF NOT EXISTS idx_semester_experiences_participant ON SemesterExperiences(ParticipantID);

-- ============================================================
-- Meetings and Advising
-- ============================================================

CREATE TABLE IF NOT EXISTS Meetings (
  MeetingID INTEGER PRIMARY KEY AUTOINCREMENT,
  ParticipantID INTEGER NOT NULL,
  ProgramID INTEGER NOT NULL,
  StaffID INTEGER NOT NULL,
  MeetingDate TEXT NOT NULL,
  MeetingType TEXT NOT NULL CHECK (MeetingType IN ('Academic', 'Professional Development', 'Wellness', 'MCAT', 'High Touch Mentor', 'Other')),
  MeetingNotes TEXT,
  FollowUpNeeded INTEGER NOT NULL DEFAULT 0,
  FollowUpDate TEXT,
  CreatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (ParticipantID) REFERENCES Participants(ParticipantID),
  FOREIGN KEY (ProgramID) REFERENCES Programs(ProgramID),
  FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

CREATE INDEX IF NOT EXISTS idx_meetings_participant ON Meetings(ParticipantID);
CREATE INDEX IF NOT EXISTS idx_meetings_staff ON Meetings(StaffID);
CREATE INDEX IF NOT EXISTS idx_meetings_program ON Meetings(ProgramID);
CREATE INDEX IF NOT EXISTS idx_meetings_date ON Meetings(MeetingDate);

-- ============================================================
-- Engagement Tracking
-- ============================================================

CREATE TABLE IF NOT EXISTS Events (
  EventID INTEGER PRIMARY KEY AUTOINCREMENT,
  ProgramID INTEGER NOT NULL,
  EventName TEXT NOT NULL,
  EventType TEXT NOT NULL CHECK (
    EventType IN (
      'Cohort Meeting',
      'Workshop',
      'Seminar',
      'Retreat',
      'Professional Development',
      'MCAT Session',
      'Service Event',
      'Other'
    )
  ),
  EventDate TEXT NOT NULL,
  RequiredAttendance INTEGER NOT NULL DEFAULT 0,
  HoursAwarded REAL DEFAULT 0,
  Notes TEXT,
  CreatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (ProgramID) REFERENCES Programs(ProgramID)
);

CREATE INDEX IF NOT EXISTS idx_events_program
ON Events(ProgramID);

CREATE INDEX IF NOT EXISTS idx_events_date
ON Events(EventDate);

CREATE TABLE IF NOT EXISTS Attendance (
  AttendanceID INTEGER PRIMARY KEY AUTOINCREMENT,
  ParticipantID INTEGER NOT NULL,
  EventID INTEGER NOT NULL,
  AttendanceStatus TEXT NOT NULL CHECK (
    AttendanceStatus IN (
      'Attended',
      'Excused',
      'Unexcused',
      'No Show'
    )
  ),
  AttendanceNotes TEXT,
  RecordedByStaffID INTEGER,
  CreatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (ParticipantID) REFERENCES Participants(ParticipantID),
  FOREIGN KEY (EventID) REFERENCES Events(EventID),
  FOREIGN KEY (RecordedByStaffID) REFERENCES Staff(StaffID),
  UNIQUE (ParticipantID, EventID)
);

CREATE INDEX IF NOT EXISTS idx_attendance_participant
ON Attendance(ParticipantID);

CREATE INDEX IF NOT EXISTS idx_attendance_event
ON Attendance(EventID);

-- ============================================================
-- Alerts and Interventions
-- ============================================================

CREATE TABLE IF NOT EXISTS Alerts (
  AlertID INTEGER PRIMARY KEY AUTOINCREMENT,
  ParticipantID INTEGER NOT NULL,
  ProgramID INTEGER,
  AlertDate TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  AlertType TEXT NOT NULL CHECK (AlertType IN ('Academic Concern','Missing Attendance', 'Missing Meeting', 'Missing Documentation', 'Missing Reflection', 'Missing Requirement', 'Missing Semester Update', 'Low Engagement', 'Other')),
  Severity TEXT NOT NULL DEFAULT 'Medium' CHECK (Severity IN ('Low', 'Medium', 'High', 'Critical')),
  AlertDescription TEXT NOT NULL,
  Resolved INTEGER NOT NULL DEFAULT 0,
  ResolutionDate TEXT,
  ResolutionNotes TEXT,
  CreatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UpdatedAt TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (ParticipantID) REFERENCES Participants(ParticipantID),
  FOREIGN KEY (ProgramID) REFERENCES Programs(ProgramID)
);

CREATE INDEX IF NOT EXISTS idx_alerts_participant ON Alerts(ParticipantID);
CREATE INDEX IF NOT EXISTS idx_alerts_resolved ON Alerts(Resolved);
CREATE INDEX IF NOT EXISTS idx_alerts_severity ON Alerts(Severity);

-- ============================================================
-- GPA Calculation Views
-- Weighted GPA = SUM(GradePoints * CreditHours) / SUM(CreditHours)
-- CR, P, W, and records with IncludeInGPA = 0 are excluded.
-- ============================================================

CREATE VIEW IF NOT EXISTS ParticipantGPA AS
SELECT
  pc.ParticipantID,
  ROUND(
    SUM(pc.GradePoints * cc.CreditHours) / NULLIF(SUM(cc.CreditHours), 0),
    3
  ) AS OverallGPA
FROM ParticipantCourses pc
JOIN CourseCatalog cc ON pc.CourseID = cc.CourseID
WHERE pc.IncludeInGPA = 1
  AND pc.GradePoints IS NOT NULL
  AND pc.Grade NOT IN ('CR', 'P', 'W')
GROUP BY pc.ParticipantID;

CREATE VIEW IF NOT EXISTS ParticipantScienceGPA AS
SELECT
  pc.ParticipantID,
  ROUND(
    SUM(pc.GradePoints * cc.CreditHours) / NULLIF(SUM(cc.CreditHours), 0),
    3
  ) AS ScienceGPA
FROM ParticipantCourses pc
JOIN CourseCatalog cc ON pc.CourseID = cc.CourseID
WHERE pc.IncludeInGPA = 1
  AND cc.ScienceCourse = 1
  AND pc.GradePoints IS NOT NULL
  AND pc.Grade NOT IN ('CR', 'P', 'W')
GROUP BY pc.ParticipantID;

CREATE VIEW IF NOT EXISTS ParticipantMathScienceGPA AS
SELECT
  pc.ParticipantID,
  ROUND(
    SUM(pc.GradePoints * cc.CreditHours) / NULLIF(SUM(cc.CreditHours), 0),
    3
  ) AS MathScienceGPA
FROM ParticipantCourses pc
JOIN CourseCatalog cc ON pc.CourseID = cc.CourseID
WHERE pc.IncludeInGPA = 1
  AND cc.IncludeInMSGPA = 1
  AND pc.GradePoints IS NOT NULL
  AND pc.Grade NOT IN ('CR', 'P', 'W')
GROUP BY pc.ParticipantID;
