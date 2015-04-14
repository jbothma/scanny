compile:
	./rebar compile

start:
	erl -pa deps/*/ebin ebin -s scanny_app
