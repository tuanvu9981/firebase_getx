## Firebase_Getx

Login & Logout with getx Flutter

### Illustration
<table align="center">
  <tr align="center">
    <th>
        <img 
            src="https://github.com/tuanvu9981/firebase_getx/blob/master/illustration/1_signin.jpg"
            width="60%" 
            height="60%"
        />
    </th>
    <th>
        <img 
            src="https://github.com/tuanvu9981/firebase_getx/blob/master/illustration/2_main_screen.jpg"
            width="60%" 
            height="60%"
        />
    </th>
    <th>
        <img 
            src="https://github.com/tuanvu9981/firebase_getx/blob/master/illustration/3_add_new_car.jpg"
            width="60%" 
            height="60%"
        />
    </th>
  </tr>

  <tr>
    <td align="center"><b>Màn hình đăng nhập</b></td>
    <td align="center"><b>Màn hình chính</b></td>
    <td align="center"><b> Màn hình thêm mới 1 xe</b></td>
  </tr>
</table>

<table align="center">
  <tr align="center">
    <th>
        <img 
            src="https://github.com/tuanvu9981/firebase_getx/blob/master/illustration/4_update_car_begin.jpg"
            width="60%" 
            height="60%"
        />
    </th>
    <th>
        <img 
            src="https://github.com/tuanvu9981/firebase_getx/blob/master/illustration/5_update_car_selected_image.jpg"
            width="60%" 
            height="60%"
        />
    </th>
    <th>
        <img 
            src="https://github.com/tuanvu9981/firebase_getx/blob/master/illustration/6_delete_cars.jpg"
            width="60%" 
            height="60%"
        />
    </th>
  </tr>

  <tr>
    <td align="center"><b>Màn hình update thông tin xe</b></td>
    <td align="center"><b>Màn hình hiển thị ảnh đã xe mới đã được chọn</b></td>
    <td align="center"><b>Màn hình xác nhận xóa xe</b></td>
  </tr>
</table>

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