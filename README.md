# gaming_sql_analytics

A SQL project focused on analyzing competitive gaming data.

## Project Goals

- Practice SQL
- Analyze players and teams
- Analyze match performance
- Practice JOINs and subqueries
- Build data analysis skills

## Technologies

- SQL
- MySQL
- GitHub

## Database

The database will contain information about:

- Teams 
- Pro_Players
- Tournaments 
- Matches
- rosters
- Sponsors
- Team_Sponsors 


## Questions Answered

The project explores several business questions using SQL. Below are some of the key questions addressed; the full analysis can be found in the [analysis.sql](analysis.sql) file. 

- Q1 Which teams have the highest earnings?
- Q2 Which tournaments have the largest prize pools?--
- Q3 Which countries have the most players?--
- Q4. Which teams have the most players?--
- Q5. Which teams have the most wins?--
- Q6 Which sponsors have the largest deals?--
- Q7. Which teams have the highest win rates?--s



# Database Security Setup

A T-SQL script that sets up role-based access control (RBAC) for the `gaming_analytics` database on Microsoft SQL Server. It creates separate logins, database users, and roles so that each work team can only read the tables it needs, following the principle of least privilege.

## Overview

The `gaming_analytics` database stores esports data such as teams, players, matches, tournaments, and sponsors. Not every work team needs access to everything, so this script splits access into two roles:

| Role | Member (user) | Login | Purpose |
|------|---------------|-------|---------|
| `MarketingTeam` | `marketing_user` | `marketing_login` | Sponsorship and team information |
| `Analyst` | `analyst_user` | `analyst_login` | Match, player, and tournament data |

## Permissions

All permissions are **read-only** (`SELECT`). No role can insert, update, or delete data.

| Table | MarketingTeam | Analyst |
|-------|:-------------:|:-------:|
| `dbo.sponsors` | ✅ | ❌ |
| `dbo.team_sponsors` | ✅ | ❌ |
| `dbo.teams` | ✅ | ❌ |
| `dbo.matches` | ❌ | ✅ |
| `dbo.pro_players` | ❌ | ✅ |
| `dbo.rosters` | ❌ | ✅ |
| `dbo.tournaments` | ❌ | ✅ |

## What the script does

1. **Creates server-level logins** (`analyst_login`, `marketing_login`) in the `master` database.
2. **Creates database users** (`analyst_user`, `marketing_user`) in `gaming_analytics`, each mapped to its login.
3. **Creates roles** (`MarketingTeam`, `Analyst`).
4. **Adds each user to its role** with `ALTER ROLE ... ADD MEMBER`.
5. **Grants `SELECT`** on the relevant tables to each role.

Permissions are granted to roles, not to individual users. To give someone access, add them to a role instead of granting table permissions one by one.

## Prerequisites

- Microsoft SQL Server (tested on SQL Server Express)
- SQL Server Management Studio (SSMS) or Azure Data Studio
- The `gaming_analytics` database and its tables already created
- **SQL Server and Windows Authentication mode** enabled on the server (needed for SQL logins; restart the SQL Server service after changing it)
- A connection with sufficient rights to create logins and users (for example, `sysadmin`)

## Usage

1. Open the script in SSMS while connected as an administrator.
2. **Replace the placeholder passwords** with strong ones of your own.
3. Execute the script.
4. Test each login (see below).

## Testing

Connect with **SQL Server Authentication** using `marketing_login`, then run:

```sql
SELECT * FROM dbo.sponsors;   -- should succeed
SELECT * FROM dbo.matches;    -- should fail: SELECT permission denied
```

Then connect as `analyst_login`:

```sql
SELECT * FROM dbo.matches;    -- should succeed
SELECT * FROM dbo.sponsors;   -- should fail: SELECT permission denied
```


## Security notes

- **Do not commit real passwords** to version control. Use placeholders in the repository and set the real passwords when deploying.
- Use strong passwords that meet the Windows password policy.
- Keep permissions on roles rather than individual users, and review them regularly.
- Only grant the minimum access each team needs.

## Possible improvements

- Add `DENY` rules or views to hide sensitive columns
- Create an admin or read-write role for data maintenance
- Add a rollback script (`DROP USER`, `DROP ROLE`, `DROP LOGIN`)
- Use Windows or Active Directory groups instead of SQL logins in production


## 🔐 Backup Security & Encryption

As part of the database security layer, backup security was tested on the
`gaming_analytics` database.

### 1. Creating a Database Backup

A full SQL Server backup was created using:

```sql
BACKUP DATABASE gaming_analytics
TO DISK = 'C:\SQLBackup\gaming_analytics.bak'
WITH INIT,
     FORMAT,
     NAME = 'Gaming Analytics Full Backup';
GO;


