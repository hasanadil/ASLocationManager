ASLocationManager
=================

An ObjC wrapper around Cocoa's Core Location framework that uses the GPS chip to determine the user's location. ASLocationManager is built to be very easy to use, 1 line of code. The goal of this library is to abstract away the location determination of the user across an enter app. 

An app which needs the user's location across a variety of UIView's or other components would generally need to create multiple instances of CLLocationManager (from Cocoa), then retain those instances and manage them. This is in addition to offloading operations to a background thread and maintain a queue accordingly.

With ASLocationManager, location services are centralized. It does all its work in a background thread so your app expereince isn't affected. 

How does it work?
=================
Simple, you fetch a shared singleton, and pass a block which is called whenever the user's location is retrieved.

Usage:
[[ASLocationManager sharedInstance] userLocationWithCompletion:^(CLLocation *location) {
	...
}];

The block is of type:
typedef void(^ASLocationCompletion)(CLLocation* location);

Thread Safety
=============
ASLocationManager is thread safe and you can request to fetch the user's location from any queue in your app.

Installation
============

1) Add the CoreLocation.framework to your project if you haven't already.

2) Copy the ASLocationManager.h & ASLocationManager.m files from the /lib folder and include them in your project.

3) Fetch the user's location according to the usage shown above, or also see the sample project included.

Important
=========
ASLocationManager is under active development. Support for continous streaming of a user's location is coming soon! As well as many other goodies. 

Feel free to contact me at hasan@assemblelabs.com if you have any questions of post them here.

Credits
=======
ASLocationManager was originally created by Hasan Adil @assemblelabs. Big thanks to some good friends for feedback and sugestions.

ASLocationManager is available under the MIT license.




