
-- Basic Information Table:

SELECT id, player, height, weight, college, born, position, tm
FROM players p, seasons_stats s
WHERE p.id = s.player_id
LIMIT 10

-- Percent Stats:

SELECT player_id, college, year, position, two_point_percentage, fg_percentage, ft_percentage, ts_percentage
FROM players p, seasons_stats s
WHERE p.id = s.player_id
LIMIT 10
