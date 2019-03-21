#!/bin/bash
set -ex

if [ -z "${linting_path}" ] ; then
  echo " [!] Missing required input: linting_path"
  exit 1
fi

FLAGS=''

if [ "${strict}" = "yes" ] ; then
  FLAGS=$FLAGS' --strict'
fi

if [ -s "${lint_config_file}" ] ; then
  FLAGS=$FLAGS' --config '"${lint_config_file}"  
fi

report_file='swiftlint_report'

case $reporter in
    xcode|emoji)
      report_file="${report_file}.txt"
      ;;
    markdown)
      report_file="${report_file}.md"
      ;; 
    csv|html)
      report_file="${report_file}.${reporter}"
      ;;
    checkstyle|junit)
      report_file="${report_file}.xml"
      ;; 
    json|sonarqube)
      report_file="${report_file}.json"
      ;; 
esac

cd "${linting_path}"

swiftlint lint --reporter "${reporter}" ${FLAGS} > "${reporter_path}/${report_file}"
