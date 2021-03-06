
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% facts

array(array_3, nil).

column(column_1, array_3).

state(4, array_3, nil).
state(5, array_3, 4).
state(6, array_3, 5).
state(7, array_3, 6).
state(8, array_3, 7).
state(9, array_3, 8).

column_schema(col_schema_1, column_1, 4, 'string', 'name assigned at state 4', nil, nil).
column_schema(col_schema_2, column_1, 6, 'string', 'name assigned at state 6', nil, col_schema_1).
column_schema(col_schema_3, column_1, 8, 'string', 'name assigned at state 8', nil, col_schema_2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% test next_column_schema_at_or_before_state/2

test__next_column_schema_at_or_before_state__state_precedes_schemas() :-
    not next_column_schema_at_or_before_state(col_schema_1, 3).

test__next_column_schema_at_or_before_state__schema_at_state() :-
    not next_column_schema_at_or_before_state(col_schema_1, 4).

test__next_column_schema_at_or_before_state__next_schema_at_state() :-
    next_column_schema_at_or_before_state(col_schema_1, 6).

test__next_column_schema_at_or_before_state__next_column_schema_precedes_state() :-
    next_column_schema_at_or_before_state(col_schema_1, 7).

test__next_column_schema_at_or_before_state__no_schema_after_state() :-
    not next_column_schema_at_or_before_state(col_schema_3, 9).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% test column_schema_at_state/3

test__column_schema_at_state__at_state_before_first_column_schema() :-
    not column_schema_at_state(_, column_1, 3).

test__column_schema_at_state__at_first_column_schema_state() :-
    column_schema_at_state(col_schema_1, column_1, 4).

test__column_schema_at_state___between_first_two_column_schema_states() :-
    column_schema_at_state(col_schema_1, column_1, 5).

test__column_schema_at_state___at_second_column_schema_state() :-
    column_schema_at_state(col_schema_2, column_1, 6).

test__column_schema_at_state___at_state_after_last_column_schema() :-
    column_schema_at_state(col_schema_3, column_1, 9).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% test column_name/3

test__column_name__at_state_before_first_column_schema() :-
    not column_name(column_1, 3, _).

test__column_name__at_first_column_schema_state() :-
    column_name(column_1, 4, 'name assigned at state 4').

test__column_name__between_first_two_column_schema_states() :-
    column_name(column_1, 5, 'name assigned at state 4').

test__column_name__at_second_column_schema_state() :-
    column_name(column_1, 6, 'name assigned at state 6').

test__column_name__at_state_after_last_column_schema() :-
    column_name(column_1, 9, 'name assigned at state 8').

