# WalmartAssessment
Basic swift app that shows the NASA Astronomy Picture of the Day

[Nasa APi](https://api.nasa.gov/)

[Nasa official site](https://apod.nasa.gov/apod/astropix.html)

## App Achicteture 

**NasaPhoto App** :iphone: was developed using the **MVVM** architecture

MVVM-C:

**M**odel -> Represents data<p>
**V**iew -> Displays data<p>
**V**iew**M**odel -> Bussiness Logic and Data Binding<p>
  
 ### IMPROVEMENT AREAS
 - When starting, the orientation doesn't change to current orientation
 - Doesn't handle video streams, only images
 - Doesn't cover test cases due to lack to time.
 
 ## User Experience
The app is composed of two main screens:

### 1. Landing Screen
Space Picture screen occurs on load and is showing title about application. You can tap **"Show me the NASA Astronomy Picture of the Day"** to go to the detail screen.

### 2. Space Picture Detail
This screen is pushed onto the navigation controller. It shows extra details of todays picture returned from the APOD API.
