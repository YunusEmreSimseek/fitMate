# 🏋️‍♀️ FitMate - AI-Powered Personal Fitness Coach

**FitMate** is a SwiftUI 6-based iOS application designed for beginner gym users and individuals experiencing social anxiety. It combines personalized fitness tracking with a custom-trained AI assistant to support users in their workout, diet, and wellness journey.

---

## 📱 Features

- 🧠 **AI Chatbot** – Answering questions about training, nutrition, and recovery (powered by OpenAI or custom fine-tuned models)
- 🏃‍♂️ **Daily Goals** – Track steps, calories, sleep, and protein intake
- 📝 **Workout & Diet Plans** – Customizable weekly workout routines and diet process tracking
- 📷 **Image Recognition** – Upload gym equipment images and receive instant descriptions & usage tips
- 📊 **Analytics & Summaries** – Visual charts for progress tracking, most used program, training frequency, etc.
- 🔁 **Suggestion System** – AI-generated actionable suggestions (e.g., setStepGoal, setCalorieGoal, setWorkoutProgram)
- 🔒 **Offline Custom Model** – Option to use a local Mistral-7B model fine-tuned on fitness-related Turkish data

---

## 🧠 AI Integration

### OpenAI (GPT-4o)
- Function calling support
- JSON-based suggestions for in-app actions
- Vision API for gym equipment image analysis

### Custom Model (LoRA Fine-Tuned Mistral-7B)
- Trained on:
  - `stackexchange_fitness`
  - `mental_health_and_fitness_data`
- Uses PEFT + Bitsandbytes for low-resource training
- Hosted via FastAPI + Colab + ngrok

---

## 🛠️ Tech Stack

| Component       | Tech Used                     |
|----------------|-------------------------------|
| Language        | Swift 5.10 / SwiftUI 6        |
| Backend         | Firebase Auth & Firestore     |
| AI Platform     | OpenAI API + LoRA/Mistral     |
| Dependency Injection | Swinject               |
| State Management| `@Observable`, `.environment()` |
| Architecture    | MVVM + Async/Await            |

---

## 📷 Screenshots

| **Home** | **Home** |
|:--:|:--:|
| ![](screenshots/home_1.PNG) | ![](screenshots/home_2.PNG) |

| **Chat** | **Chat** | **Chat** |
|:--:|:--:|:--:|
| ![](screenshots/openai_1.PNG) | ![](screenshots/openai_2.PNG) | ![](screenshots/mistral.PNG) |


| **Login** | **SignUp** |
|:--:|:--:|
| ![](screenshots/login.PNG) | ![](screenshots/sign_up.PNG) |




