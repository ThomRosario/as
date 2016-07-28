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
		input ("presetPause", "number", title: "How many seconds?", required: false, defaultValue: "10")
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
	subscribe(motionSensors, "motion.active", motionHandler)
	subscribe(contactSensors, "contact.open", motionHandler)
}

def motionHandler (evt) {
	log.debug "motionHandler called: $evt"
	def snapDelay = 2 // give the camera time to snap the photo
	//def command = ""
	//state.presetNum = 1
	//log.debug "stored state variable presetNum = ${state.presetNum}"
	//camera?.take() // snap a quick photo wherever we are
	// log.debug "motionHandler:  snapped original position photo"
	// check the presetPause before using it; this is the delay we wait between snapping photos
	if (presetPause < 2) {
		log.debug "motionHandler:  presetPause was < 2; setting to ${presetPause}"
		presetPause = 2
	}
	
	// set the snap and move routine
	def moveDelay = 1
	state.presetNum = 1 // start at the start
	log.debug "motionHandler:  initialized moveDelay to ${moveDelay}"
	for (int i = 1; i < numPresets + 1; i++) {
		//state.presetNum = i // save this to tell the camera which preset to move to
		moveDelay = i * presetPause // give the camera time to move
		log.debug "motionHandler:  moveDelay = ${moveDelay} & state.presetNum = ${state.presetNum}"
		
		// snap & move
		runIn(moveDelay, snapHandler, [overwrite: false])
		runIn(moveDelay + snapDelay, presetHandler, [overwrite: false])
	}
	
	// now move the camera back to where it was
	/*
	state.presetNum = origPosition
	moveDelay = (numPresets + 1) * presetPause
	log.debug "motionHandler:  moving back to preset ${state.presetNum} in ${moveDelay} seconds."
	runIn(moveDelay, presetHandler, [overwrite: false])
	*/
}

def snapHandler() {
	// takes the picture
	log.debug "snapHandler:  snapping a photo."
	camera?.take()
	state.presetNum = state.presetNum + 1
}

def presetHandler() {
	// moves the camera
	log.debug "presetHandler:  moving the camera.  state.presetNum = ${state.presetNum}"
	switch (state.presetNum) {
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
	        camera?.preset6()
	        break
	    case "6":
	        camera?.preset6()
	        break
	    default:
	        camera?.preset1()
	}	
}

def pictureHandler() {
	// snaps the pictures
	log.debug "pictureHandler:retrieving state variable presetNum = ${state.presetNum}"
	camera?.take()
	state.presetNum = state.presetNum + 1
	log.debug "pictureHandler:  tried to increment state.presetNum = ${state.presetNum}"
	switch (state.presetNum) {
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
	        camera?.preset6()
	        break
	    case "6":
	        camera?.preset6()
	        break
	    default:
	        camera?.preset1()
	}	
}