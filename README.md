#JWT (JSON Web Token)
===============================

##Build up 
--------------------------------

### command line
--------------------------------
<pre><code>
set JAVA_HOME=V:\java-1.8.0-openjdk-x86_64
set PATH=.;%JAVA_HOME%\jre\bin;%JAVA_HOME%\bin;V:\gradle\bin;
</code></pre>

### run the application
-------------------------------
V:myspringboot\> `gradlew bootRun`

build the JAR file & Run JAR file
-------------------------------
V:myspringboot\> `gradlew build`

Then you can run the JAR file:

V:myspringboot\> `java -jar build/libs/myspring.jar`


##Tomcat:
-------------------------------
<p> The APR based Apache Tomcat Native library:</p>

URL: http://tomcat.apache.org/download-native.cgi  下載合適版本的Tomcat Native檔案，下載的檔案包含有win32、i64、x64版本的tcnative-1.dll，請選擇符合您Tomcat版本的tcnative-1.dll置入Tomcat安裝路徑CATALINA_HOME/bin中，即可解決問題。

##Eclipse.ini: memory configuration
-------------------------------
<p> suggetion base on total RAM is 8G :</p>
-Xms1024m
-Xmx1024m
-Xmn384m
-XX:PermSize=512m
-XX:MaxPermSize=512m
--add-modules=ALL-SYSTEM
-javaagent:V:\eclipse-jee-photon-R-win32-x86_64\lombok.jar