import joblib

model = joblib.load("model.pkl")

message = input("Enter a message: ")

prediction = model.predict([message])[0]
probabilities = model.predict_proba([message])[0]

confidence = max(probabilities)

print(f"Prediction: {prediction}")
print(f"Confidence: {confidence:.2f}")