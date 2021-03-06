# CoviScan

<img src="image1 2.jpeg" width="500" height="240"/>

## Covid-19/Pneumonia Detection Application through Chest Radiographs

Currently, Covid-19 can be diagnosed via RT-PCR to detect genetic material from the virus or chest radiographs. However, it can take a few hours and sometimes days before the molecular test results are back. By contrast, chest radiographs can be obtained in minutes. 

Through this application we will be helping in differentiating those patients which need more attention(severe cases) than others and reducing pressure on doctors to check every patients. With this application, doctors can identify critical patients instantly without wasting any minute. 

This application not only helps doctors but helps patients too. With one tap, patients can get to know what they are suffering from. Patients only need their X-ray images and rest of the work is done by the app. Patients can self assess themselves and can act accordingly without wasting any second. 

In this project, we have developed an iOS app. It is beautifully designed app with great UI which makes it very user friendly. Mostly the app is built on SwiftUI framework. Some parts of the app is built on Swift and UIKit especially the ImagePicker code and code related to displaying Lottie Animation. The app contains Login Page which is powered by Firebase. Features like Dark Mode and Persistent Login are also available. The app works on any iPhone and iPad which supports iOS 15 or above. Through this app, users will upload their X-ray images in order to identify whether they are suffering from COVID 19, Viral Pneumonia or they are completely fine. The app provides User Scan Log which displays all the scans uploaded by a particular user. This feature was implemented using Firebase's Firestore. 

Apart from this, the Computer Vision Classifier is also developed for this project is based on Convolution Neural Network(CNN) in Deep Learning it scans the images and publishes the result which is displayed on the user screen. User images are send to the model using APIs. 

<img src="ezgif.com-gif-maker.gif" width="500" height="240"/>

## Screenshots:

<p float="left">
  <img src="/image1.jpeg" width="160" />
  <img src="/image2.jpeg" width="160" />
  <img src="/image3.jpeg" width="160" />
  <img src="/image4.jpeg" width="160" />
  <img src="/image5.jpeg" width="160" />
</p>

## Video Link:
https://drive.google.com/file/d/155AsLOj9L4iH-DHyNLAdZ3E0Bz-Z88NO/view?usp=sharing

## Link for Computer Vision Classifier:
The Computer Vision Classifier is developed by Ayush Kumar:
https://github.com/ayush9304/covid19-detector-api


## Installation:
- Download Xcode from AppStore on Mac. 
- Clone this repository(or download zip). 
- Open the CoviScan.xcodeproj file using Xcode
- Set the Active Scheme to "CoviScan" and Simulator device to "iPhone 13"
- Run the project.
