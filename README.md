#JWT (JSON Web Token)
===============================

##Build up 
--------------------------------

### command line
--------------------------------
<pre><code>
set JAVA_HOME=V:\Java64\jdk1.8.0_45
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
