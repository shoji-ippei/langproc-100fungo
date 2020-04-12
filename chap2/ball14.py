import sys
import pandas as pd

args = sys.argv
if len(args) == 2:
    df = pd.read_csv('../data/popular-names.txt', header=None)
    print(df.head(int(args[1])))
else:
    print("f*ck off")
