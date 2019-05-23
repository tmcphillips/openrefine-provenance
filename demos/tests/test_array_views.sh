['../rules/array_views'].

set_prolog_flag(unknown, fail).

[user].
    state(state_1, array_1, nil).
end_of_file.

[user].
    test_final_array_state() :-

        final_array_state(array_1, state_1),
        writeln('SUCCESS')
        ;
        writeln('FAIL'),
        fail.
end_of_file.

test_final_array_state().
