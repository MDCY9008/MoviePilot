FROM python:3.10.11-slim
ENV LANG="C.UTF-8" \
    TZ="Asia/Shanghai" \
    PS1="\u@\h:\w \$ " \
    PUID=0 \
    PGID=0 \
    UMASK=000 \
    WORKDIR="/MoviePilot" \
    CONFIG_DIR="/config" \
    API_TOKEN="moviepilot" \
    LIBRARY_PATH="" \
    SUPERUSER="admin" \
    SUPERUSER_PASSWORD="password" \
    SEARCH_SOURCE="themoviedb" \
    SCRAP_SOURCE="themoviedb" \
    COOKIECLOUD_HOST="https://nastool.org/cookiecloud" \
    COOKIECLOUD_KEY="" \
    COOKIECLOUD_PASSWORD="" \
    USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36 Edg/113.0.1774.57" \
    MESSAGER="telegram" \
    TELEGRAM_TOKEN="" \
    TELEGRAM_CHAT_ID="" \
    DOWNLOADER="qbittorrent" \
    QB_HOST="127.0.0.1:8080" \
    QB_USER="admin" \
    QB_PASSWORD="adminadmin" \
    MEDIASERVER="emby" \
    EMBY_HOST="http://127.0.0.1:8096" \
    EMBY_API_KEY="" \
    FILTER_RULE="!BLU & 4K & CN > !BLU & 1080P & CN > !BLU & 4K > !BLU & 1080P" \
    TRANSFER_TYPE="copy" \
    DOUBAN_USER_IDS=""
WORKDIR ${WORKDIR}
COPY . .
RUN pip install cython && pip install -r requirements.txt \
    && python_ver=$(python3 -V | awk '{print $2}') \
    && echo "${WORKDIR}/" > /usr/local/lib/python${python_ver%.*}/site-packages/app.pth \
    && echo 'fs.inotify.max_user_watches=5242880' >> /etc/sysctl.conf \
    && echo 'fs.inotify.max_user_instances=5242880' >> /etc/sysctl.conf \
    && rm -rf /root/.cache/
EXPOSE 3001
VOLUME ["/config"]
ENTRYPOINT [ "python3", "app/main.py" ]
