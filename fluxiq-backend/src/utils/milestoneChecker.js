
'use strict';

const MILESTONES = [10, 50, 100, 500, 1000];

const MILESTONE_EMOJIS = {
  10:   '🎉',
  50:   '🔥',
  100:  '💯',
  500:  '⭐',
  1000: '🏆',
};


const checkMilestone = (currentCount) => {
  if (typeof currentCount !== 'number' || currentCount < 0) {
    return null;
  }
  return MILESTONES.find((m) => m === currentCount) ?? null;
};

const buildMilestoneBody = (newsTitle, milestoneCount, emoji) => {
  const truncatedTitle =
    newsTitle.length > 40 ? `${newsTitle.substring(0, 40)}...` : newsTitle;
  return `${emoji} وصل خبرك '${truncatedTitle}' إلى ${milestoneCount} إعجاب!`;
};

module.exports = { checkMilestone, buildMilestoneBody, MILESTONES };