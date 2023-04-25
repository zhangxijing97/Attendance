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
### DashBoardView and ClockView
![alt text](https://github.com/zhangxijing97/Attendance/blob/main/Screenshots%20Version%201.41/01.png)
### TrackDetailView
![alt text](https://github.com/zhangxijing97/Attendance/blob/main/Screenshots%20Version%201.41/02.png)
### ChartView
![alt text](https://github.com/zhangxijing97/Attendance/blob/main/Screenshots%20Version%201.41/03.png)
### StudentView and StudentDetailView
![alt text](https://github.com/zhangxijing97/Attendance/blob/main/Screenshots%20Version%201.41/04.png)
### AddStudentView and AddTrackView
![alt text](https://github.com/zhangxijing97/Attendance/blob/main/Screenshots%20Version%201.41/05.png)

## Privacy Note

Please note that all student information just used for demonstration purposes in this app is randomly generated and does not represent real student data.

## License

The Attendance app is released under the MIT License. See LICENSE for details.

## Credits

The Attendance app was created by Xijing Zhang. If you have any questions or feedback, please email us at zhangxijing97@gmail.com.
