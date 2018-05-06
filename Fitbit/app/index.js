import clock from "clock";
import document from "document";
import { preferences } from "user-settings";
import { HeartRateSensor } from "heart-rate";
import { today } from "user-activity";
import { vibration } from "haptics";
import { display } from "display";
import * as util from "../common/utils";
import { peerSocket } from "messaging";

///////////
// Clock //
///////////

// Update the clock every minute
clock.granularity = "minutes";

// Get a handle on the <text> element
const myLabel = document.getElementById("myLabel");

// Update the <text> element every tick with the current time
clock.ontick = (evt) => {
  let today = evt.date;
  trackReminders(today);
  
  let hours = today.getHours();
  if (preferences.clockDisplay === "12h") {
    // 12h format
    hours = hours % 12 || 12;
  } else {
    // 24h format
    hours = util.zeroPad(hours);
  }
  let mins = util.zeroPad(today.getMinutes());
  myLabel.text = `${hours}:${mins}`;
}

/////////////
// Sprites //
/////////////
let imageIdx = 0;
let active_images = [
  "images/jump-5.png",
  "images/jump-6.png",
  "images/jump-7.png",
  "images/jump-8.png",
  "images/jump-7.png",
  "images/jump-6.png",
  "images/jump-5.png",
];

let sick_images = [
  "images/sad-1.png",
  "images/sad-2.png",
  "images/sad-2.png",
  "images/sad-3.png",
  "images/sad-3.png",
  "images/sad-3.png",
  "images/sad-3.png",
  "images/sad-4.png",
];
let status_images = {
  'active': active_images, 
  'sick': sick_images,
};
let status = 'active';
let img = document.getElementById("fluffy");
img.onclick = showBloodSugarReminder;

function changeImage() {
  imageIdx++;
  let images = status_images[status];
  img.href = images[imageIdx%images.length];
}

// interval for changing frame
setInterval(function() {
  changeImage()
} , 150)

//////////////////////
// Heart Rate/Steps //
//////////////////////


let hrm = new HeartRateSensor();
const hrValue = document.getElementById("heart_rate_value");
// const stepValue = document.getElementbyId("heart_rate_value");

hrm.onreading = function() {
  console.log('hr reading...' + hrm.heartRate);
  hrValue.text = hrm.heartRate + " bpm";
  // stepValue.text = (today.local.steps || 0).toString();
}

hrm.start();

///////////////
// Reminders //
///////////////
let bsLevel = 120;
let bs = document.getElementById("bsReminder");
bs.onclick = chooseBloodSugar;

let pos0 = document.getElementById("pos0");
let pos1 = document.getElementById("pos1");
let pos2 = document.getElementById("pos2");
let bloodsugarPage = document.getElementById("bloodsugar")

let btnBR = document.getElementById("btn-br");
btnBR.onclick = saveBloodSugar;

function trackReminders(dt) {
  let hours = dt.getHours();
  let minutes = dt.getMinutes();
  
  if (hours == 22 && minutes == 30) {
    showBloodSugarReminder();
  }
}

function showBloodSugarReminder() {
  myLabel.style.display = "none";
  bs.style.display = "inline";
  status = 'sick';
}

function chooseBloodSugar(evt) {
  bs.style.display = "none";
  myLabel.style.display = "inline";
  bloodsugarPage.style.display = "inline";
  vibration.start("nudge-max");
  display.on = true;
  status = 'active';
}

let bsLevels = [];

function saveBloodSugar(evt) {
  bsLevel = 100*pos0.value + 10*pos1.value + pos2.value;
  bsLevels.push(bsLevel);
  sendData();
  console.log("sugar level: " + bsLevel.toString());
  bloodsugarPage.style.display = "none";
  pos0.value = 0;
  pos1.value = 0;
  pos2.value = 0;
}

///////////////
// Messaging //
///////////////

peerSocket.onopen = function() {
  console.log("it's open!");
  console.log("peerSocket state: " + peerSocket.readyState);
  sendData();
}

function sendData() {
  if (peerSocket.readyState === peerSocket.OPEN) {
    console.log('sending data');
    
    while (bsLevels.length !== 0) {
      console.log(bsLevels);
      peerSocket.send({"blood_sugar": bsLevels.pop()});
    }
  }
}
