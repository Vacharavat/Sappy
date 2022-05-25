import pickle
import pandas as pd
from fastapi import FastAPI

# Prep model
model = pickle.load(open('model.pkl','rb'))

# Create HTTP Server
app = FastAPI()
@app.get("/emotion")
async def getEmotion(age: int = 0, bmi: int = 0, heart_rate: int = 0, diff_heart: int = 0):
  df = pd.DataFrame(data={"Age":[age],"Bmi":[bmi],"HeartRate":[heart_rate],"DiffHeart":[diff_heart]})
  result = model.predict(df.head(1))
  
  emotion = "neutral"
  for i in range(len(result[0])):
    if result[0][i] == 1 and i == 0:
      emotion = "happy"
    elif result[0][i] == 1 and i ==2:
      emotion = "angry"
    elif result[0][i] == 1 and i ==3:
      emotion = "sad"
  return {"emotion": emotion}

# STEP ->
# pip install "fastapi[all]"
# pip install "pandas"
# run api -> $ uvicorn main:app --reload
# local -> http://127.0.0.1:8000/emotion?age=21&bmi=19&heart_rate=101&diff_heart=60