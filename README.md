# Attendance App
![Attendance App Banner](https://github.com/zhangxijing97/Attendance/blob/main/Screenshots%20Version%201.41/Attendance.png)

Attendance App is a web-based iPadOS application designed for the ASU Digital Culture Summer Institute. The app enables teaching assistants to efficiently manage attendance for their classes, including check-in, check-out, adding and removing students/classes, and generating reports.

You can find the Vapor server app here: [attendance-app-server](https://github.com/zhangxijing97/attendance-app-server)

## Usage

To use the Attendance App, follow these steps:

1. Clone the [attendance-app-server](https://github.com/zhangxijing97/attendance-app-server) repository and follow the instructions in its README to set up and run the Vapor server app.
2. Clone this repository and open it in Xcode.
3. Update the `HTTPClient` configuration in the SwiftUI project to point to your local Vapor server.
4. Run the SwiftUI app on a simulator or a physical device.

## Technologies

### Server
- **Vapor:** A server-side Swift web framework for building web apps, APIs, and other server-side software.
- **RESTful APIs:** The Attendance App communicates with the Vapor server app using RESTful APIs to perform CRUD (Create, Read, Update, and Delete) operations on server-side data.
- **PostgreSQL:** The Vapor server app uses PostgreSQL as the backend database for storing and managing data, including tracks, students, and attendance records.
- **HTTPClient:** A custom class in the SwiftUI app responsible for handling HTTP requests and API calls to the Vapor server app.

### Client
- **SwiftUI:** A modern, declarative UI framework for building user interfaces across all Apple platforms.

## Features

- Fetch data from the Vapor server and decode JSON responses into Swift models.
- Add and remove students/tracks.
- Record attendance and track absences.
- Display attendance data with bar charts using SwiftUI.

## Screenshots

#### DashBoardView and ClockView
![DashBoardView and ClockView](https://github.com/zhangxijing97/Attendance/blob/main/Screenshots%20Version%201.41/01.png)

#### TrackDetailView
![TrackDetailView](https://github.com/zhangxijing97/Attendance/blob/main/Screenshots%20Version%201.41/02.png)

#### ChartView
![ChartView](https://github.com/zhangxijing97/Attendance/blob/main/Screenshots%20Version%201.41/03.png)

#### StudentView and StudentDetailView
![StudentView and StudentDetailView](https://github.com/zhangxijing97/Attendance/blob/main/Screenshots%20Version%201.41/04.png)

#### AddStudentView and AddTrackView
![AddStudentView and AddTrackView](https://github.com/zhangxijing97/Attendance/blob/main/Screenshots%20Version%201.41/05.png)

## Privacy Note

Please note that all student information used for demonstration purposes in this app is randomly generated and does not represent real student data.

## License

The Attendance App is released under the MIT License. See [LICENSE](LICENSE) for details.

## Credits

The Attendance App was created by Xijing Zhang. If you have any questions or feedback, please email us at zhangxijing97@gmail.com.
