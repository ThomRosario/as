/**
 *  Non-Creepy Security Camera
 *  Version 1.0
 *  Copyright 2016 Thom Rosario
 *
 *  Create a mutli-generational schedule commander based on presence awareness between the two zones
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
    name: "Burrow Mode Commander",
    namespace: "Thom Rosario",
    author: "Thom Rosario",
    category: "Convenience",
    description: "Finer-grained presence-sensor control than modes allow in support of a multi-generational family.",
    iconUrl: "https://s3.amazonaws.com/smartapp-icons/Solution/camera.png",
    iconX2Url: "https://s3.amazonaws.com/smartapp-icons/Solution/camera@2x.png"
)

preferences {
	section("When this happens...") {
		input ("stMode", "mode", multiple: true, title:"This mode activates")
        input "presence", "capability.presenceSensor", title: "These people are present", required: false, multiple: true
	}
    section("Do these things...") {
		input ("newPosition", "number", title:"Where should I move?", required: true, defaultValue: "3")
		input ("origPosition", "number", title: "Where should I return to when I'm done?", required: true, defaultValue: "1")
		input("recipients", "contact", title: "Who should I notify?") {
            input "phone", "phone", title: "Send with text message (optional)",
                description: "Phone Number", required: false
			}
	}
    section("To these cameras"){
		input ("camera", "capability.imageCapture", multiple: true, title:"Which camera?")
    }
}

def installed() {
	log.debug "Installed with settings: ${settings}"
	init()
}

def updated() {
	log.debug "Updated with settings: ${settings}"
	unsubscribe()
	init()
}

def init() {
    subscribe(location, "mode", moveHandler)
	subscribe(presence, "presence", moveHandler)
}

def notificationHandler(msg) {
	// handle notifications
	if (location.contactBookEnabled && recipients) {
	    sendNotificationToContacts(msg, recipients)
	} 
    else if (phone) { 
    	// check that the user did select a phone number
	    sendSms(phone, msg)
	}
}
