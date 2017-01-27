import csv
import numpy as np
import urllib.request




companies_names = ['AAPL', 'C', 'GE', 'JNJ', 'JPM', 'MSFT', 'ORCL', 'PFE', 'PG', 'T', 'WFC', 'XOM']

def download_csv_file(companies_names):
  for company in companies_names:
    url = 'http://chart.finance.yahoo.com/table.csv?s=' + company +\
     '&a=0&b=1&c=2006&d=11&e=31&f=2015&g=m&ignore=.csv'
    print("Download "+ company + ".csv from " + url)
    # Download the file from `url` and save it locally under `file_name`:
    urllib.request.urlretrieve(url, company + '.csv')



def create_csv(file_name, dates, companies_names, adjusted_close):
    with open(file_name, 'w') as csvfile:
        fieldnames = ['Date'] + companies_names
        spamwriter = csv.writer(csvfile, delimiter=',')

        spamwriter.writerow(fieldnames)
        for i in range(len(dates)):
          spamwriter.writerow([dates[i]] + list(np.array(adjusted_close)[:,i]))


def extract_adjusted_close():
  adjusted_close = []
  for company_name in companies_names:
    file_name = company_name + '.csv'
    y = np.genfromtxt(file_name, delimiter=",", skip_header=1, dtype=float, usecols=-1)
    adjusted_close.append(y)

  return adjusted_close

def extract_date():
  some_company_name = companies_names[0] + ".csv"
  dates = np.genfromtxt(some_company_name, delimiter=',', skip_header=1, dtype=str, usecols=0)
  return dates

def check_length(adjusted_close):
  length = len(adjusted_close[0])
  for i in adjusted_close:
    if length != len(i):
      return False

  return True

def run():
  download_csv_file(companies_names)

  adjusted_close = extract_adjusted_close()

  dates = extract_date()

  file_name = 'out.csv' 
  create_csv(file_name, dates, companies_names, adjusted_close)

  print("Finished: result in", file_name)


if __name__ == '__main__':
  run()





