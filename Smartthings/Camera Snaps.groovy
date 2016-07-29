/**
 *  Camera Snaps
 *  Version 1.0
 *  Copyright 2016 Thom Rosario
 *  Based on 
 *  "Foscam Mode Alarm"     Copyright 2014 skp19 and
 *  "Photo Burst When..."   Copyright 2013 SmartThings
 *
 *  Take snapshots each camera preset position whenever there's something going on.
 *
 *  TODO:  have scheduleHander write a list of that tells what position and snap and move to and then 
 *         have snapHandler read the list, and increment state variable showing which picture we took
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
    name: "Camera Snaps All Presets",
    namespace: "Thom Rosario",
    author: "Thom Rosario",
    category: "Safety & Security",
    description: "Snap photos of Foscam preset positions whenever there's activity.",
    iconUrl: "https://s3.amazonaws.com/smartapp-icons/Solution/camera.png",
    iconX2Url: "https://s3.amazonaws.com/smartapp-icons/Solution/camera@2x.png"
)

preferences {
	section("When there's motion here...") {
		input("motionSensors", "capability.motionSensor", required: true, title: "Where?", multiple: true)
	}
    section("... or this contact sensor opens...") {
      input("contactSensors", "capability.contactSensor", title: "Pick the sensor", required: false, multiple: true)
    }
    section("Snap images from this camera...") {
		input("camera", "capability.imageCapture", required: true, title: "Which camera?", multiple: true)
	}
	section("... and return to this position...") {
		input ("origPosition", "number", title: "Which preset position?", required: false, defaultValue: "1")
	}
	section("Wait how long between taking photos?") {
		input ("movePeriod", "number", title: "How many seconds (no less than 5)?", required: false, defaultValue: "10")
	}
	section("How many presets do you have?") {
		input ("numPresets", "number", title: "Usually 3", required: false, defaultValue: "3")
	}
}

def installed() {
	log.debug "Installed with settings: ${settings}"
	initialize()
}

def updated() {
	log.debug "Updated with settings: ${settings}"
	unsubscribe()
	initialize()
}

def initialize() {
	subscribe(motionSensors, "motion.active", scheduleHandler)
	subscribe(contactSensors, "contact.open", scheduleHandler)
	state.shutterDelay = 2 // give the camera time to snap the photo before moving it again
}

def scheduleHandler (evt) {
	log.debug "scheduleHandler called: ${evt.value}"
	// init these variables every time we see motion
	def schedTime = 0 // number of seconds in the future to snap & move
	state.presetNum = 0 // the preset number to move to; 0 means don't move

	// check the movePeriod user chose before using it; this is amount of time we give the camera to move positions
	if (movePeriod < 5) {
		movePeriod = 5
		log.debug "scheduleHandler:  movePeriod was < ${movePeriod}; setting to ${movePeriod}"
	}
	log.debug "scheduleHandler:  state.presetNum = ${state.presetNum}; movePeriod = ${movePeriod}"	
	
	// set the snap and move routine
	for (int i = 1; i < numPresets + 2; i++) {
		schedTime = i * movePeriod // schedule moves to occur increasingly further future times
		log.debug "scheduleHandler:  schedTime = ${schedTime} & increment = ${i}"
		runIn(schedTime, snapHandler, [overwrite: false])
	}
}

def snapHandler() {
	// take the picture
	camera?.take()
	
	// choose what to set the preset to
	switch (state.presetNum) {
	    case "0":
			log.debug "snapHandler:  snapping original position. state.presetNum = ${state.presetNum}"
			state.presetNum = state.presetNum + 1
	        break
		case "${numPresets + 1}":
			log.debug "snapHandler:  on last loop; restoring position; state.presetNum = ${state.presetNum}"
			state.presetNum = origPosition
			break
	    default:
			log.debug "snapHandler:  snapping a photo. state.presetNum = ${state.presetNum}"
			state.presetNum = state.presetNum + 1
	}		
	runIn(state.shutterDelay, moveHandler, [overwrite: false])
}

def moveHandler() {
	// moves the camera
	log.debug "moveHandler:  moving the camera.  state.presetNum = ${state.presetNum}"
	switch (state.presetNum) {
	    case "0":
	        // don't move; stay here.
	        break
	    case "1":
	        camera?.preset1()
	        break
	    case "2":
	        camera?.preset2()
	        break
	    case "3":
	        camera?.preset3()
	        break
	    case "4":
	        camera?.preset4()
	        break
	    case "5":
	        camera?.preset5()
	        break
	    case "6":
	        camera?.preset6()
	        break
	    default:
	        camera?.preset1()
	}	
}
