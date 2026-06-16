-- PSMS Schema v0.1

CREATE TABLE Participants (
  ParticipantID INTEGER PRIMARY KEY AUTOINCREMENT,
  MUID TEXT,
  PawPrint TEXT UNIQUE,
  FirstName TEXT NOT NULL,
  LastName TEXT NOT NULL,
  PreferredName TEXT,
  Email TEXT,
  Phone TEXT,
  IntendedEnteringClassYear INTEGER,
  ParticipantStatus TEXT
);

CREATE TABLE Programs (
  ProgramID INTEGER PRIMARY KEY AUTOINCREMENT,
  ProgramName TEXT NOT NULL,
  ProgramAbbreviation TEXT NOT NULL
);

CREATE TABLE Staff (
  StaffID INTEGER PRIMARY KEY AUTOINCREMENT,
  FirstName TEXT,
  LastName TEXT,
  Email TEXT,
  UserRole TEXT
);

CREATE TABLE Meetings (
  MeetingID INTEGER PRIMARY KEY AUTOINCREMENT,
  ParticipantID INTEGER NOT NULL,
  ProgramID INTEGER NOT NULL,
  StaffID INTEGER NOT NULL,
  MeetingDate TEXT,
  MeetingType TEXT,
  MeetingNotes TEXT,
  FollowUpNeeded INTEGER DEFAULT 0,
  FollowUpDate TEXT,
  FOREIGN KEY (ParticipantID) REFERENCES Participants(ParticipantID),
  FOREIGN KEY (ProgramID) REFERENCES Programs(ProgramID),
  FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);
