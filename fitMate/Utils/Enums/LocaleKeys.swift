//
//  LocaleKeys.swift
//  fitMate
//
//  Created by Emre Simsek on 2.11.2024.
//

import Foundation
import SwiftUICore

enum LocaleKeys {
    enum App {
        static let nameFirst: String = "appNameFirst"
        static let nameLast: String = "appNameLast"
    }

    enum General {
        static let loading: String = "generalLoading"
        static let shortMinutes: String = "generalShortMinutes"

        static let stepsType: String = "generalStepsType"
    }

    enum Measurement {
        static let steps: String = "measurementSteps"
        static let calories: String = "measurementCalories"
        static let bpm: String = "measurementBpm"
        static let weight: String = "measurementWeight"
        static let height: String = "measurementHeight"
        static let bodyFat: String = "measurementBodyFat"
        static let muscleMass: String = "measurementMuscleMass"
        static let bmi: String = "measurementBmi"
        static let waistCircumference: String = "measurementWaistCircumference"
        static let days: String = "measurementDays"
    }
    
    enum Placeholder {
        static let username: String = "placeholderUsername"
    }
    
    enum Language {
        static let title: String = "languageTitle"
        static let subtitle: String = "languageSubtitle"
        static let turkish: String = "languageTurkish"
        static let english: String = "languageEnglish"
    }

    enum Button {
        static let cancel: String = "buttonCancel"
        static let ok: String = "buttonOk"
        static let next: String = "buttonNext"
        static let back: String = "buttonBack"
        static let done: String = "buttonDone"
        static let save: String = "buttonSave"
        static let delete: String = "buttonDelete"
        static let rename: String = "buttonRename"
        static let accept: String = "buttonAccept"
    }

    enum WelcomeView {
        static let getStarted: String = "welcomeGetStarted"
        static let subTitle: String = "welcomeSubTitle"
    }

    enum SignUp {
        static let title: String = "signUpTitle"
        static let name: String = "signUpName"
        static let email: String = "signUpEmail"
        static let password: String = "signUpPassword"
        static let repeatPassword: String = "signUpRepeatPassword"
        static let button: String = "signUpButton"
        static let loginButton: String = "signUpLoginButton"
        static let bottomText: String = "signUpBottomText"
    }

    enum Login {
        static let title: String = "loginTitle"
        static let email: String = "loginEmail"
        static let password: String = "loginPassword"
        static let button: String = "loginButton"
        static let signUpButton: String = "loginSignUpButton"
        static let bottomText: String = "loginBottomText"
    }

    enum Home {
        static let stepTitle: String = "homeStepTitle"

        enum AskAI {
            static let title: String = "homeAskAITitle"
            static let subTitle: String = "homeAskAISubTitle"
        }

        enum NavTime {
            static let goodMorning: String = "homeNavTimeGoodMorning"
            static let goodAfternoon: String = "homeNavTimeGoodAfternoon"
            static let goodEvening: String = "homeNavTimeGoodEvening"
            static let goodNight: String = "homeNavTimeGoodNight"
        }

        enum HealthItems {
            static let steps: String = "homeHealthSteps"
            static let calories: String = "homeHealthCalories"
            static let distance: String = "homeHealthDistance"
            static let heartRate: String = "homeHealthHeartRate"
        }

        enum Motivation {
            static let first: String = "homeMotivationFirst"
            static let second: String = "homeMotivationSecond"
            static let third: String = "homeMotivationThird"
            static let fourth: String = "homeMotivationFourth"
        }
    }

    enum HomeTabView {
        static let home: String = "homeTabViewHome"
        static let chat: String = "homeTabViewChat"
        static let profile: String = "homeTabViewProfile"
    }

    enum Chat {
        static let title: String = "chatTitle"
        static let placeholder: String = "chatPlaceholder"
        static let aiName: String = "chatAIName"
        static let userName: String = "chatUserName"
        static let openAIName: String = "chatOpenAIName"
        static let mistralAIName: String = "chatMistralAIName"
        
        enum Alert {
            static let deleteTitle: String = "chatAlertDeleteTitle"
            static let premiumTitle: String = "chatAlertPremiumTitle"
            static let premiumButtonTitle: String = "chatAlertPremiumButtonTitle"
        }
        
        enum Snackbar {
           static let suggestionApplied: String = "chatSnackbarSuggestionApplied"
              static let deleteSuccess: String = "chatSnackbarDeleteSuccess"
        }
    }

    enum Profile {
        static let title: String = "profileTitle"
        static let personalInformation: String = "profilePersonalInformation"
        static let email: String = "profileEmail"
        static let gender: String = "profileGender"
        static let age: String = "profileAge"
        static let height: String = "profileHeight"
        static let weight: String = "profileWeight"
        static let goals: String = "profileGoals"
        static let signOut: String = "profileSignOut"
        static let signOutDialog: String = "profileSignOutDialog"
        static let signOutCancel: String = "profileSignOutCancel"
        static let updateConfirmation: String = "profileUpdateConfirmation"
        
        enum GeneralSheet {
            static let title: String = "profileGeneralSheetTitle"
            static let nameTitle: String = "profileGeneralSheetNameTitle"
            static let namePlaceholder: String = "profileGeneralSheetNamePlaceholder"
            static let emailTitle: String = "profileGeneralSheetEmailTitle"
            static let emailPlaceholder: String = "profileGeneralSheetEmailPlaceholder"
            static let weightTitle: String = "profileGeneralSheetWeightTitle"
            static let weightPlaceholder: String = "profileGeneralSheetWeightPlaceholder"
            static let heightTitle: String = "profileGeneralSheetHeightTitle"
            static let heightPlaceholder: String = "profileGeneralSheetHeightPlaceholder"
            static let birthdayTitle: String = "profileGeneralSheetBirthdayTitle"
            static let genderTitle: String = "profileGeneralSheetGenderTitle"
            static let fitnessLevelTitle: String = "profileGeneralSheetFitnessLevelTitle"
            static let goalsTitle: String = "profileGeneralSheetGoalsTitle"
            static let stepGoalTitle: String = "profileGeneralSheetStepGoalTitle"
            static let privacyPolicyTitle: String = "profileGeneralSheetPrivacyPolicyTitle"
            static let privacyPolicyText: String = "profileGeneralSheetPrivacyPolicyText"
        }
        
        enum General {
            static let title: String = "profileGeneralTitle"
            static let settings: String = "profileGeneralSettings"
            static let credits: String = "profileGeneralCredits"
            static let notifications: String = "profileGeneralNotifications"
            static let language: String = "profileGeneralLanguage"
            static let units: String = "profileGeneralUnits"
        }
        
        enum SupportUs {
            static let title: String = "profileSupportUsTitle"
            static let share: String = "profileSupportUsShare"
            static let rate: String = "profileSupportUsRate"
            static let tip: String = "profileSupportUsTip"
        }
        
        enum Others {
            static let title: String = "profileOthersTitle"
            static let appName: String = "profileOthersAppName"
            static let version: String = "profileOthersVersion"
            static let privacyPolicy: String = "profileOthersPrivacyPolicy"
            static let signOut: String = "profileOthersSignOut"
        }
        
        enum Summary {
            static let title: String = "profileSummaryTitle"
            static let workouts: String = "profileSummaryWorkouts"
            static let diets: String = "profileSummaryDiets"
            static let steps: String = "profileSummarySteps"
        }
    }

    enum Error {
        static let signInError: String = "errorSignIn"
        static let signUpError: String = "errorSignUp"
        static let unknownError: String = "errorUnknown"
        static let networkError: String = "errorNetwork"
        static let invalidEmail: String = "errorInvalidEmail"
        static let weakPassword: String = "errorWeakPassword"
        static let emailAlreadyInUse: String = "errorEmailAlreadyInUse"
        static let userNotFound: String = "errorUserNotFound"
        static let wrongPassword: String = "errorWrongPassword"
        static let passwordsDoNotMatch: String = "errorPasswordsDoNotMatch"
        static let emptyName: String = "errorEmptyName"
        static let emptyEmail: String = "errorEmptyEmail"
        static let emptyPassword: String = "errorEmptyPassword"
    }

    enum Onboard {
        static let subTitle: String = "onboardSubTitle"
        static let bottomButton: String = "onboardBottomButton"

        enum Gender {
            static let title: String = "onboardGenderTitle"
            static let secondTitle: String = "onboardGenderSecondTitle"
            static let male: String = "onboardGenderMale"
            static let female: String = "onboardGenderFemale"
            static let bottomText: String = "onboardGenderBottomText"
        }

        enum Physical {
            static let title: String = "onboardPhysicalTitle"
            static let height: String = "onboardPhysicalHeight"
            static let weight: String = "onboardPhysicalWeight"
        }

        enum Goal {
            static let title: String = "onboardGoalTitle"
            static let loseWeightTitle: String = "onboardGoalLoseWeightTitle"
            static let loseWeightSubTitle: String =
                "onboardGoalLoseWeightSubTitle"
            static let getFitterTitle: String = "onboardGoalGetFitterTitle"
            static let getFitterSubTitle: String =
                "onboardGoalGetFitterSubTitle"
            static let gainMusclesTitle: String = "onboardGoalGainMusclesTitle"
            static let gainMusclesSubTitle: String =
                "onboardGoalGainMusclesSubTitle"
        }
    }

    enum Tracking {
        static let type: String = "trackingType"
    }

    enum Workout {
        static let title: String = "workoutTitle"
        static let navTitle: String = "workoutNavTitle"
        static let programsTitle: String = "workoutProgramsTitle"
        static let noProgramsTitle: String = "workoutNoProgramsTitle"
        static let noProgramsSubTitle: String = "workoutNoProgramsSubTitle"
        static let addProgramsTitle: String = "workoutAddProgramsTitle"
        static let summaryTitle: String = "workoutSummaryTitle"
        static let historyTitle: String = "workoutHistoryTitle"
        static let addLogTitle: String = "workoutAddLogTitle"
        static let noLogsTitle: String = "workoutNoLogsTitle"
        
        enum Snackbar {
            static let logAddedTitle: String = "workoutSnackbarLogAddedTitle"
            static let workoutAddedTitle: String = "workoutSnackbarWorkoutAddedTitle"
        }

        enum Summary {
            static let totalTraining: String = "workoutSummaryTotalTraining"
            static let lastTraining: String = "workoutSummaryLastTraining"
            static let weeklyAverage: String = "workoutSummaryWeeklyAverage"
            static let weeklyAverageWorkout: String = "workoutSummaryWeeklyAverageWorkout"
            static let mostTrainingDay: String = "workoutSummaryMostTrainingDay"
            static let setChartDate: String = "workoutSummarySetChartDate"
            static let setChartSets: String = "workoutSummarySetChartSets"
            static let workoutFrequencyDay: String = "workoutSummaryWorkoutFrequencyDay"
            static let workoutFrequencyWorkouts: String = "workoutSummaryWorkoutFrequencyWorkouts"
        }

        enum CreateWorkout {
            static let name: String = "workoutCreateWorkoutName"
            static let exampleName: String = "workoutCreateWorkoutExampleName"
            static let daysNumber: String = "workoutCreateWorkoutDaysNumber"
            static let daysNumberDay: String = "workoutCreateWorkoutDaysNumberDay"
            static let daysAndExercises: String = "workoutCreateWorkoutDaysAndExercises"
            static let dayName: String = "workoutCreateWorkoutDayName"
            static let addExercise: String = "workoutCreateWorkoutAddExercise"
            static let navTitle: String = "workoutCreateWorkoutNavTitle"
        }

        enum AddLog {
            static let dateTitle: String = "workoutAddLogDateTitle"
            static let datePlaceholder: String = "workoutAddLogDatePlaceholder"
            static let workoutTitle: String = "workoutAddLogWorkoutTitle"
            static let workoutPlaceholder: String = "workoutAddLogWorkoutPlaceholder"
            static let dayPlaceholder: String = "workoutAddLogDayPlaceholder"
            static let noPlaceholder: String = "workoutAddLogNoPlaceholder"
            static let exerciseTitle: String = "workoutAddLogExerciseTitle"
            static let addExercise: String = "workoutAddLogAddExercise"
            static let navTitle: String = "workoutAddLogNavTitle"
        }

        enum AddDay {
            static let name: String = "workoutAddDayName"
            static let title: String = "workoutAddDayTitle"
            static let namePlaceholder: String = "workoutAddDayNamePlaceholder"
            static let addExercise: String = "workoutAddDayAddExercise"
            static let navTitle: String = "workoutAddDayNavTitle"
        }

        enum AddExercise {
            static let name: String = "workoutAddExerciseName"
            static let sets: String = "workoutAddExerciseSets"
            static let reps: String = "workoutAddExerciseReps"
            static let weight: String = "workoutAddExerciseWeight"
            static let notes: String = "workoutAddExerciseNotes"
            static let navTitle: String = "workoutAddExerciseNavTitle"
        }

        enum EditExercise {
            static let navTitle: String = "workoutEditExerciseNavTitle"
        }

        enum Exercise {
            static let deleteAlertTitle: String = "workoutExerciseDeleteAlertTitle"
        }

        enum Day {
            static let deleteAlertTitle: String = "workoutDayDeleteAlertTitle"
            static let addExercise: String = "workoutDayAddExercise"
            static let name: String = "workoutDayName"
        }

        enum Program {
            static let deleteAlertTitle: String = "workoutProgramDeleteAlertTitle"
            static let addDay: String = "workoutProgramAddDay"
            static let name: String = "workoutProgramName"
        }

        enum Log {
            static let deleteAlertTitle: String = "workoutLogDeleteAlertTitle"
            static let noProgram: String = "workoutLogNoProgram"
            static let noDay: String = "workoutLogNoDay"
            static let date: String = "workoutLogDate"
            static let program: String = "workoutLogProgram"
            static let day: String = "workoutLogDay"
            static let exercises: String = "workoutLogExercises"
            static let navTitle: String = "workoutLogNavTitle"
        }
    }

    enum Diet {
        static let title: String = "dietTitle"
        static let navTitle: String = "dietNavTitle"
        static let addDietTitle: String = "dietAddDietTitle"
        static let addLogTitle: String = "dietAddLogTitle"
        
        enum AddDiet {
            static let durationTitle: String = "dietAddDietDurationTitle"
            static let duration: String = "dietAddDietDuration"
            static let weightGoalTitle: String = "dietAddDietWeightGoalTitle"
            static let loseWeightGoal: String = "dietAddDietLoseWeightGoal"
            static let weightGoal: String = "dietAddDietWeightGoal"
            static let dailyGoalsTitle: String = "dietAddDietDailyGoalsTitle"
            static let calorieLimit: String = "dietAddDietCalorieLimit"
            static let stepCount: String = "dietAddDietstepCount"
            static let proteinGoal: String = "dietAddDietProteinGoal"
            static let navTitle: String = "dietAddDietNavTitle"
        }

        enum ActiveState {
            static let addLogButtonTitle: String = "dietActiveStateAddLogButton"
            static let dailyLogsTitle: String = "dietActiveStateDailyLogsTitle"
            static let deleteLogConfirmation: String = "dietActiveStateDeleteLogConfirmation"

            enum Summary {
                static let title: String = "dietActiveStateSummaryTitle"
                static let plan: String = "dietActiveStateSummaryPlan"
                static let remainingDays: String = "dietActiveStateSummaryRemainingDays"
                static let weightGoal: String = "dietActiveStateSummaryWeightGoal"
                static let calorieLimit: String = "dietActiveStateSummaryCalorieLimit"
                static let stepGoal: String = "dietActiveStateSummaryStepGoal"
                static let proteinGoal: String = "dietActiveStateSummaryProteinGoal"
            }

            enum Average {
                static let title: String = "dietActiveStateAverageTitle"
                static let remainingDays: String = "dietActiveStateAverageRemainingDays"
                static let averageCalories: String = "dietActiveStateAverageAverageCalories"
                static let averageSteps: String = "dietActiveStateAverageAverageSteps"
            }

            enum LogDetail {
                static let steps: String = "dietActiveStateLogDetailSteps"
                static let calories: String = "dietActiveStateLogDetailCalories"
                static let cardio: String = "dietActiveStateLogDetailCardio"
                static let protein: String = "dietActiveStateLogDetailProtein"
                static let carbs: String = "dietActiveStateLogDetailCarbs"
                static let fats: String = "dietActiveStateLogDetailFats"
                static let notes: String = "dietActiveStateLogDetailNotes"
            }
        }

        enum EmptyState {
            static let title: String = "dietEmptyStateTitle"
            static let buttonTitle: String = "dietEmptyStateButton"
        }

        enum AddLog {
            static let dateTitle: String = "dietAddLogDateTitle"
            static let datePlaceholder: String = "dietAddLogDatePlaceholder"
            static let stepsTitle: String = "dietAddLogStepsTitle"
            static let stepsPlaceholder: String = "dietAddLogStepsPlaceholder"
            static let dailyTitle: String = "dietAddLogDailyTitle"
            static let cardioTitle: String = "dietAddLogCardioDinner"
            static let caloriesTitle: String = "dietAddLogCaloriesTitle"
            static let proteinTitle: String = "dietAddLogProteinTitle"
            static let carbsTitle: String = "dietAddLogCarbsTitle"
            static let fatsTitle: String = "dietAddLogFatsTitle"
            static let notesTitle: String = "dietAddLogNotesTitle"
            static let navTitle: String = "dietAddLogNavTitle"
            static let snackTitle: String = "dietAddLogSnackTitle"
        }
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
