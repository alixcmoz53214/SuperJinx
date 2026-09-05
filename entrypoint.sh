#!/bin/bash

# مسیر دیتابیس پنل
DB_PATH="/etc/x-ui/x-ui.db"
mkdir -p /etc/x-ui

# اگر رای‌وی دامنه داد، ازش استفاده کن، وگرنه مقدار خالی یا پیش‌فرض
if [ -n "$RAILWAY_STATIC_URL" ]; then
    DOMAIN="$RAILWAY_STATIC_URL"
elif [ -n "$RAILWAY_PUBLIC_DOMAIN" ]; then
    DOMAIN="$RAILWAY_PUBLIC_DOMAIN"
else
    DOMAIN=""
fi

# اجرای اولیه پنل برای ساخته شدن دیتابیس (اگر وجود نداشته باشه)
/app/x-ui/x-ui &
sleep 3

# اگر دیتابیس وجود داشت و دامنه هم ست شده بود، دامنه ساب‌لینک رو اتوماتیک آپدیت کن
if [ -f "$DB_PATH" ] && [ -n "$DOMAIN" ]; then
    echo "Updating sub-link domain to: $DOMAIN"
    sqlite3 "$DB_PATH" "UPDATE settings SET value='$DOMAIN' WHERE key='subDomain';" 2>/dev/null
    sqlite3 "$DB_PATH" "UPDATE settings SET value='$DOMAIN' WHERE key='webBasePath';" 2>/dev/null
fi

# نگه داشتن پنل در حال اجرا
wait
