import pandas as pd
import sqlite3

db_path = ""
csv_path = ""

connection = sqlite3.connect(db_path) 

df = pd.read_csv(csv_path)
df.to_sql(db_path, connection, if_exists='append', index=False)