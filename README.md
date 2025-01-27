# Contact Center Messaging SDK - iOS

> ⚠️ The software is a pre-release version. It may not operate correctly. It may be different from the
commercially released version. You may not use the software in the live opening environment unless
Microsoft permits you to do so under another agreement. You are highly encouraged to upgrade within
30 days following first availability of a commercial release of the software.

## Building the sample app - ContactCenterMessagingApp

Manual Integration:
1. Clone the repository.
2. Open the terminal and change directory to the root folder of ContactCenterMessagingApp.
3. Install pods : command : pod install
4. Manually download the xcframeworks from releases section for desired version and place into 
ContactCenterMessagingApp folder. https://github.com/microsoft/ContactCenterMessagingSDK-ios/releases
5. Open ContactCenterMessagingApp.xcworkspace.
6. Add credentials OrgID, OrgURL and WidgetId into ViewController class.
7. Run the application.

Integration through Cocoapods:
1. Clone the repository.
2. Open the terminal and change directory to the root folder of ContactCenterMessagingApp.
3. Open podfile and update ContactCenterMessagingSDK version.
4. Install pods : command : pod install
5. Open ContactCenterMessagingApp.xcworkspace.
6. Add credentials OrgID, OrgURL and WidgetId into ViewController class.
7. Run the application.


## Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a
Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us
the rights to use your contribution. For details, visit https://cla.opensource.microsoft.com.

When you submit a pull request, a CLA bot will automatically determine whether you need to provide
a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions
provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## Trademarks

This project may contain trademarks or logos for projects, products, or services. Authorized use of Microsoft 
trademarks or logos is subject to and must follow 
[Microsoft's Trademark & Brand Guidelines](https://www.microsoft.com/en-us/legal/intellectualproperty/trademarks/usage/general).
Use of Microsoft trademarks or logos in modified versions of this project must not cause confusion or imply Microsoft sponsorship.
Any use of third-party trademarks or logos are subject to those third-party's policies.
