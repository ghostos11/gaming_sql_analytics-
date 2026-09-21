


--creating logins

USE master;

CREATE LOGIN analyst_login
WITH PASSWORD = 'analyst12056!';
GO

CREATE LOGIN marketing_login
WITH PASSWORD = '12345';
GO

-- creating users 



USE Gaming_Analytics;

CREATE USER analyst_user
FOR LOGIN analyst_login;


CREATE USER analyst_user
FOR LOGIN marketing_login;



CREATE ROLE MarketingTeam
ADD MEMBER marketing_user;


CREATE ROLE Analyst
ADD MEMBER analyst_user;




GRANT SELECT ON dbo.Sponsors TO MarketingTeam
GRANT SELECT ON dbo.team_sponsors TO MarketingTeam
GRANT SELECT ON dbo.Teams TO MarketingTeam
GRANT SELECT ON dbo.matches TO Analyst
GRANT SELECT ON dbo.pro_players TO Analyst
GRANT SELECT ON dbo.rosters TO Analyst
GRANT SELECT ON dbo.tournaments TO Analyst;


ALTER TABLE teams
ALTER COLUMN total_earnings 
ADD MASKED WITH (FUNCTION='email()');
