/**
 *  Laundry Reminder
 *  Version 1.0
 *  Copyright 2016 Thom Rosario
 *
 *  This app will watch the vibration sensor for activity, and send a reminder at a chosen time of 
 *  the day to remind us to check the laundry so we don't leave anything in it overnight.  I've set my 
 *  Monoprice Shock Sensor (http://www.monoprice.com/product?p_id=11988) up as a "Z-Wave Door/Window Sensor", 
 *  as that's the only consistent way I could get SmartThings to acknowledge the vibrations.  "Open" equates to 
 *  vibration, and "Closed" is interpreted as no vibration.
 *
 *  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except
 *  in compliance with the License. You may obtain a copy of the License at:
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software distributed under the License is distributed
 *  on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License
 *  for the specific language governing permissions and limitations under the License.
 */

definition(
    name: "Evening Laundry Reminder",
    namespace: "Thom Rosario",
    author: "Thom Rosario",
    category: "Safety & Security",
    description: "Give yourself a reminder to check the washer before bed.",
    iconUrl: "https://s3.amazonaws.com/smartapp-icons/Solution/camera.png",
    iconX2Url: "https://s3.amazonaws.com/smartapp-icons/Solution/camera@2x.png"
)

preferences {
    section("Which vibration sensor?") {
      input("washerContact", "capability.contactSensor", title: "Pick the sensor", required: true, multiple: false)
    }
/*	section("How long is your typical wash cycle?") {
		input ("washTime", "text", title:"How many minutes does your laundry take?", required: true, defaultValue: "15")
	} */
	section("What time do you want to be notified?") {
		input("notifyTime", "time", title: "Enter a time to be notified.", required: true)
	}
	section("What number do you want to be notified at?") {
		input("notifyNumber", "text", title: "Enter a mobile number.", required: false)
	}
}

def initialized() {
    runOnce(notifyTime, notificationHandler)
}

def installed() {
	log.debug "Installed with settings: ${settings}"
	subscribeToEvents()
}

def updated() {
	log.debug "Updated with settings: ${settings}"
	unsubscribe()
	subscribeToEvents()
}

def subscribeToEvents() {
	subscribe(washerContact, "contact", washerHandler)
}

def washerHandler(evt) {
    if (evt.value == "open") {
      // contact was opened, must be doing laundry.  Need to time it.
      log.debug "Contact is ${evt.value}"
	  /*
	  1.  Get the current time
	  2.  Save the current time to the settings
	  */
  }
  else {
      // contact was closed, make note of the time and tell the app to run later and check how long we ran
      log.debug "Contact is ${evt.value}"
	  /*
	  1.  Save the current time and date to settings
	  2.  Check how long the cycle was
	  3.  Set a flag for whether or not we ran a cycle today.
	  */
  }
}

def notificationHandler(evt) {
	// this is where I'll decide how to handle what happens at the user's specified time
	log.debug "We're inside the notification handler."
	/*
	1.  Check to see if we ran a cycle today.
	2.  Notify if we did.
	3.  Clear the flags for cycle times
	*/
}