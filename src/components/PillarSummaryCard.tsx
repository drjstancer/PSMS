import React from 'react';

type Props = {
  title: string;
  value: string;
};

export default function PillarSummaryCard({ title, value }: Props) {
  return (
    <div>
      <h3>{title}</h3>
      <p>{value}</p>
    </div>
  );
}
