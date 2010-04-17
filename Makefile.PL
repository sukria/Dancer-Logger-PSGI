use inc::Module::Install;
name 'Dancer-Logger-PSGI';
all_from 'lib/Dancer/Logger/PSGI.pm';
readme_from 'lib/Dancer/Logger/PSGI.pm';

# requires '';

tests 't/*.t';

build_requires 'Test::More';
use_test_base;
auto_include;
#auto_include_deps;
author_tests 'xt';
auto_set_repository;
WriteAll;
