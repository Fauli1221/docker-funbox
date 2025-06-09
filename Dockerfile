FROM debian:bookworm

MAINTAINER Fauli1221 <contact@fauli1221.de>

# Notes:
# - libaa-bin is aafire
# - perl, libcurses-perl and make are used to run asciiquarium for example.
# - curl, watch, imagemagick, vlc and youtube-dl are just useful for so many of those commands.

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        aview \
        bb \
        binclock \
        boxes \
        caca-utils \
        cmatrix \
        cowsay \
        curl \
        figlet \
        fortune \
        imagemagick \
        libaa-bin \
        libcurses-perl \
        linuxlogo \
        make \
        nyancat \
        perl \
        rig \
        sl \
        toilet \
        vlc \
        watch \
        xaos \
        lolcat \
        wget \

    && echo "Install yt-dlp" \
    && curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp \
    && chmod a+rx /usr/local/bin/yt-dlp \

    && echo "Install asciiquarium" \
    && cpan -i Term::Animation \
    && curl -L http://www.robobunny.com/projects/asciiquarium/asciiquarium.tar.gz -o asciiquarium.tar.gz \
    && tar -zxvf asciiquarium.tar.gz asciiquarium_1.1/asciiquarium \
    && cp asciiquarium_1.1/asciiquarium /usr/local/bin \
    && chmod 0755 /usr/local/bin/asciiquarium \
    && rm -rf asciiquarium_1.1 asciiquarium.tar.gz \

    && echo "Install Falling Hearts" \
    && curl -L https://raw.githubusercontent.com/lbarchive/yjl/master/Bash/falling-%3C3s.sh -o /usr/local/bin/falling-hearts \
    && chmod +x /usr/local/bin/falling-hearts \

    && echo "Install pipes" \
    && curl -L https://raw.githubusercontent.com/pipeseroni/pipes.sh/master/pipes.sh -o /usr/local/bin/pipes \
    && chmod +x /usr/local/bin/pipes \

    && echo "Install Ponysay" \
    && wget https://vcheng.org/ponysay/ponysay_3.0.3+20210327-1_all.deb \
    && apt install ./ponysay_3.0.3+20210327-1_all.deb \

    && echo "Clean-up" \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ponysay_3.0.3+20210327-1_all.deb \

    && useradd --uid 1000 -m --shell /usr/sbin/nologin johncapcom

USER johncapcom

# Include /usr/games in PATH
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

# We support 256color, right? If not, you can always change this environment variable.
ENV TERM=xterm-256color

# youtube helper script
ADD youtube /usr/local/bin/youtube

ADD examples /examples
ADD menu.sh /

CMD ["/menu.sh"]
