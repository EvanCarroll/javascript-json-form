"use strict";

var koa = require('koa')
	, views = require('koa-views')
	, serve = require('koa-static')
	, _ = require('koa-route')
	, logger = require('koa-logger')
	, app = koa();

app.use( logger() );

app.use(views(
	'views', {
		default: 'jade',
		cache: false,
	}
));

app.use(serve('public'));

app.use(_.get('/', function * (next) {
	yield next;	
	yield this.render('index');
}));

app.listen(3000);
