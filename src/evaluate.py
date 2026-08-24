import joblib

from sklearn.metrics import accuracy_score


model = joblib.load("model.pkl")

X_test = [
    "You have won a free vacation",
    "Claim your reward now",
    "Let's have lunch tomorrow",
    "Can you send me the report?",
]

y_test = [
    "spam",
    "spam",
    "not_spam",
    "not_spam",
]

predictions = model.predict(X_test)

accuracy = accuracy_score(y_test, predictions)

print(f"Accuracy: {accuracy:.2%}")

if accuracy < 0.75:
    print("Model failed evaluation")
    raise SystemExit(1)

print("Model passed evaluation")


