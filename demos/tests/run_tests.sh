#!/usr/bin/env bash

source ../settings.sh

test_file_name=$1
test_names='[test, test2, test3]'

xsb --quietload --noprompt --nofeedback --nobanner << END_XSB_STDIN

set_prolog_flag(unknown, fail).

['../rules/array_views'].
[${test_file_name}].
[basics].
[user].

do_one_test(TestFileName, TestName) :-
    fmt_write("%s.%s : ", arg(TestFileName, TestName)),
    call(TestName),
    writeln('ok')
    ;
    writeln('FAILURE').

do_tests(TestFileName, TestNames) :-
    forall(member(TestName, TestNames),
        do_one_test(TestFileName, TestName)
    ).

end_of_file.

do_tests(${test_file_name}, ${test_names}).


END_XSB_STDIN
