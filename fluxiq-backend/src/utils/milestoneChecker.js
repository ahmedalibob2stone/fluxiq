'use strict';

// ── Milestones المطلوبة ────────────────────────────────────────────────────
const MILESTONES = [10, 15, 20, 50, 1000, 10000, 1000000];

const MILESTONE_LABELS = {
  10:      '🎉 10 Likes!',
  15:      '🔥 15 Likes!',
  20:      '⚡ 20 Likes!',
  50:      '🌟 50 Likes!',
  1000:    '💯 1,000 Likes!',
  10000:   '⭐ 10,000 Likes!',
  1000000: '🏆 1,000,000 Likes!',
};


const checkMilestone = (currentCount) => {
  if (typeof currentCount !== 'number' || currentCount < 0) return null;
  return MILESTONES.find((m) => m === currentCount) ?? null;
};

const getMilestoneLabel = (milestoneCount) =>
  MILESTONE_LABELS[milestoneCount] ?? `${milestoneCount} Likes!`;

module.exports = { checkMilestone, getMilestoneLabel, MILESTONES };