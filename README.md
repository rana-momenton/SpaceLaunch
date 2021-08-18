Hi, I just had one day to do this assignment, which was a working day :) below is just simple points for adopted architecture with some future improvements which I would have done if given more time.

# Installation

- This project is using exrernal pods library like Rxswift, RxCocoa and RxBlocking. Just need to do pod install before running the project.
- Once pods has been installed properly, please open .xcworkspace file.

# Architecture

- Uses MVVM archicture
- Uses RXSwift to bind networkApi<->ViewModels and ViewModels<->views
- Written unit tests for happy path scenarios

## Future Improvements

- Caching to Image loading.
- Proper loading indicators for UI states.
- Make details screen scrollable for smaller devices.