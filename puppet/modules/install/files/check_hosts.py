import json, sys, os

items = json.load(sys.stdin)["items"]

if len(items) == int(os.environ.get('NODE_COUNT', 1)):
    sys.exit(0)
else:
    sys.exit(1)
