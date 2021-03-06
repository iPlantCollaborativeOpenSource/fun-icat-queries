WITH RECURSIVE
  homes(user_id, coll_id, coll_name) AS (
    SELECT u.user_id, c.coll_id, c.coll_name
      FROM r_coll_main AS c JOIN r_user_main AS u ON c.coll_name = '/iplant/home/' || u.user_name
      WHERE u.user_type_name = 'rodsuser'
	AND u.zone_name = 'iplant'
	AND u.user_name != 'bisque' AND u.user_name != 'coge'
    UNION ALL
    SELECT h.user_id, c.coll_id, c.coll_name
      FROM r_coll_main AS c JOIN homes AS h ON c.parent_coll_name=h.coll_name)
SELECT COUNT(DISTINCT h.user_id) FROM homes AS h JOIN r_data_main AS d ON h.coll_id = d.coll_id;

