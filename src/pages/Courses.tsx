import React from 'react';

export default function Courses() {
  return (
    <div>
      <h1>Academic Tracking</h1>

      <h2>Course Catalog</h2>
      <p>Reusable institutional course library supporting GPA, Science GPA, and Math/Science GPA calculations.</p>

      <h2>Participant Coursework</h2>
      <ul>
        <li>Institution</li>
        <li>Course Number</li>
        <li>Course Name</li>
        <li>Credit Hours</li>
        <li>Grade</li>
        <li>Transfer / Dual Credit / AP</li>
      </ul>

      <h2>Progress Pillar</h2>
      <ul>
        <li>Overall GPA</li>
        <li>Science GPA</li>
        <li>Math/Science GPA</li>
      </ul>
    </div>
  );
}
