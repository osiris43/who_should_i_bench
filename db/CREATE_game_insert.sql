-- Function: game_insert(character varying, integer, character varying, character varying, timestamp without time zone)

-- DROP FUNCTION game_insert(character varying, integer, character varying, character varying, timestamp without time zone);

CREATE OR REPLACE FUNCTION game_insert(seasontype integer, season integer, week integer, home character varying, homemascot character varying, away character varying, awaymascot character varying, gamedate timestamp without time zone)
  RETURNS integer AS
$BODY$

DECLARE home_id int;
DECLARE away_id int;
DECLARE game_id int;
BEGIN

select id 
FROM nfl_teams
into home_id
WHERE city = home and mascot = homemascot;

select id
from nfl_teams
into away_id
WHERE city = away and mascot = awaymascot;

insert into nfl_games(id, away_team_id, home_team_id, season, week, nfl_season_type_id, created_at, updated_at, gamedate)
values(DEFAULT, away_id, home_id, season, week, seasontype, now(), now(), gamedate)
RETURNING id into game_id;

return game_id;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
--ALTER FUNCTION game_insert(character varying, integer, character varying, character varying, timestamp without time zone)
--  OWNER TO postgres;
