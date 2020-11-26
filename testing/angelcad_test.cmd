@echo off
REM Run AngelCAD on all files in current directory
REM Copy this file to a folder containing script files *.as and/or *.scad

REM Set paths to OpenSCAD and AngelCAD installation folders here
SET ANGELCAD_PATH="D:\cpde_usr\bin"
SET OPENSCAD_PATH="C:\Program Files\OpenSCAD"
REM
REM Files will be created in xcsg subfolder
REM We delete all files in this subfolder before we begin
mkdir xcsg
del /Q xcsg\*

REM Process all AngelCAD *.as files in this folder
for %%d in (*.as) do (
   %ANGELCAD_PATH%\as_csg "%%d" -outsub=xcsg
   %ANGELCAD_PATH%\xcsg --stl --dxf "xcsg\%%~nd.xcsg"
)

REM Process all OpenSCAD *.scad files in this folder
for %%d in (*.scad) do (
   %OPENSCAD_PATH%\openscad "%%d" --o="xcsg\%%~nd.csg"
   %ANGELCAD_PATH%\csgfix -scad="%%d" -csg="xcsg\%%~nd.csg"
   %ANGELCAD_PATH%\xcsg --stl --dxf "xcsg\%%~nd.csg"
)
REM Create a simple report: check if STL or DXF files were produced
echo ========
echo RESULTS
echo ========
@echo off
for %%d in (*.scad,*.as) do (
  if exist "xcsg\%%~nd.stl" (
     echo OK   %%d 
  ) else if exist "xcsg\%%~nd.dxf" (
     echo OK   %%d 
  ) else (
     echo FAIL %%d 
  )
)