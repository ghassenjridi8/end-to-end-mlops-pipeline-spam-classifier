import argparse

import joblib
import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.linear_model import LogisticRegression
from sklearn.pipeline import Pipeline

parser = argparse.ArgumentParser()

parser.add_argument(
    "--dataset",
    required=True,
    help="Path to the training dataset",
)

parser.add_argument(
    "--output",
    default="model.pkl",
    help="Path where the trained model should be saved",
)

args = parser.parse_args()

data = pd.read_csv(args.dataset)

X = data["text"]
y = data["label"]

model = Pipeline(
    [
        ("tfidf", TfidfVectorizer()),
        ("classifier", LogisticRegression()),
    ]
)

model.fit(X, y)

joblib.dump(model, args.output)

print("Training complete")
print(f"Model saved to {args.output}")