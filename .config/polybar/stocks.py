#!/usr/bin/python3
import sys
import requests
from time import sleep
from lxml import html

BASE_URL = "https://www.nordnet.no/market/stocks/"
STOCKS = ["16874165-kahoot", "16120387-advanced-micro-devices"]
ICON_COLOR = "#444"
UP_COLOR = "#44cc44"
DOWN_COLOR = "#cf6060"

def main():
    previous = list()
    while True:
        output = ""
        for index, stock in enumerate(STOCKS):
            result = requests.get(BASE_URL + stock)
            page = html.fromstring(result.content)
            price = page.xpath("//span[text()='Siste']/following-sibling::*/span")[0].text
            try:
                if price > previous[index]:
                    underline = UP_COLOR
            except IndexError:
                previous.append(price)
            if price < previous[index]:
                underline = DOWN_COLOR
            elif price == previous[index]:
                underline = None
            previous[index] = price
            ticker = page.xpath("/html/body/div[1]/div/div[2]/main/div/div[1]/div/div/div[1]/div[1]/div/div[1]/div/div/h1/div/span")[0].text.strip("(").strip(")")
            if underline:
                output += f"{ticker}: %{{u{underline}}}%{{+u}}{price}%{{-u}} "
            else:
                output += f"{ticker}: {price} "
        print(output)
        sys.stdout.flush()
        sleep(15)

if __name__ == "__main__":
    main()
