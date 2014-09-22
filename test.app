"use strict";

var koa = require('koa')
	, util = require('util')
	, views = require('koa-views')
	, serve = require('koa-static')
	, router = require('koa-router')
	, logger = require('koa-logger')
	, parse = require('co-body')
	, app = koa();

app.use(router(app));

app.use( logger() );

app.use(views(
	'views', {
		default: 'jade',
		cache: false,
	}
));

app.use(serve('public'));

app.get('/', function * (next) {

	yield next;	
	yield this.render('index');

}).post('/ajax', function * (next) {

	yield next;	
	var json = yield parse.json(this.req);
	console.log("AJAX REQUEST WITH BODY");
	console.log(json);
	
	yield this.render('form', {
		form: JSON.stringify( json.fields )
		, util: util
	});

});

app.listen(3000);
