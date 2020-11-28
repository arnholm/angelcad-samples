@echo off
setlocal ENABLEDELAYEDEXPANSION
REM Run AngelCAD on all files in current directory
REM Copy this file to a folder containing script files *.as and/or *.scad

REM Set your paths to OpenSCAD and AngelCAD installation folders here
SET OPENSCAD_PATH="C:\Program Files\OpenSCAD"
SET ANGELCAD_PATH="D:\cpde_usr\bin"
REM
REM Files will be created in xcsg subfolder
REM We delete all files in this subfolder before we begin
mkdir xcsg
del /Q xcsg\*

REM Process all AngelCAD *.as files in this folder
for %%d in (*.as) do (
   set PROCESS="true"

   echo.
   echo ---------------
   if !PROCESS! == "true" ( 
       echo --- RUNNING %%d
       %ANGELCAD_PATH%\as_csg "%%d" -outsub=xcsg
       %ANGELCAD_PATH%\xcsg --stl --dxf "xcsg\%%~nd.xcsg"
   ) 
   echo.
)

REM Process all OpenSCAD *.scad files in this folder
for %%d in (*.scad) do (
   set PROCESS="true"
   REM some libraries we do not want to  process directly 
   if "%%d"=="Fillet.scad" ( set PROCESS="false" )
   if "%%d"=="sweep.scad" ( set PROCESS="false" )
   if "%%d"=="threads.scad" ( set PROCESS="false" )
   if "%%d"=="Write.scad" ( set PROCESS="false" )
   if "%%d"=="rulers.scad" ( set PROCESS="false" )
   
   echo.
   echo ---------------
   if !PROCESS! == "true" ( 
     echo --- RUNNING %%d 
     %OPENSCAD_PATH%\openscad "%%d" --o="xcsg\%%~nd.csg"
     %ANGELCAD_PATH%\csgfix -scad="%%d" -csg="xcsg\%%~nd.csg"
     %ANGELCAD_PATH%\xcsg --stl --dxf "xcsg\%%~nd.csg"     
   ) else (
     echo --- SKIPPING %%d 
     fsutil file createnew "xcsg\%%~nd.skipped" 0
   )
   echo.
)
REM Make a report
echo ========
echo RESULTS
echo ========
@echo off
for %%d in (*.scad,*.as) do (
  if exist "xcsg\%%~nd.stl"  (   
      echo OK   %%d 
  ) else if exist "xcsg\%%~nd.dxf"  (   
      echo OK   %%d 
  ) else if exist "xcsg\%%~nd.skipped"  (   
      echo SKIP %%d 
  ) else (  echo FAIL %%d   )
)
:Finish
