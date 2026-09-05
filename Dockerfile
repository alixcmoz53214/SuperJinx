FROM alpine:latest

RUN apk update && apk add --no-cache \
    ca-certificates \
    curl \
    tzdata \
    openssl \
    bash \
    sqlite

WORKDIR /app

# دانلود نسخه ۲.۹.۴ پنل ۳ایکس‌یوآی
RUN curl -Ls https://github.com/mhsanaei/3x-ui/releases/download/v2.9.4/x-ui-linux-amd64.tar.gz | tar xz

# انتقال اسکریپت استارت و تنظیم دسترسی
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh && chmod +x /app/x-ui/x-ui

EXPOSE 2053

CMD ["/app/entrypoint.sh"]
