import React from 'react';

type Props = {
  title: string;
  value: string | number;
};

export default function DashboardMetricCard({ title, value }: Props) {
  return (
    <div>
      <h3>{title}</h3>
      <p>{value}</p>
    </div>
  );
}
