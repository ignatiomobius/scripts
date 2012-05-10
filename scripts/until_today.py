import datetime

start = datetime.datetime(2012, 5, 6)
today = datetime.datetime.today()

diff = (today - start).days

print diff
