//
//  ThemeFile.swift
//  ContactCenterMessagingApp
//
//  Created by Microsoft on 30/08/21.
//  Copyright © 2024 Microsoft. All rights reserved.
//

import Foundation
import UIKit

enum MyProjectTheme {
    case ThemeBlack
    case ThemeLightGreen
    case ThemeDarkGreen
                
    //#0b56a2
    //rgb(11,86,162)
    private struct MyThemeBlack {
        static var isDarkTheme = true;
        
        static var lightGrayColor: UIColor { return UIColor(red: 11/255.0, green: 86/255.0, blue: 86/255.0, alpha: 1.0) }
        static var textGrayColor: UIColor { return UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0) }
        static var darkBackgroundShadowColor: UIColor { return UIColor(red: 86/255.0, green: 140/255.0, blue: 52/255.0, alpha: 1.0) }
        
        static var emailDarkBackgroundColor: UIColor { return UIColor(red: 109/255.0, green: 70/255.0, blue: 247/255.0, alpha: 1.0) }
        static var emailLightBackgroundColor: UIColor { return UIColor(red: 240/255.0, green: 240/255.0, blue: 255/255.0, alpha: 1.0) }
        static var emailCancelBtnColor: UIColor { return UIColor(red: 56/255.0, green: 57/255.0, blue: 56/255.0, alpha: 1.0) }
                
        static var agentMsgBorderColor: UIColor { return UIColor(red: 56/255.0, green: 57/255.0, blue: 56/255.0, alpha: 1.0) }
        static var customerMsgBorderColor: UIColor { return UIColor(red: 109/255.0, green: 70/255.0, blue: 247/255.0, alpha: 1.0) }
        
        static var topTitleColor: UIColor { return UIColor(red: 109/255.0, green: 70/255.0, blue: 247/255.0, alpha: 1.0) }
        static var topTitleTextColor: UIColor { return UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0) }

        static var sendBtnColor: UIColor { return UIColor(red: 56/255.0, green: 57/255.0, blue: 56/255.0, alpha: 1.0) }
        static var sendBtnBorderColor: UIColor { return UIColor(red: 56/255.0, green: 57/255.0, blue: 56/255.0, alpha: 1.0) }
        static var sendBtnDisableBorderColor: UIColor { return UIColor(red: 56/255.0, green: 57/255.0, blue: 56/255.0, alpha: 1.0) }

        static var darkBackgroundColor: UIColor { return UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0) }
        static var lightBackgroundColor: UIColor { return UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0) }

        static var textFieldTextColor: UIColor { return UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0) }
        static var textFieldBorderColor: UIColor { return UIColor(red: 120/255.0, green: 120/255.0, blue: 120/255.0, alpha: 1.0) }
        static var textFieldBackgroundColor: UIColor { return UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0) }

        static var imgCustomerName = "Person_black.png"

    }
    
    private struct MyThemeDarkGreen {
        
        static var isDarkTheme = false;
        
        static var agentMsgBorderColor: UIColor { return UIColor(red: 241/255.0, green: 243/255.0, blue: 238/255.0, alpha: 1.0) }
        static var customerMsgBorderColor: UIColor { return UIColor(red: 11/255.0, green: 86/255.0, blue: 52/255.0, alpha: 1.0) }
        
        static var topTitleColor: UIColor { return UIColor(red: 86/255.0, green: 140/255.0, blue: 52/255.0, alpha: 1.0) }
        static var topTitleTextColor: UIColor { return UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0) }

        static var sendBtnColor: UIColor { return UIColor(red: 86/255.0, green: 140/255.0, blue: 52/255.0, alpha: 1.0) }
        static var sendBtnBorderColor: UIColor { return UIColor(red: 86/255.0, green: 140/255.0, blue: 52/255.0, alpha: 1.0) }
        static var sendBtnDisableBorderColor: UIColor { return UIColor(red: 86/255.0, green: 140/255.0, blue: 52/255.0, alpha: 1.0) }

        static var darkBackgroundColor: UIColor { return UIColor(red: 86/255.0, green: 140/255.0, blue: 52/255.0, alpha: 1.0) } // Customer msg
        static var lightBackgroundColor: UIColor { return UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0) } // Middle + bottom (textfield + send ) background depends upon
        
        static var textFieldTextColor: UIColor { return UIColor(red: 120/255.0, green: 120/255.0, blue: 120/255.0, alpha: 1.0) }
        static var textFieldBorderColor: UIColor { return UIColor(red: 120/255.0, green: 120/255.0, blue: 120/255.0, alpha: 1.0) }
        static var textFieldBackgroundColor: UIColor { return UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0) }

        
        static var lightGrayColor: UIColor { return UIColor(red: 241/255.0, green: 243/255.0, blue: 238/255.0, alpha: 1.0) }
        static var textGrayColor: UIColor { return UIColor(red: 120/255.0, green: 120/255.0, blue: 120/255.0, alpha: 1.0) }
        static var darkBackgroundShadowColor: UIColor { return UIColor(red: 86/255.0, green: 140/255.0, blue: 52/255.0, alpha: 1.0) }
        
        static var emailDarkBackgroundColor: UIColor { return UIColor(red: 86/255.0, green: 140/255.0, blue: 52/255.0, alpha: 1.0) } // Customer msg
        static var emailLightBackgroundColor: UIColor { return UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0) } // Middle + bottom (textfield + send ) background depends upon
        static var emailCancelBtnColor: UIColor { return UIColor(red: 120/255.0, green: 120/255.0, blue: 120/255.0, alpha: 1.0) }

        static var imgCustomerName = "Person.png"

    }

    private struct MyThemeLightGreen {
        static var isDarkTheme = false;
        
        static var agentMsgBorderColor: UIColor { return UIColor(red: 241/255.0, green: 243/255.0, blue: 238/255.0, alpha: 1.0) }
        static var customerMsgBorderColor: UIColor { return UIColor(red: 125/255.0, green: 168/255.0, blue: 58/255.0, alpha: 1.0) }
        
        static var topTitleColor: UIColor { return UIColor(red: 125/255.0, green: 168/255.0, blue: 58/255.0, alpha: 1.0) }
        static var topTitleTextColor: UIColor { return UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0) }

        static var sendBtnColor: UIColor { return UIColor(red: 125/255.0, green: 168/255.0, blue: 58/255.0, alpha: 1.0) }
        static var sendBtnBorderColor: UIColor { return UIColor(red: 125/255.0, green: 168/255.0, blue: 58/255.0, alpha: 1.0) }
        static var sendBtnDisableBorderColor: UIColor { return UIColor(red: 125/255.0, green: 168/255.0, blue: 58/255.0, alpha: 1.0) }

        static var darkBackgroundColor: UIColor { return UIColor(red: 125/255.0, green: 168/255.0, blue: 58/255.0, alpha: 1.0) } // Customer msg
        static var lightBackgroundColor: UIColor { return UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0) } // Middle + bottom (textfield + send ) background depends upon
        
        static var textFieldTextColor: UIColor { return UIColor(red: 120/255.0, green: 120/255.0, blue: 120/255.0, alpha: 1.0) }
        static var textFieldBorderColor: UIColor { return UIColor(red: 120/255.0, green: 120/255.0, blue: 120/255.0, alpha: 1.0) }
        static var textFieldBackgroundColor: UIColor { return UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0) }

        
        static var lightGrayColor: UIColor { return UIColor(red: 241/255.0, green: 243/255.0, blue: 238/255.0, alpha: 1.0) } // agentMSg
        static var textGrayColor: UIColor { return UIColor(red: 120/255.0, green: 120/255.0, blue: 120/255.0, alpha: 1.0) } // agentMSgTextColor
        static var darkBackgroundShadowColor: UIColor { return UIColor(red: 86/255.0, green: 140/255.0, blue: 52/255.0, alpha: 1.0) }
        
        static var emailDarkBackgroundColor: UIColor { return UIColor(red: 125/255.0, green: 168/255.0, blue: 58/255.0, alpha: 1.0) } // Customer msg
        static var emailLightBackgroundColor: UIColor { return UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0) } // Middle + bottom (textfield + send ) background depends upon
        static var emailCancelBtnColor: UIColor { return UIColor(red: 120/255.0, green: 120/255.0, blue: 120/255.0, alpha: 1.0) }

        static var imgCustomerName = "Person_lightGreen.png"

    }
    
    struct ThemeDetails {
        var isDarkTheme = false;
        
        var agentMsgBorderColor: UIColor
        var customerMsgBorderColor: UIColor
        
        var topTitleColor: UIColor
        var topTitleTextColor: UIColor

        var sendBtnColor: UIColor
        var sendBtnBorderColor: UIColor
        var sendBtnDisableBorderColor: UIColor

        var darkBackgroundColor: UIColor
        var lightBackgroundColor: UIColor
        
        var textFieldTextColor: UIColor
        var textFieldBorderColor: UIColor
        var textFieldBackgroundColor: UIColor

        
        var lightGrayColor: UIColor
        var textGrayColor: UIColor
        var darkBackgroundShadowColor: UIColor
        
        var emailDarkBackgroundColor: UIColor
        var emailLightBackgroundColor: UIColor
        var emailCancelBtnColor: UIColor
        
        var header1Font: UIFont { return UIFont (name: "HelveticaNeue", size: 20.0)!}
        var header2Font: UIFont { return UIFont (name: "HelveticaNeue", size: 16.0)!}
        var paragraphFont: UIFont { return UIFont (name: "HelveticaNeue", size: 14.0)!}
        var miniParagraphFont: UIFont { return UIFont (name: "HelveticaNeue", size: 12.0)!}
        
        var imgCustomerName : String?
    }
    
    func getThemeDetails() -> ThemeDetails {
        switch self {
        case .ThemeBlack, .ThemeLightGreen, .ThemeDarkGreen:
//            #1d55a2
//            Hex:
//            #1d55a2
//
//            RGB: #2F6DBC
            let colorBlue = UIColor(red: 47/255.0, green: 90/255.0, blue: 146/255.0, alpha: 1.0)
            return ThemeDetails(agentMsgBorderColor:colorBlue,
                                customerMsgBorderColor: colorBlue,
                                topTitleColor: colorBlue,
                                topTitleTextColor: UIColor.white,
                                sendBtnColor: UIColor.clear,
                                sendBtnBorderColor: colorBlue,
                                sendBtnDisableBorderColor: colorBlue,
                                darkBackgroundColor: MyProjectTheme.MyThemeBlack.darkBackgroundColor,
                                lightBackgroundColor: MyProjectTheme.MyThemeBlack.lightBackgroundColor,
                                textFieldTextColor: UIColor.lightGray,
                                textFieldBorderColor: UIColor.clear,
                                textFieldBackgroundColor: UIColor.white,
                                lightGrayColor: MyProjectTheme.MyThemeBlack.lightGrayColor,
                                textGrayColor: MyProjectTheme.MyThemeBlack.textGrayColor,
                                darkBackgroundShadowColor: UIColor.white,
                                emailDarkBackgroundColor: MyProjectTheme.MyThemeBlack.emailDarkBackgroundColor,
                                emailLightBackgroundColor: MyProjectTheme.MyThemeBlack.emailLightBackgroundColor,
                                emailCancelBtnColor: MyProjectTheme.MyThemeBlack.emailCancelBtnColor,
                                imgCustomerName: MyProjectTheme.MyThemeBlack.imgCustomerName
                                )
            
        }
    }
}

