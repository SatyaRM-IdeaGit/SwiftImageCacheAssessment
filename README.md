# iOS Image caching assessment - Satyaranjan Mohapatra
iOS App to cache images using disk and memory cache without thirdparty library as requested by the assessment related PDF.

## Project Architecture or Structure and other details: 
* Used MVVM architecture as its better compare to normal MVC, more cleaner and manageable for small scale projects. Other modern architectures will be overkill in this case.
* No navigation used as not required by the assessment document	
* `URLCache` has been used which uses both in-memory and on-disk cache unlike `NSCache` which uses only in-memory cache and needs manual effort to store details on disc.
* As `URLCache` itself is a very strong tool to manage disk memory as well, explicit code to manage the image with disk memory was not added to reduce complexity.
* If disk space is really needed, then we can use `FileManager` and its methods to our benefit
* Place holder images are used from [Uxwing](https://uxwing.com/) which are free licensed.
* [QuicType.io](https://app.quicktype.io) used for quick JSON parsing
* No other 3rd party SDKs used as mentioned in the assessment document
* As many aspects of the UI were not very clear, kept it very simple (for UI customisation, some sort of design or reference will be needed)

## My System Details - Used for Development:
* Language - Swift 5
* iOS - 16.2 (default - no specific reason otherwise)
* Xcode - Version 14.2 (14C18) (Max supported Xcode)
* macOS Monterey 12.7.4 (21H1123) (Max supported OS)
* MacBook Pro (Retina, 15-inch, Mid 2015)

## Instructions to Run:
As per above system details, there should not be any problem to directly run the code.
The `ImageCacheAssessment.xcodeproj` file can directly be opened in Xcode and hit the `run` / `play` button to run the app on a simulator or phone.
As this doesn't haveany hardware dependency checking real hardware is optional

