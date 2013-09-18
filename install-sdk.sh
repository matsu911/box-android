#!/bin/sh

# Install SDK
wget "http://dl.google.com/android/android-sdk_r${sdk_version}-linux.tgz"
tar xzf "android-sdk_r${sdk_version}-linux.tgz"
rm "android-sdk_r${sdk_version}-linux.tgz"

export ANDROID_BUILD_TOOLS="18.0.1"

# Set environment variables
export ANDROID_HOME=${PWD}/android-sdk-linux
export PATH="${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools"

type android || { echo "Path: $PATH"; echo 'Android not availble after installation, terminating.'; exit 1; }

wget https://dl-ssl.google.com/android/repository/build-tools_r${ANDROID_BUILD_TOOLS}-linux.zip
unzip build-tools_r${ANDROID_BUILD_TOOLS}-linux.zip -d $ANDROID_HOME
mkdir -p $ANDROID_HOME/build-tools/
mv $ANDROID_HOME/android-4.3 $ANDROID_HOME/build-tools/${ANDROID_BUILD_TOOLS}

# Write environment variables setup to $profile
echo "export ANDROID_HOME=\"${ANDROID_HOME}\"" | sudo tee -a $profile
echo "export ANDROID_BUILD_TOOLS=\"${ANDROID_BUILD_TOOLS}\""
echo "export PATH=\"${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools\"" | sudo tee -a $profile

# Print $profile
echo -e "$profile updated to:\n\n$(cat $profile)"