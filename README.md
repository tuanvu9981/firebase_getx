## Firebase_Getx

Login & Logout with getx Flutter

### Reference
1. [Video 1](https://www.youtube.com/watch?v=o_ZeLqpqt90)
2. [Video 2](https://www.youtube.com/watch?v=V2c04_JWoHA&t=105s)
3. [Assets & Documentation](https://www.dbestech.com/tutorials/flutter-firebase-firestore-app)
4. [Video 3 - CRUD FireStore](https://www.youtube.com/watch?v=n1PM9XcYD5s)

### Take note about UI 
1. **crossAxisAlignment** will have **NO EFFECT** if there 's no width or height attributes. It must be
```
Container(
    width: screenW,
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

        ]
    )
)
```

### Take note about Flutter
1. Firebase FireStore refused to connect, and Flutter warned: "Caller had no permission".
```
rules_version = '2';
service cloud.firestore {
match /databases/{database}/documents {
match /{document=**} {
  allow read, write: if false;
  }
 }
}
```
must be changed to:
```
rules_version = '2';
service cloud.firestore {
match /databases/{database}/documents {
 match /{document=**} {
  allow read, write: if request.auth != null;
  }
 }
}
```
2. With StatefulWidget, when update value of attributes, it NEEDED TO WRITTEN INSIDE **setState**, or it will be **uninitialized**

3. Fix bug: **minSdkVersion cannot be less than 19.0**
```
defaultConfig {    
    applicationId "com.example.firebase_getx"
    minSdkVersion 19
}
```