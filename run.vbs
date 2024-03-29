thisFolder = createobject("Scripting.FileSystemObject").GetFolder(".").Path '获取当前目录

Dim dataDirectory
dataDirectory = ".\data\" 'ico数据目录
Dim target
target = thisFolder&"\data\main.exe" '目标

' name：快捷方式名称
' targetPath：快捷方式的执行路径
' Icon：快捷方式图标
' description：快捷方式的描述
' workingDirectory：起始位置
Function CreateShortcutOnDesktop(name, targetPath, Icon, description, workingDirectory)
    set WshShell    = Wscript.CreateObject("Wscript.Shell") 
    strDesktop  = WshShell.SpecialFolders("Desktop") '在桌面创建快捷方式
    set oShellLink  = WshShell.CreateShortcut(strDesktop&"\"&name&".lnk") '创建一个快捷方式对象
    oShellLink.TargetPath  = targetPath '设置快捷方式的执行路径 
    oShellLink.WindowStyle = 1 '运行方式
    oShellLink.IconLocation= Icon '设置快捷方式的图标
    oShellLink.Description = description  '设置快捷方式的描述 
    oShellLink.WorkingDirectory = workingDirectory '起始位置
    oShellLink.Save
End Function

Function main()
    Dim sFolder, sExt, message
    sFolder = dataDirectory
 
    Dim fs, oFolder, oFiles
    set fs = CreateObject("Scripting.FileSystemObject")
    set oFolder = fs.GetFolder(sFolder)     '获取文件夹
 
    set oFiles = oFolder.Files              '获取文件集合
    for each file in oFiles
        sExt = fs.GetExtensionName(file)    '获取文件扩展名
        sExt = LCase(sExt)                  '转换成小写
        
        if sExt = "ico" then
            fileNameArr = Split(file.Name, ".") '获取文件名（不含扩展名）：fileNameArr(0)
            Call CreateShortcutOnDesktop(fileNameArr(0), target, thisFolder&"\data\"&file.Name, target, thisFolder) '创建快捷方式
        End if
    Next
End Function

main()