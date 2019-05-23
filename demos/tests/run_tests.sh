#!/usr/bin/env bash

source ../settings.sh

test_file_name=$1
test_name='test'

xsb --quietload --noprompt --nofeedback --nobanner << END_XSB_STDIN

set_prolog_flag(unknown, fail).

[${test_file_name}].
['../rules/array_views'].
${test_name}().

END_XSB_STDIN
