#!/bin/bash
set -e

setupIfNeeded(){
    if [ ! -f ".packages" ]; then
        echo "Missing .packages... setting up now!"
        echo -e "\n\n"
        pub get
        echo -e "\n\n"
    fi

    PACKAGE_LIST="$(pub global list)"

    if [[ ! $PACKAGE_LIST == *"coverage"* ]]; then
        echo "Missing coverage package... activating now!"
        echo -e "\n\n"
        pub get
        pub global activate coverage
        echo -e "\n\n"
    fi
}

setupIfNeeded

dart --pause-isolates-on-exit --enable-vm-service=8111 test/test_all.dart & sleep 5
pub global run coverage:collect_coverage --port=8111 -o coverage.json --resume-isolates
pub global run coverage:format_coverage --packages=.packages -i coverage.json -o coverage.lcov --lcov --report-on=lib/
genhtml coverage.lcov --title "coverage report" --output-directory coverage_report
open coverage_report/index.html
