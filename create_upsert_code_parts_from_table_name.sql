declare @tbl sysname = ''

select --QUOTENAME(c.name), 
    case when c.is_identity = 1 then '--' else '' end +
	case when c.column_id = 1 then '' else ',' end +
	' dest.' + quotename(c.name) + ' = src.'+ quotename(c.name) update_logic,
	case when c.column_id = 1 then '' else ', ' end + quotename(c.name) insert_list, 
	case when c.column_id = 1 then '' else ',' end + ' src.' + quotename(c.name) insert_source,
	case when c.is_identity = 1 then 'set identity_insert dbo.' + quotename(@tbl) + ' on;' else '' end,
	case when c.is_identity = 1 then 'set identity_insert dbo.' + quotename(@tbl) + ' off;' else '' end
from sys.columns c
	join sys.tables t on c.object_id = t.object_id
where t.name = @tbl
order by column_id asc

