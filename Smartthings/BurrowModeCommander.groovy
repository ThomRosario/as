/*
 *  Smart Burrow
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

 definition (
    name: "Smart Burrow",
    namespace: "burrow",
    author: "Thom Rosario",
    category: "Convenience",
    description: "Finer-grained presence-sensor & control than modes allow in support of a multi-generational family.",
	singleInstance: true,
    iconUrl: "http://cdn.device-icons.smartthings.com/Home/home2-icn.png",
    iconX2Url: "http://cdn.device-icons.smartthings.com/Home/home2-icn@2x.png"
)

preferences {
	page (name: "mainPage", title: "Child Apps", install: true, uninstall: true) {
		section {
	    	app (name: "camApps", appName: "Non-Creepy Security Camera", namespace: "burrow", title: "New Non-Creepy Camera", multiple: true)
	    	app (name: "lightPresenceApps", appName: "Lights While Present", namespace: "burrow", title: "Lights While Present", multiple: true)
	    	app (name: "cameraIRApps", appName: "Camera IR Modes", namespace: "burrow", title: "Camera IR Modes", multiple: true)
			//app (name: "cameraSnapsApps", appName: "Camera Snaps All Presets", namespace: "burrow", title: "Camera Snaps", multiple: true)
		}
        section ("When this happens...") {
            input ("stMode", "mode", multiple: true, title: "This mode activates")
            input ("presence", "capability.presenceSensor", title: "These people are present", required: false, multiple: true)
        }
        section ("Notification Settings") {
            input ("recipients", "contact", title: "Who should I notify?", required: false) {
                input ("phone", "phone", title: "Send with text message (optional)", description: "Phone Number", required: false)
            }
	   }
	}
}

def installed () {
	log.debug "Installed with settings: ${settings}"
	init ()
}

def updated () {
	log.debug "Updated with settings: ${settings}"
	unsubscribe ()
	init ()
}

def init () {
    subscribe (location, "mode", modeHandler)
	subscribe (presence, "presence", presenceHandler)
	state.nobodyHome = presence.find {it.currentPresence == "present"} == null
}

def modeHandler (evt) {
}

def presenceHandler (evt) {
}

def notificationHandler (msg) {
	if (location.contactBookEnabled && recipients) {
	    sendNotificationToContacts (msg, recipients)
	} 
    else if (phone) { 
	    sendSms (phone, msg)
	}
}
