FROM debian:11

# Dependencies
RUN apt-get update && apt-get upgrade
RUN apt-get install -y build-essential git

RUN apt-get install -y cmake qtbase5-dev qtbase5-dev-tools  \
	  qttools5-dev qttools5-dev-tools libqt5xmlpatterns5-dev  \
	  libqt5svg5-dev libarchive-dev libsndfile1-dev libasound2-dev  \
    liblo-dev libpulse-dev libcppunit-dev liblrdf-dev  \
    libjack-jackd2-dev

# Clone & Build
RUN git clone git://github.com/hydrogen-music/hydrogen.git
WORKDIR hydrogen/build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=/usr
RUN make -j$(nproc) && make install DESTDIR=AppDir

# Package
RUN wget https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage
RUN chmod +x linuxdeploy-x86_64.AppImage

./linuxdeploy-x86_64.AppImage --appdir AppDir
