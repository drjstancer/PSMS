import React, { useState } from 'react';

const tabs = ['Dashboard','Meetings','Participants','Courses','Alerts'];

export default function App() {
  const [activeTab, setActiveTab] = useState('Dashboard');

  return (
    <div style={{display:'flex',height:'100vh',fontFamily:'sans-serif'}}>
      <aside style={{width:'240px',padding:'1rem',borderRight:'1px solid #ddd'}}>
        <h2>PSMS</h2>
        {tabs.map(tab => (
          <button key={tab} onClick={() => setActiveTab(tab)} style={{display:'block',width:'100%',margin:'0.5rem 0'}}>
            {tab}
          </button>
        ))}
      </aside>
      <main style={{padding:'1rem',flex:1}}>
        <h1>{activeTab}</h1>
        <p>PSMS Version 0.1 Foundation</p>
      </main>
    </div>
  );
}
