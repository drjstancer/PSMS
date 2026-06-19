# Pathways Success Management System (PSMS)

The **Pathways Success Management System (PSMS)** is a local-first participant success management application for the CaPS pathways ecosystem.

PSMS supports advising, mentoring, academic monitoring, attendance tracking, semester experience tracking, requirement tracking, intervention alerts, and program evaluation for pathway and enrichment programs.

## Fixed Project Vision

PSMS is a participant success management platform.

It tracks:

- participants
- programs and participant types
- attendance and engagement
- academic coursework
- semester experience summaries
- meetings
- requirements
- alerts and interventions
- reports and dashboards

PSMS is **not**:

- a university student information system
- an admissions CRM
- an application tracking system
- an interview tracking system
- a recommendation letter tracking system
- a registrar system

## PSMS Framework

The system is organized around five pillars:

1. Engagement
   - Attendance
   - Cohort Meetings
   - Workshops
   - Seminars
   - Retreats

2. Support
   - High Touch Mentor Meetings
   - Well-Being Meetings
   - MedOpp Advising
   - CASE Support

3. Progress
   - GPA
   - Science GPA
   - Math/Science GPA
   - Requirements

4. Development
   - Shadowing
   - Clinical Experiences
   - Research
   - Service
   - Leadership
   - Professional Development

5. Intervention
   - Alerts
   - Follow-Ups
   - Resolution Tracking

## Supported Programs

- JPAWS
- PAWS
- PEN
- Bryant Scholars
- Springfield Scholars
- MedPrep I
- MedPrep II
- Medical Explorations
- High School Mini-Med
- Mizzou MedReady Summer Enrichment Program (MMRSEP)
- Pre-Med Day

PAWS is treated as one program. Participant Type distinguishes roles such as Leader, Achiever, Scholar, Mentor, or Participant.

## Architecture Decision

GitHub stores:

- application source code
- database schema
- documentation
- build notes
- version history

OneDrive stores:

- live database file during the local-first phase
- participant documents
- semester documentation
- exports
- backups

## Planned Technical Stack

- React
- TypeScript
- Tauri
- SQLite
- Tailwind CSS
- shadcn/ui

## Core Navigation

Version 1 focuses on:

1. Dashboard
2. Participants
3. Meetings
4. Attendance
5. Academics
6. Alerts

Secondary areas:

- Programs
- Requirements
- Semester Experiences
- Staff
- Reports
- Administration

## Version 0.1 Goal

Build the foundation:

- app shell
- local OneDrive data folder selection
- SQLite database connection
- participant search
- participant profile
- meeting entry
- attendance tracking foundation
- placeholder dashboard

## Build Principle

Build in batches. Do not add admissions, applications, interviews, recommendation letters, or unrelated CRM features.
