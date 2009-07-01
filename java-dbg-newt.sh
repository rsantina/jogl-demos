#! /bin/sh

MOSX=0
uname -a | grep -i Darwin && MOSX=1

CPOK=0
echo $CLASSPATH | grep jogl && CPOK=1

if [ $CPOK -eq 0 ] ; then
    # Only valid for autobuild .. otherwise run manually with build-dir
    . ./setenv-jogl.sh JOGL_ALL
    echo $CLASSPATH | grep jogl && CPOK=1
fi
if [ $CPOK -eq 0 ] ; then
    echo No JOGL in CLASSPATH
else
    # D_ARGS="-Dgluegen.debug.ProcAddressHelper=true -Dgluegen.debug.NativeLibrary=true -Dnativewindow.debug=all -Djogl.debug=all -Dnewt.debug=all"
    D_ARGS="-Dgluegen.debug.NativeLibrary=true -Dnativewindow.debug=all -Djogl.debug=all -Dnewt.debug=all"
    if [ $MOSX -eq 1 ] ; then
        X_ARGS="-XstartOnFirstThread"
    fi

    java $X_ARGS -Djava.awt.headless=true $D_ARGS com.sun.javafx.newt.util.MainThread $* 2>&1 | tee java-dbg-newt.log
fi
