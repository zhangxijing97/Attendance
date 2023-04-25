# Attendance
![alt text](https://github.com/zhangxijing97/Attendance/blob/main/Screenshots%20Version%201.41/Attendance.png)

Attendance is a web-based iPadOS app designed for ASU Digital Culture Summer Institute. The application allows teaching assistants to manage attendance for their classes, including check-in, check-out, adding and removing students/ classes, and generating reports.

You can find the Vapor server app here: [attendance-app-server](https://github.com/zhangxijing97/attendance-app-server)

## Usage

To use the Attendance App:

1. Clone the [attendance-app-server](https://github.com/zhangxijing97/attendance-app-server) repository and follow the instructions in its README to set up and run the Vapor server app.
2. Clone this repository and open it in Xcode.
3. Update the `HTTPClient` configuration in the SwiftUI project to point to your local Vapor server.
4. Run the SwiftUI app on a simulator or a physical device.

## Technologies

### Server
- **Vapor:** A server-side Swift web framework for building web apps, APIs, and other server-side software.
- **RESTful APIs:** The Attendance App communicates with the Vapor server app using RESTful APIs to perform CRUD operations (Create, Read, Update, and Delete) on the server-side data.
- **PostgreSQL:** The Vapor server app uses PostgreSQL as the backend database to store and manage data, including tracks, students, and attendance records.
- **HTTPClient:** A custom class in the SwiftUI app responsible for handling HTTP requests and API calls to the Vapor server app.

### Client
- **SwiftUI:** A modern, declarative UI framework for building user interfaces across all Apple platforms.

## Features

- Fetching data from the Vapor server and decoding JSON responses into Swift models.
- Add and remove students/tracks
- Take attendance and track absences
- Display all attendance data with bar charts by SwiftUI

## Screenshots

<p align="center">
   <img src="https://github.com/zhangxijing97/Attendance/blob/main/Screenshots%20Version%201.41/IMG_0110.PNG" style="max-width: 100%; height: auto;">
   <img src="https://github.com/zhangxijing97/Attendance/blob/main/Screenshots%20Version%201.41/IMG_0111.PNG" style="max-width: 100%; height: auto;">
</p>

<p float="left">
   <img src="https://github.com/zhangxijing97/Attendance/blob/main/Screenshots%20Version%201.41/IMG_0110.PNG" width=40% height=40%>  
   <img src="https://github.com/zhangxijing97/Attendance/blob/main/Screenshots%20Version%201.41/IMG_0111.PNG" width=40% height=40%>
</p>

<p float="left">
   <img src="https://github.com/zhangxijing97/Attendance/blob/main/Screenshots%20Version%201.41/IMG_0112.PNG" width=40% height=40%>
   <img src="https://github.com/zhangxijing97/Attendance/blob/main/Screenshots%20Version%201.41/IMG_0113.PNG" width=40% height=40%>
</p>

<p float="left">
   <img src="https://github.com/zhangxijing97/Attendance/blob/main/Screenshots%20Version%201.41/IMG_0114.PNG" width=40% height=40%>
   <img src="https://github.com/zhangxijing97/Attendance/blob/main/Screenshots%20Version%201.41/IMG_0115.PNG" width=40% height=40%>
</p>

<p float="left">
   <img src="https://github.com/zhangxijing97/Attendance/blob/main/Screenshots%20Version%201.41/IMG_0116.PNG" width=40% height=40%>
   <img src="https://github.com/zhangxijing97/Attendance/blob/main/Screenshots%20Version%201.41/IMG_0117.PNG" width=40% height=40%>
</p>

<p float="left">
   <img src="https://github.com/zhangxijing97/Attendance/blob/main/Screenshots%20Version%201.41/IMG_0118.PNG" width=40% height=40%>
   <img src="https://github.com/zhangxijing97/Attendance/blob/main/Screenshots%20Version%201.41/IMG_0119.PNG" width=40% height=40%>
</p>

## Privacy Note

Please note that all student information just used for demonstration purposes in this app is randomly generated and does not represent real student data.

## License

The Attendance app is released under the MIT License. See LICENSE for details.

## Credits

The Attendance app was created by Xijing Zhang. If you have any questions or feedback, please email us at zhangxijing97@gmail.com.
