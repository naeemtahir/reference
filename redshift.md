# Postgres/RedShift

- [Admin Queries](#admin-queries)
- [Diagnostic Queries (RedShift Specific)](#diagnostic-queries-redshift-specific)

## Admin Queries

### List Schemas
```sql
select nspname from pg_catalog.pg_namespace;
```

### List Tables
```sql
SELECT * FROM pg_catalog.pg_tables;
```
### List Groups:
```sql
select * from pg_group;
```
### Create Group
```sql
CREATE GROUP <group_name>;
```

### Drop Group
```sql
DROP GROUP <group_name>
```

## List Users
```sql
SELECT u.usename AS "User name", u.usesysid AS "User ID",
CASE WHEN u.usesuper AND u.usecreatedb THEN CAST('superuser, create
database' AS pg_catalog.text)
WHEN u.usesuper THEN CAST('superuser' AS pg_catalog.text)
WHEN u.usecreatedb THEN CAST('create database' AS
pg_catalog.text)
ELSE CAST('' AS pg_catalog.text)
END AS "Attributes"
FROM pg_catalog.pg_user u
ORDER BY 1;
```
## Create User
```sql
CREATE USER <user_id> WITH PASSWORD '<password>';
```

## Add User to Group
```sql
ALTER GROUP <group_name> ADD USER <user_id>;
```

## Change user password
```sql
ALTER USER <user_id> WITH PASSWORD ‘<password>’;
```

## Drop User
```sql
DROP USER ro_user; 
```

## Read-only Access

1. Create Read-Only Group
```sql
CREATE GROUP readonly_group;
```

2. Grant Usage permission to Read-Only Group to specific Schema
```sql
GRANT USAGE ON SCHEMA <schema_name> TO GROUP readonly_group;  -- schema_name=public
```

3. Grant Select permission to Read-Only Group to specific Schema
```sql
GRANT SELECT ON ALL TABLES IN SCHEMA "<schema_name>" TO GROUP readonly_group; -- schema_name=public
```

4. Alter Default Privileges to maintain the permissions on new tables
```sql
ALTER DEFAULT PRIVILEGES IN SCHEMA "<schema_name>" GRANT SELECT ON TABLES TO GROUP readonly_group; -- schema_name=public
```
RedShift specific ```GRANT SELECT ON ALL TABLES IN SCHEMA public TO GROUP readonly_group;```

5. Revoke CREATE privileges from group
```sql
REVOKE CREATE ON SCHEMA "<schema_name>" FROM GROUP readonly_group;  -- schema_name=public
```

7. Add User to Read-Only Group
```sql
ALTER GROUP readonly_group ADD USER ro_user;
```

## Diagnostic Queries (RedShift Specific)

### Show active queries
```sql
select userid, pid, starttime, query, text query_text
from stv_inflight
order by starttime;
```

### Show recent queries, includes active queries
```sql
select user_name, pid, starttime, query, status, duration
from stv_recents
where user_name='<userid issuing queries>' order by starttime;
```

### Show past queries from last few days (takes very long, limit results)
```sql
select userid, pid, starttime, endtime, elapsed, substring
from svl_qlog
order by starttime desc limit 10;
```

### Cancel a query  
```
cancel <pid from stv_inflight>
```

### Inspect locks, order them by oldest first
```sql
select table_id, last_update, last_commit, lock_owner_pid, lock_status 
from stv_locks 
order by last_update asc
```

### To terminate the session run
```sql
select pg_terminate_backend(<lock_owner_pid from stv_locks>);
```

### List active connections
```sql
select distinct starttime, process, user_name, remotehost, remoteport
from stv_sessions left join stl_connection_log on pid = process and starttime > recordtime - interval '1 second'
order by starttime desc;
```

### Check available space on cluster
```sql
select sum(used)::float / sum(capacity) as pct_full
from stv_partitions; 
```

### Check individual table size
```sql
select t.name, count(tbl) / 1000.0 as gb
from (
  select distinct datname id, name
  from stv_tbl_perm 
    join pg_database on pg_database.oid = db_id
  ) t
join stv_blocklist on tbl=t.id
group by t.name order by gb desc;
```

**Reference:** https://www.periscopedata.com/blog/helpful-redshift-admin-queries
