# =============================
# Student Risk Prediction Model
# =============================

import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder, StandardScaler
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import classification_report, confusion_matrix
import pickle

# -----------------------------
# 1. Load Dataset
# -----------------------------
df = pd.read_csv("student_data.csv")  # replace with your dataset filename

# Separate features & target
X = df.drop("Target", axis=1)
y = df["Target"]

# -----------------------------
# 2. Preprocessing
# -----------------------------
# Encode categorical columns
for col in X.select_dtypes(include=["object"]).columns:
    le = LabelEncoder()
    X[col] = le.fit_transform(X[col].astype(str))

# Handle missing values
X.fillna(X.median(numeric_only=True), inplace=True)

# Scale numeric features
scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

# -----------------------------
# 3. Train-Test Split
# -----------------------------
X_train, X_test, y_train, y_test = train_test_split(
    X_scaled, y, test_size=0.2, random_state=42
)

# -----------------------------
# 4. Train Model
# -----------------------------
model = RandomForestClassifier(n_estimators=100, random_state=42)
model.fit(X_train, y_train)

# -----------------------------
# 5. Predictions & Evaluation
# -----------------------------
y_pred = model.predict(X_test)
y_prob = model.predict_proba(X_test)[:, 1]  # probabilities for positive class

print("Confusion Matrix:\n", confusion_matrix(y_test, y_pred))
print("\nClassification Report:\n", classification_report(y_test, y_pred))

# -----------------------------
# 6. Risk Categorization
# -----------------------------
risk_levels = []
for prob in y_prob:
    if prob >= 0.7:
        risk_levels.append("High Risk")
    elif prob >= 0.4:
        risk_levels.append("Medium Risk")
    else:
        risk_levels.append("Low Risk")

results = pd.DataFrame({
    "Actual": y_test,
    "Predicted": y_pred,
    "Risk_Probability": y_prob,
    "Risk_Level": risk_levels
})

print("\nSample Predictions with Risk Levels:\n", results.head(10))

# -----------------------------
# 7. Save Model for Backend Use
# -----------------------------
with open("student_risk_model.pkl", "wb") as f:
    pickle.dump(model, f)

# Save scaler too (important for preprocessing new data)
with open("scaler.pkl", "wb") as f:
    pickle.dump(scaler, f)
