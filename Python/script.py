'''
Logic:
Fetched exchange rates for today and yesterday using a public API (USD as base).
Filtered required currencies and compute percentage change between the two days.
Flagged currencies as "significant" if change exceeds 0.5%.
Stored results in a CSV file and log execution details (timestamp, status, errors).
'''

import requests
import pandas as pd
from datetime import datetime, timedelta
import logging


CURRENCIES = ["INR", "AED", "USD", "EUR", "GBP", "BRL", "MXN"]
BASE_URL = "https://api.frankfurter.app"

#Logging setup
logging.basicConfig(
    filename="exchange_rates.log",
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s"
)


#Fetch Rates


def fetch_rates(date):
    try:
        url = f"{BASE_URL}/{date}?from=USD"
        response = requests.get(url)
        data = response.json()
        return data["rates"]
    except Exception as e:
        logging.error(f"Error fetching rates for {date}: {e}")
        return {}



def main():
    try:
        today = datetime.today().strftime("%Y-%m-%d")
        yesterday = (datetime.today() - timedelta(days=1)).strftime("%Y-%m-%d")

        today_rates = fetch_rates(today)
        yesterday_rates = fetch_rates(yesterday)

        rows = []

        for currency in CURRENCIES:
            if currency == "USD":
                today_rate = 1.0
                yesterday_rate = 1.0
            else:
                today_rate = today_rates.get(currency)
                yesterday_rate = yesterday_rates.get(currency)

            if today_rate and yesterday_rate:
                pct_change = ((today_rate - yesterday_rate) / yesterday_rate) * 100
                significant = "YES" if abs(pct_change) > 0.5 else "NO"

                rows.append({
                    "currency": currency,
                    "today_rate": today_rate,
                    "yesterday_rate": yesterday_rate,
                    "%_change": round(pct_change, 4),
                    "significant": significant
                })

        df = pd.DataFrame(rows)

        # Save CSV
        filename = f"exchange_rates_{today}.csv"
        df.to_csv(filename, index=False)

        logging.info(f"Successfully generated report: {filename}")
        logging.info(f"Currencies processed: {CURRENCIES}")

        print("Report generated:", filename)

    except Exception as e:
        logging.error(f"Script failed: {e}")


if __name__ == "__main__":
    main()