#!/usr/bin/env bash

source ../settings.sh

testfilepattern=${1:-'test*.P'}
testfiles=($testfilepattern)

for testfile in "${testfiles[@]}" ; do

    echo
    echo "Running tests in $testfile..."
    echo

    test_file_base=${testfile%.P}

    test_name_pattern='^[[:space:]]*test[_a-zA-Z0-9]*()'
    readarray test_names_array < <(grep $test_name_pattern ${test_file_base}.P | cut -d "(" -f1 )

    test_names="[ "
    delimiter=""
    for tn in "${test_names_array[@]}" ; do
        test_names+=$delimiter
        test_names+=$tn
        delimiter=", "
    done
    test_names+="]"

    xsb --quietload --noprompt --nofeedback --nobanner << END_XSB_STDIN

        set_prolog_flag(unknown, fail).
        ['$RULES_DIR/array_views'].
        [${test_file_base}].

        [user].

            :- import forall/2 from basics.
            :- import member/2 from basics.

            do_one_test(TestFileName, TestName) :-
                fmt_write("%s|%-80s | ", arg(TestFileName, TestName)),
                call(TestName),
                writeln('ok')
                ;
                writeln('FAILURE').

            do_tests(TestFileName, TestNames) :-
                forall(member(TestName, TestNames),
                    do_one_test(TestFileName, TestName)
                ).

        end_of_file.

        do_tests(${test_file_base}, ${test_names}).

END_XSB_STDIN

done
