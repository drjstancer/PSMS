import React from 'react';

interface SidebarProps {
  activeTab: string;
  onSelect: (tab: string) => void;
}

const tabs = ['Dashboard','Meetings','Participants','Courses','Alerts'];

export default function Sidebar({ activeTab, onSelect }: SidebarProps) {
  return (
    <aside>
      <h2>PSMS</h2>
      {tabs.map(tab => (
        <button key={tab} onClick={() => onSelect(tab)} disabled={activeTab === tab}>
          {tab}
        </button>
      ))}
    </aside>
  );
}
