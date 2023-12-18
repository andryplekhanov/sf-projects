import requests
import favicon
import os

site_url = os.environ.get("SITE_URL")

if site_url:
    try:
        icons = favicon.get(site_url)
        icon = icons[0]

        response = requests.get(icon.url, stream=True)
        with open('/opt/tmp/python-favicon.{}'.format(icon.format), 'wb') as image:
            for chunk in response.iter_content(1024):
                image.write(chunk)
        print(f"Готово!")
    except Exception as ex:
        print(f"Ошибка: {ex}")
else:
    print("Пожалуйста, укажите переменную SITE_URL с адресом сайта.")
