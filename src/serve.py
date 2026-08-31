import os

import joblib
from flask import Flask, jsonify, request

app = Flask(__name__)

MODEL_PATH = os.getenv("MODEL_PATH", "model.pkl")

model = joblib.load(MODEL_PATH)


@app.route("/health", methods=["GET"])
def health():
    return jsonify({"status": "healthy"})


@app.route("/predict", methods=["POST"])
def predict():
    data = request.get_json()

    texts = data["texts"]

    predictions = model.predict(texts)

    return jsonify({"predictions": predictions.tolist()})


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)