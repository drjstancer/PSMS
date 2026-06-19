import React from 'react';
import CoordinatorDashboard from '../components/CoordinatorDashboard';
import ExecutiveDashboard from '../components/ExecutiveDashboard';
import DashboardMetricCard from '../components/DashboardMetricCard';

export default function Dashboard() {
  return (
    <div>
      <h1>PSMS Dashboard</h1>

      <DashboardMetricCard title='Active Participants' value='0' />
      <DashboardMetricCard title='Active Alerts' value='0' />
      <DashboardMetricCard title='Missing Attendance' value='0' />
      <DashboardMetricCard title='Upcoming Follow-Ups' value='0' />

      <CoordinatorDashboard />
      <ExecutiveDashboard />
    </div>
  );
}
