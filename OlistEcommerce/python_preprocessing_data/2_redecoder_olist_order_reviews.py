with open(
    r"C:\Personal\PetProjects\SQL\P1\data\olist_order_reviews_dataset_clean.csv",
    "r",
    encoding="utf-8"
) as f:
    text = f.read()

with open(
    r"C:\Personal\PetProjects\SQL\P1\data\olist_order_reviews_dataset_clean_1251.csv",
    "w",
    encoding="cp1251",
    errors="replace"
) as f:
    f.write(text)