#!/usr/bin/env bash

source ../settings.sh

test_file_name=$1
test_name='test'

xsb --quietload --noprompt --nofeedback --nobanner << END_XSB_STDIN

set_prolog_flag(unknown, fail).

['../rules/array_views'].
[${test_file_name}].

[user].
do_test() :-
    fmt_write("%s : ", arg(${test_file_name})),
    ${test_name}(),
    writeln('SUCCESS')
    ;
    writeln('FAIL'),
    fail.
end_of_file.

do_test().

END_XSB_STDIN
