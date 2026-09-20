1.     --Q1 Which teams have the highest earnings? --

select team_id, name, total_earnings
from teams
ORDER BY total_earnings DESC 




        --Q2 Which tournaments have the largest prize pools?--


select tournament_id, title, game_title, prize_pool
from tournaments
ORDER BY prize_pool desc



        --Q3 Which countries have the most players?--



SELECT country, COUNT(*) as player_count
FROM pro_players
GROUP BY country
ORDER BY player_count DESC



        --Q4. Which teams have the most players?--



SELECT name , COUNT(*) as total_players
from pro_players
join teams
on pro_players.team_id = teams.team_id
GROUP BY name




        --Q5. Which teams have the most wins?--





SELECT name, COUNT(*) as total_wins
from matches
join teams
ON matches.winner_team_id = teams.team_id
GROUP BY name
ORDER BY total_wins DESC



        --Q6 Which sponsors have the largest deals?--




select sponsor_name, SUM(deal_value) as total_deal_value, industry
FROM sponsors
JOIN team_sponsors
on team_sponsors.sponsor_id = sponsors.sponsor_id
GROUP BY sponsor_name
ORDER BY total_deal_value DESC




        --7. Which teams have the highest win rates?--s


SELECT
    name,
    ROUND(COUNT(*) / SUM(COUNT(*)) OVER () * 100, 1) AS win_rate
FROM matches
JOIN teams 
ON matches.winner_team_id = teams.team_id
GROUP BY name
ORDER BY win_rate DESC;




