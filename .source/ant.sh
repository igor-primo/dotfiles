#!/bin/bash

export ANT_HOME=/home/igor/repos/ant/apache-ant-1.10.12
export ANT_OPTS=-Xmx1024m
export PATH=$PATH:/home/igor/repos/ant/apache-ant-1.10.12/bin
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
#export PATH=$PATH:$JAVA_HOME/bin
export CLASSPATH=/home/igor/repos/aima-java-AIMA3e/aima-core/build/bin/main
export CLASSPATH=$CLASSPATH:/home/igor/repos/aima-java-AIMA3e/aima-gui/build/bin/main
export CLASSPATH=$CLASSPATH:.
export JAVAFX_MODS_PATH=/home/igor/repos/fx/javafx-sdk-17.0.2/lib
export JAVAFX_MODS="javafx.fxml,javafx.media,javafx.swing,javafx.swt,javafx.web"
alias runjavafx="java --module-path $JAVAFX_MODS_PATH --add-modules $JAVAFX_MODS"
