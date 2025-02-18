@echo off

if not exist "%1" (
    mkdir "%1"
)
cd "%1"

if not exist "%2" (
    mkdir "%2"
)
cd "%2"

set mes=%2
set ano=%1

set /a resto1=%ano% %% 4
set /a resto2=%ano% %% 100
set /a resto3=%ano% %% 400

if %resto1%==0 (
    if %resto2%==0 (
        if %resto3%==0 (
            set bissexto=1
        ) else (
            set bissexto=0
        )
    ) else (
        set bissexto=1
    )
)

if %mes%==1 set dias=31
if %mes%==2 (
    if %bissexto%==1 (
        set dias=29
    ) else (
        set dias=28
    )
)
if %mes%==3 set dias=31
if %mes%==4 set dias=30
if %mes%==5 set dias=31
if %mes%==6 set dias=30
if %mes%==7 set dias=31
if %mes%==8 set dias=31
if %mes%==9 set dias=30
if %mes%==10 set dias=31
if %mes%==11 set dias=30
if %mes%==12 set dias=31

echo O numero de dias no mes %mes% do ano %ano% é %dias%.

for /L %%i in (1,1,%dias%) do (
    mkdir %%i
)

cd ..