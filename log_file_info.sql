CREATE TABLE #log_info ([database name] sysname,
	 [log size (mb)] DECIMAL(18,4),
	 [log space used (%)] DECIMAL(18,10),
	 [status] BIT)

INSERT INTO #log_info
EXEC('DBCC SQLPERF(LOGSPACE)')

DECLARE @avg DECIMAL(18,6)
SELECT @avg = AVG([log size (mb)]) FROM #log_info
SELECT @avg as 'Average Log size for server'
SELECT * FROM #log_info WHERE [log size (mb)] > @avg
