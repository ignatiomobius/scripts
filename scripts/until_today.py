import datetime

start = datetime.datetime(2012, 5, 5)
today = datetime.datetime.today()

diff = (today - start).days

print diff
