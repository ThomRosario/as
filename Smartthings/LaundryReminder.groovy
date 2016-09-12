/*
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
    name: "Laundry Reminder",
    namespace: "burrow",
	//parent: "burrow:Smart Burrow",
    author: "Thom Rosario",
    category: "Safety & Security",
    description: "Give yourself a reminder to check the washer before bed.",
    iconUrl: "http://cdn.device-icons.smartthings.com/Appliances/appliances8-icn.png",
    iconX2Url: "http://cdn.device-icons.smartthings.com/Appliances/appliances8-icn@2x.png"
)

preferences {
    section ("Which vibration sensor?") {
      input ("washerContact", "capability.contactSensor", title: "Pick the sensor", required: true, multiple: false)
	  input ("normalWashLength", "number", title: "How many minutes does a typcical laundry wash cycle take?", required: true, defaultValue: "15")
    }
    section ("Notification Settings") {
		input ("phone", "phone", title: "Send with text message (optional)", description: "Phone Number", required: false)
        input "notifyTime", "time", title: "Enter a time to be notified."
		input ("recipients", "contact", title: "Who should I notify?", required: false)
        /*input ("recipients", "contact", title: "Who should I notify?", required: false) {
            input ("phone", "phone", title: "Send with text message (optional)", description: "Phone Number", required: false)
        }*/
    }
}

def installed () {
	log.debug "Installed with settings: ${settings}"
	initialize ()
}

def updated () {
	log.debug "Updated with settings: ${settings}"
	unsubscribe ()
	initialize ()
}

def initialize () {
	subscribe (washerContact, "contact", washerHandler)
	state.cycleSeconds = normalWashLength * 60
	//log.debug "init:  cycleSeconds = $state.cycleSeconds"
}

def washerHandler (evt) {
	//log.debug "washerHandler: $evt.value"
    if (evt.value == "open") {
	  state.startDate = now ()
	  log.debug "washerHandler:  $notifyTime: $washerContact.label opened at $state.startDate"
	  //runOnce (notifyTime, notifyHandler ("Don't forget to check the washer. $notifyTime: $washerContact.label opened at $state.startDate"))
	  //runIn (30, notifyHandler ("Test -- washer"))
  }
  else {
	  state.stopDate = now ()
	  def washLength = (state.stopDate - state.startDate) / 1000
      log.debug "washerHandler:  washLength = $washLength seconds. state.cycleSeconds = $state.cycleSeconds"
	  if (washLength >= state.cycleSeconds) {
		  log.debug "washerHandler: washLength > state.cycleSeconds"
		  runOnce (notifyTime, notifyHandler ("Don't forget to check the washer."))
	  } 
   }
}

def notifyHandler (msg) {
	log.debug "notifyHandler:  activated"
	if (location.contactBookEnabled && recipients) {
	    sendNotificationToContacts (msg, recipients)
	} 
    else if (phone) { 
	    sendSms (phone, msg)
	}
}