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
