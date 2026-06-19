import React from 'react';

export default function Dashboard() {
  return (
    <div>
      <h1>PSMS Dashboard</h1>

      <h2>Program Coordinator Dashboard</h2>
      <ul>
        <li>Active Participants</li>
        <li>Active Alerts</li>
        <li>Upcoming Follow-Ups</li>
        <li>Participants Not Seen in 60 Days</li>
        <li>Missing Attendance</li>
        <li>Missing Meetings</li>
        <li>Missing Semester Updates</li>
      </ul>

      <h2>Executive Dashboard</h2>
      <ul>
        <li>Total Participants</li>
        <li>Participants by Program</li>
        <li>Attendance Trends</li>
        <li>Meeting Completion Trends</li>
        <li>Requirement Completion Rates</li>
        <li>Active Interventions</li>
      </ul>
    </div>
  );
}
