@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
set globalTest=foo

call testsub.bat 0
call testsub.bat 2

