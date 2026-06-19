import React from 'react';
import EngagementCard from './EngagementCard';
import SupportCard from './SupportCard';
import ProgressCard from './ProgressCard';
import DevelopmentCard from './DevelopmentCard';
import InterventionCard from './InterventionCard';

export default function ParticipantProfile() {
  return (
    <div>
      <h2>Participant 360 Profile</h2>

      <h3>Participant Information</h3>
      <p>Name • MU ID • PawPrint • Institution • Classification • ECY</p>

      <h3>Program Participation</h3>
      <p>Program • Participant Type • Cohort • Status</p>

      <EngagementCard />
      <SupportCard />
      <ProgressCard />
      <DevelopmentCard />
      <InterventionCard />
    </div>
  );
}
