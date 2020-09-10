# iCar

### iCar is a smart iOS application, connects to cloud to retrive the real-time data that is posted using Raspberry Pi. 
#### Multiple sensors are used to get temperature, light conditions, collision alerts, current driver info, driving speed, speed-limits, location, lock/unlock status, find directions to car's location and more.

**Note** - Link to the app is not provided. Since, it’s an IoT project, to see all the features in action the Raspberry should be up and running with all the sensors connected to it. Please use the following examples as demo.

- **Home screen** 
  - Beautiful landing page
  - Displays car loaction status 
  - Lock/Unlock status
  - Car's moment status using animation
    - Animates when moving
    - Stays still when no moment is detected

![](gif/home.gif "Homescreen")

- **Lock/Unlock car**
  - using **FaceId**
  - using registered **RF-tag**

![](gif/faceid_lock:unlock.gif "Lock/Unlock using FaceId")        ![](gif/card_lock:unlock.gif "Lock or Unlock using registered tags")

- **Car details**
  - Alerts the user, when car moves too close to the vehicles infront of it
  - Get outside and inside temperature details
  - Get current speed and speed-limit in the current location
  - Watch the distance let to the front of the car, when too close the app notifies the user by playing sound.

![](gif/moredetails.gif)

- **Speed Alerts**
  - Displays car's current speed and speed-limit of the road
  - When car speed exceeds speed-limit, the app warns the user by flashing screen and plays sound
  - Up to date speed-limits are gathered from API service

![](gif/speedalert.gif "Speed limit warning")

- **Profile**
  - Get your driving score based on your driving style
    - sudden draking and acceleration decreases the score
    - Linear acceleration and braking increases the score 
  - By this fuel consumption and car's health can be improved
  - Compete with other drivers as a challenge
  
![](gif/speed.gif)


- **Help**
  - About the app section is provided to get started
  - This section describes all the features of the app 
  
![](gif/help.gif)
