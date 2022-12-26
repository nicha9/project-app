# Flutter App - TU IVAR
TU IVAR (Indirect Vision Accuracy Report) - แอปพลิเคชันสำหรับตรวจแบบฝึกทักษะการมองเห็นทางอ้อมผ่านกระจกส่องปากของนักศึกษาทันตแพทย์ ที่ฝึกโดยใช้เครื่องมือที่พัฒนาโดยคณะทันตแพทย์ มหาวิทยาลัยธรรมศาสตร์

### Directory Tree
```bash
.
│   .gitignore
│   .metadata
│   analysis_options.yaml
│   pubspec.lock
│   pubspec.yaml
│   README.md
│
├───android
│   │   .gitignore
│   │   build.gradle
│   │   gradle.properties
│   │   settings.gradle
│   │
│   ├───app
│   │   │   build.gradle
│   │   │   google-services.json
│   │   │
│   │   └───src
│   │       ├───debug
│   │       │       AndroidManifest.xml
│   │       │
│   │       ├───main
│   │       │   │   AndroidManifest.xml
│   │       │   │
│   │       │   ├───kotlin
│   │       │   │   └───com
│   │       │   │       └───example
│   │       │   │           └───test_project_db
│   │       │   │                   MainActivity.kt
│   │       │   │
│   │       │   └───res
│   │       │       ├───drawable
│   │       │       │       launch_background.xml
│   │       │       │
│   │       │       ├───drawable-v21
│   │       │       │       launch_background.xml
│   │       │       │
│   │       │       ├───mipmap-hdpi
│   │       │       │       ic_launcher.png
│   │       │       │
│   │       │       ├───mipmap-mdpi
│   │       │       │       ic_launcher.png
│   │       │       │
│   │       │       ├───mipmap-xhdpi
│   │       │       │       ic_launcher.png
│   │       │       │
│   │       │       ├───mipmap-xxhdpi
│   │       │       │       ic_launcher.png
│   │       │       │
│   │       │       ├───mipmap-xxxhdpi
│   │       │       │       ic_launcher.png
│   │       │       │
│   │       │       ├───values
│   │       │       │       styles.xml
│   │       │       │
│   │       │       └───values-night
│   │       │               styles.xml
│   │       │
│   │       └───profile
│   │               AndroidManifest.xml
│   │
│   └───gradle
│       └───wrapper
│               gradle-wrapper.properties
│
├───images
│       dentist.png
│       loginBG.png
│       pattern1.jpg
│       pattern2.jpg
│       pattern3.jpg
│       pattern4.jpg
│       pt1.svg
│       pt2.svg
│       pt3.svg
│       pt4.svg
│       tipBG.png
│       tipBG2.png
│       tipBG3-5.png
│       tipBG3-6.png
│       tipBG3.png
│       tipBG4.png
│       userProfile.png
│
├───ios
│   │   .gitignore
│   │
│   ├───Flutter
│   │       AppFrameworkInfo.plist
│   │       Debug.xcconfig
│   │       Release.xcconfig
│   │
│   ├───Runner
│   │   │   AppDelegate.swift
│   │   │   GoogleService-Info.plist
│   │   │   Info.plist
│   │   │   Runner-Bridging-Header.h
│   │   │
│   │   ├───Assets.xcassets
│   │   │   ├───AppIcon.appiconset
│   │   │   │       Contents.json
│   │   │   │       Icon-App-1024x1024@1x.png
│   │   │   │       Icon-App-20x20@1x.png
│   │   │   │       Icon-App-20x20@2x.png
│   │   │   │       Icon-App-20x20@3x.png
│   │   │   │       Icon-App-29x29@1x.png
│   │   │   │       Icon-App-29x29@2x.png
│   │   │   │       Icon-App-29x29@3x.png
│   │   │   │       Icon-App-40x40@1x.png
│   │   │   │       Icon-App-40x40@2x.png
│   │   │   │       Icon-App-40x40@3x.png
│   │   │   │       Icon-App-60x60@2x.png
│   │   │   │       Icon-App-60x60@3x.png
│   │   │   │       Icon-App-76x76@1x.png
│   │   │   │       Icon-App-76x76@2x.png
│   │   │   │       Icon-App-83.5x83.5@2x.png
│   │   │   │
│   │   │   └───LaunchImage.imageset
│   │   │           Contents.json
│   │   │           LaunchImage.png
│   │   │           LaunchImage@2x.png
│   │   │           LaunchImage@3x.png
│   │   │           README.md
│   │   │
│   │   └───Base.lproj
│   │           LaunchScreen.storyboard
│   │           Main.storyboard
│   │
│   ├───Runner.xcodeproj
│   │   │   project.pbxproj
│   │   │
│   │   ├───project.xcworkspace
│   │   │   │   contents.xcworkspacedata
│   │   │   │
│   │   │   └───xcshareddata
│   │   │           IDEWorkspaceChecks.plist
│   │   │           WorkspaceSettings.xcsettings
│   │   │
│   │   └───xcshareddata
│   │       └───xcschemes
│   │               Runner.xcscheme
│   │
│   └───Runner.xcworkspace
│       │   contents.xcworkspacedata
│       │
│       └───xcshareddata
│               IDEWorkspaceChecks.plist
│               WorkspaceSettings.xcsettings
│
├───lib
│   ├───model
│   │       resultModel.dart
│   │       userModel.dart
│   │
│   ├───pages
│   │       addPracticePic.dart
│   │       confirmPic.dart
│   │       forgotpassword.dart
│   │       graphPage.dart
│   │       home.dart
│   │       login.dart
│   │       logout.dart
│   │       register.dart
│   │       result.dart
│   │       studentDetail.dart
│   │       studentList.dart
│   │       teacherGraph.dart
│   │       teacherHome.dart
│   │       tip.dart
│   │       triallog.dart
│   │
│   └───widget
│           background.dart
│           createGraph.dart
│           histList.dart
│           menubar.dart
│           overallGraph.dart
│
└───test
        widget_test.dart
 ```
## Getting Start
สามารถทำตามคำแนะนำเพื่อทำการนสำเนาโปรแกรมไปติดตั้ง เพื่อใช้ในการพัฒนาบนอุปกรณ์ของตนเองได้ โดย service ที่ทางทีมผู้พัฒนาได้พัฒนาไว้สามารถใช้งานได้ถึงวันที่ 1 กุมภาพันธ์ พ.ศ.2566 หากใช้งานภายในระยะเวลานี้สามารถข้ามขั้นตอนการสร้าง Server ไปยังขั้นตอนการสร้าง Flutter App ได้เลย

**สามารถดูรายละเอียดการติดตั้งเพิ่มเติมได้ที่วิดีโอ demo

### ขั้นตอนการจัดเตรียม Server
1. สร้างบัญชี Google cloud
    สามารถสมัครได้ที่: https://cloud.google.com/
    
2. ไปที่หน้า Console เลือกเมนู Compute Engine และเลือก VM instance
3. Enable API
4. Create instance ทำการแก้ไข Boot Disk โดยเปลี่ยนเป็นระบบปฏิบัติการ Ubuntu 22.04 LTS
![image](https://user-images.githubusercontent.com/116788784/209475306-e57d3492-55bd-492b-b361-91edb677ab41.png)
5. คลิกเลือกตัวเลือก Allow HTTP traffic และกด create
6. คลิกที่ไอคอน dropdown บริเวณคำว่า SSH เลือก View gcloud command และ RUN IN CLOUD SHELL
7. ตรวจสอบว่ามี python3 และ pip หรือไม่ หากไม่มีให้ทำการติดตั้ง
> หากพบ Error: Permission denied ให้ใช้คำสั่ง
        ```
        sudo apt install python3-pip
        ```
        
> หากพบปัญหา Error: Package 'python3-pip' has no installation candidate ให้ทำการ update apt-get โดยใช้คำสั่ง
        ```
        sudo apt-get update
        ```
       และทำการติดตั้ง python3-pip อีกครั้ง
8. ทำการสร้างไฟล์สำหรับประมวลผลภาพแบบฝึกทักษะ โดยทำการคัดลอกโค้ดในแต่ละไฟล์บน google drive ในโฟลเดอร์ server มาเขียนใหม่โดยใช้คำสั่ง nano ให้ครบทุกไฟล์
``` python
nano app.py
#copy code app.py from google drive and paste to create file.
```
9. ทำการติดตั้งทรัพยากรที่ใช้ โดยใช้คำสั่ง 
``` python
pip install -r requirements.txt
```
10. รัน server ด้วยคำสั่ง 
``` python
python3 app.py
```
> หากพบปัญหา ImportError: libGL.so.1: cannot open shared object file: No such file or directory ให้ใช้คำสั่ง
        ```
        sudo apt-get install ffmpeg libsm6 libxext6 -y
        ```
11. เปิดหน้า VM instance คลิก link ของ External IP
![image](https://user-images.githubusercontent.com/116788784/209476063-ab553b34-f3b9-4903-9d0a-784fbb1d78a4.png)
12. แก้ไข url โดยทำเปลี่ยน protocol จาก https เป็น http และระบุ port :8080 หาก server สามารถใช้งานได้จะแสดงคำว่า "Server is now available."


### ขั้นตอนการจัดเตรียม Flutter App
ในการพัฒนาทีมผู้พัฒนาได้พัฒนาบนอุปกรณ์ที่มีระบบปฏิบัติการ windows
1. ติดตั้ง Flutter
    สามารถดาวน์โหลดได้จาก: https://docs.flutter.dev/get-started/install
2. ติดตั้ง Android Studio
    สามารถดาวน์โหลดได้จาก: https://developer.android.com/studio
3. ติดตั้ง Git
    สามารถดาวน์โหลดได้จาก: https://git-scm.com/downloads 
4. เปิด Android Studio คลิกไปที่บริเวณไอคอนรูปจุดสามจุด แล้วเลือก Get from Version Control
5. ใส่ URL: https://github.com/nicha9/project-app.git และ clone
6. ติดตั้ง flutter plugin
7. กดที่ Add configuration เลือกเครื่องหมายบวก Add new configuration ที่มุมบนซ้าย แล้วเลือกไปที่ Flutter
8. ในส่วนของ Dart entrypoint: เลือกโฟลเดอร์ project > lib > pages > login.dart
9. ในแถบด้านล่างจะแสดง Error: Dart SDK is not configured ให้กด Fix ไปที่เมนู Flutter ในช่อง Flutter SDK path ให้เลือกโฟลเดอร์ที่ได้ทำการติดตั้ง flutter ในอุปกรณ์
10. ไปที่ไฟล์ pubspec.yaml กด pub upgrade และ pub get
11. create AVD ทำการสร้าง Device จำลองการทำงานของแอปพลิเคชัน โดยเลือกเมนู Device Manager และเลือก create device
12. เลือกตัวเลือกประเภท Tablet ชื่อ Nexus9 แล้วกด next
13. ดาวน์โหลด Release Name: Q, API Level: 29 แล้วกด next
14. เลือกเป็นแบบ Portrait แล้วกด finish เป็นอันเสร็จสิ้นการสร้าง emulator
> สำหรับผู้ที่ทำการสร้าง server ใหม่ให้นำ URL Link มาแก้ไขในไฟล์ confirmPic.dart และ result.dart ก่อนทำการ run โปรเจ็ค
15. Launch AVD เพื่อเปิด emulator และกด run เพื่อรันโปรเจ็ค

> สามารถเพิ่มรูปภาพสำหรับใช้ทดสอบได้โดยไปที่ รูปภาพ บน emulator
> แล้วทำการลากภาพที่่ต้องการใช้ทดสอบจากบนอุปกรณ์ ไปยัง emulator ได้เลย
