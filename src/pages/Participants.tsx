import React from 'react';

export default function Participants() {
  return (
    <div>
      <h1>Participants</h1>

      <h2>Participant Search</h2>
      <p>Search by Name, MU ID, PawPrint, Program, Participant Type, Cohort, or Status.</p>

      <h2>Search Results</h2>
      <table>
        <thead>
          <tr>
            <th>Name</th>
            <th>Program</th>
            <th>Participant Type</th>
            <th>Institution</th>
            <th>ECY</th>
            <th>Status</th>
          </tr>
        </thead>
      </table>

      <h2>Participant 360 Summary</h2>
      <ul>
        <li>Participant Information</li>
        <li>Program Participation</li>
        <li>Academic Snapshot</li>
        <li>Attendance Snapshot</li>
        <li>Meeting Snapshot</li>
        <li>Active Alerts</li>
      </ul>
    </div>
  );
}
