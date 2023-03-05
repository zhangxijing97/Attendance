# Attendance

Attendance is an iPadOS app designed for teaching assistants at ASU Digital Culture Summer Institute. The app allows teaching assistants to manage attendance for their classes, including taking attendance, adding and removing students, and generating reports.

## Features

- Add and remove students
- Take attendance and track absences
- Generate attendance reports
- Customize attendance settings

## Screenshots

<p float="left">
   <img src="https://github.com/zhangxijing97/Attendance/blob/main/Screenshots/IMG_0051.PNG" width=40% height=40%>  
   <img src="https://github.com/zhangxijing97/Attendance/blob/main/Screenshots/IMG_0052.PNG" width=40% height=40%>
</p>

<p float="left">
   <img src="https://github.com/zhangxijing97/Attendance/blob/main/Screenshots/IMG_0053.PNG" width=40% height=40%>
   <img src="https://github.com/zhangxijing97/Attendance/blob/main/Screenshots/IMG_0054.PNG" width=40% height=40%>
</p>

<p float="left">
   <img src="https://github.com/zhangxijing97/Attendance/blob/main/Screenshots/IMG_0055.PNG" width=40% height=40%>
   <img src="https://github.com/zhangxijing97/Attendance/blob/main/Screenshots/IMG_0056.PNG" width=40% height=40%>
</p>

## Usage

To use the Attendance app, simply launch it and select the track/day you want to take attendance for. You can add and remove students as needed, and then take attendance by tapping on each student's check-in and check-out buttons. You can also customize attendance settings to fit your needs.

## Frameworks

Attendance was built using the following frameworks:

- Swift
- Xcode
- SwiftUI

## Data Model
```
class AppData
tracks = [Track]
students = [Student]
attendances = [Attendance]

func loadTracks()
func loadStudents()
func loadAttendances()
func saveTracks()
func saveStudents()
func saveAttendances()
func addAttendanceAdd(student: Student, track: Track) // Add new Attendance instance
func removeAttendance(student: Student, track: Track) // Remove selected Attendance instance

struct Track
var id: UUID
var name: String
var studentIds: [UUID] // All students enroll in the Track
var attendanceIds: [UUID]

func addStudent(student: Student) // Add student.id to studentIds: [UUID]
func removeStudent(student: Student) // Remove student.id from studentIds: [UUID]
func getStudents(track: Track, data: AppData) -> [Student] // Return Student instance array of the Track
func attendance(student: Student, data: AppData) -> Attendance? // Return Attendance instance of the student for the Track
func getAttendances(data: AppData) -> [Attendance] // Return Attendance instance array of the Track

struct Student
var id = UUID()
var name: String
var tracks: [UUID]

func addTrack(track: Track)
func removeTrack(track: Track)

struct Attendance
var id = UUID()
var trackId: UUID
var studentId: UUID

var sectionACourse1CheckInTime: String?
func studentName(attendance: Attendance) -> String? // Return Student.name match studentId

```

## Installation

To install Mars Mission, simply clone the repository and open the project in Xcode:
```
git clone https://github.com/zhangxijing97/Attendance.git
cd Attendance
open Attendance1.3.xcodeproj
```

## Privacy Note

Please note that all student information used for demonstration purposes in this app is randomly generated and does not represent real student data.

## Future Updates

We are currently working on adding new features to the Attendance app, including the ability to sync attendance data with a server. Stay tuned for updates!

## Contributing

If you would like to contribute to the Attendance app, please fork the repository and submit a pull request.

## License

The Attendance app is released under the MIT License. See LICENSE for details.

## Credits

The Attendance app was created by Xijing Zhang. If you have any questions or feedback, please email us at zhangxijing97@gmail.com.
