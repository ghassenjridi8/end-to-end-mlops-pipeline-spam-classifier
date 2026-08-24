import joblib
import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.linear_model import LogisticRegression
from sklearn.pipeline import Pipeline

data = pd.read_csv("data/messages.csv")

X = data["text"]
y = data["label"]

model = Pipeline([
    ("tfidf", TfidfVectorizer()),
    ("classifier", LogisticRegression())
])

model.fit(X, y)

joblib.dump(model, "model.pkl")

print("Training complete")
print("Model saved to model.pkl")