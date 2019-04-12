FROM frolvlad/alpine-glibc AS docker-latex
# Install necessary fonts for HoGent
COPY ./fonts/* /usr/local/share/fonts/
# Enable Edge Repository
RUN sed -i -e 's/v3\.4/edge/g' /etc/apk/repositories
# Install Texlive and Biber
RUN apk update\
    && apk add texlive-full\
    texlive-xetex\
    biber\
    make\
    rsync\
    tar\
    libarchive-tools\
    gmp\
    curl
# Install Pandoc
RUN curl -Lsf 'https://github.com/jgm/pandoc/releases/download/1.17.2/pandoc-1.17.2-1-amd64.deb'\
    | bsdtar xOf - data.tar.gz\
    | tar xvz --strip-components 2 -C /usr/local
# Change WORKDIR
WORKDIR /usr/src/tex
