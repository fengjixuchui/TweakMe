::ִ�б��ű���jdk�汾Ϊ1.8.0��dx�汾Ϊ30.0.2
::���jdk��1.8���߸��߰汾��Ҫ�����Ͱ汾�ֽ���ʱ������ʾָ���汾�ţ���-source -target ����ͬʱʹ��,������Ϊ��ͬ�İ汾��ֵ��-source 1.7 -target 1.7��
::���dx�İ汾�ϵͶ�javac�汾�ϸ�ʱ��dx��������dex�Ĺ����п��ܻ���ְ汾��ͻ����bad class file magic (cafebabe) or version (0034.0000)��
::����23.0.1�汾��dx�����ֻ֧�ֵ�jdk 1.7,���jdk��1.8����dx������23�汾���ϣ�����javac����ʱָ������1.7�汾���ֽ���

::javac������class�ļ����ȴ��jar����תΪdex������������
::jar -cf %~dp0\tmp\javatweak.jar -C %~dp0\tmp .
::dx --dex --output=%~dp0\javatweak.dex %~dp0\tmp\javatweak.jar

::javac������class�ļ�ֱ��תΪdex��������һ��
::dx --dex --output=%~dp0\javatweak.dex %~dp0\tmp

::dx��һ��bat�ű�����ȼ���java -jar %BUILD_TOOLS%\lib\dx.jar

@echo off
set ANDROID_VER=21
set ANDROID_SDK=%~dp0
set ANDROID_API=%ANDROID_SDK%\platforms\android-21
set BUILD_TOOLS=%ANDROID_SDK%\build-tools\30.0.2

set SRCDIR_TWEAKME=%~dp0\src
set SRCDIR_APPTWEAK=%SRCDIR_TWEAKME%\com\android\guobao\liao\apptweak
set SRCDIR_PLUGIN=%SRCDIR_APPTWEAK%\plugin
set SRCDIR_UTIL=%SRCDIR_APPTWEAK%\util

mkdir %~dp0\tmp
javac -bootclasspath %ANDROID_API%\android.jar -classpath %ANDROID_API%\optional\*;%~dp0\libs\* -d %~dp0\tmp %SRCDIR_APPTWEAK%\*.java %SRCDIR_PLUGIN%\*.java %SRCDIR_UTIL%\*.java
java -jar %BUILD_TOOLS%\lib\dx.jar --dex --min-sdk-version=%ANDROID_VER% --output=%~dp0\javatweak.dex %~dp0\libs\* %~dp0\tmp
rmdir /s /q %~dp0\tmp
