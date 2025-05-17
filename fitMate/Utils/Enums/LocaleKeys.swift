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
        static let title: String = "homeTitle"
        static let goodMorning: String = "homeGoodMorning"
        static let goodAfternoon: String = "homeGoodAfternoon"
        static let goodEvening: String = "homeGoodEvening"
        static let goodNight: String = "homeGoodNight"
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
    
    
}

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
