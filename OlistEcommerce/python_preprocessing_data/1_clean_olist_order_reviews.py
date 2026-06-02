import pandas as pd
import re

input_path = r"C:\Personal\PetProjects\SQL\P1\data\olist_order_reviews_dataset.csv"
output_path = r"C:\Personal\PetProjects\SQL\P1\data\olist_order_reviews_dataset_clean.csv"

df = pd.read_csv(input_path, encoding="utf-8")

def clean_text(x):
    if pd.isna(x):
        return x
    x = str(x)
    # залишаємо нормальний текст, прибираємо emoji/special symbols
    return re.sub(r"[^\w\s.,!?;:()\-áéíóúâêôãõçÁÉÍÓÚÂÊÔÃÕÇ]", "", x)

df["review_comment_title"] = df["review_comment_title"].apply(clean_text)
df["review_comment_message"] = df["review_comment_message"].apply(clean_text)

df.to_csv(output_path, index=False, encoding="utf-8")