import datetime

start = datetime.datetime(2010, 7, 29)
today = datetime.datetime.today()

diff = (today - start).days

if (diff % 2) == 0:
	print("free")
else:
	print("on duty")
