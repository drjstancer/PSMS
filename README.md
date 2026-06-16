# Pathways Success Management System (PSMS)

The **Pathways Success Management System (PSMS)** is a local-first participant success management application for the CaPS pathways ecosystem.

PSMS supports advising, mentoring, academic monitoring, semester experience tracking, requirement tracking, intervention alerts, and program evaluation for pathway and enrichment programs.

## Fixed Project Vision

PSMS is a participant success management platform.

It tracks:

- participants
- programs and participant types
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

Version 1 focuses on five primary tabs:

1. Dashboard
2. Meetings
3. Participants
4. Courses
5. Alerts

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
- placeholder dashboard

## Build Principle

Build in batches. Do not add admissions, applications, interviews, recommendation letters, or unrelated CRM features.
