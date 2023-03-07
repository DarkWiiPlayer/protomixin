local task = require 'spooder' .task

task.clean {
	description = "Deletes buildt leftovers";
	'rm -rf luacov-html';
	'rm -f luacov.report.out';
	'rm -f luacov.stats.out';
}

task.test {
	description = "Runs tests";
	'rm luacov.stats.out > /dev/null || true';
	'luacheck .';
	'busted --coverage --lpath "?/init.lua;?.lua"';
	'luacov -r html protomixin.lua';
}
