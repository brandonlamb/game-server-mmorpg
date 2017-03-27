
set export_excel_script_file=E:\Mofun\draco\tech\server\draco\trunk\src\sh\xls\export_excel.py
set gamedata_xls_path=E:\Mofun\draco\public\gameData\xls
set res_log_file=00_export_xls_result.log

echo ------------------------
echo script_file = %export_excel_script_file% > %res_log_file%
echo xls_path = %gamedata_xls_path% >> %res_log_file%
echo ------------------------

echo ------ begin ------ >> %res_log_file%
python %export_excel_script_file% %gamedata_xls_path% >> %res_log_file%
echo ------ finish ------ >> %res_log_file%

Pause