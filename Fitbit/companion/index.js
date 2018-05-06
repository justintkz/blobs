import {me} from "companion";
import { peerSocket } from "messaging";

// peerSocket.onmessage = function(evt) {
//   console.log("companion: " + JSON.stringify(evt.data));
// }

// The Device application caused the Companion to start
var myHeaders = new Headers();
myHeaders.append('Content-Type', 'application/json');

//Server where the API is running (must be HTTPS)
const host = "https://36fe870d.ngrok.io/update";

//When the watch sends a message
peerSocket.onmessage = evt => {
  console.log("Data recieved: " + evt.data); //Log it
  var url = host; // add a path to the URL
  fetch(url, {
      method : "POST",
      headers : myHeaders,
      body: JSON.stringify(evt.data)}) // Build the request
    .then(function(response){
      return response.json();}) //Extract JSON from the response
    .then(function(data) {             
      console.log("Got response from server:", JSON.stringify(data)); // Log ig
     }) // Send it to the watch as a JSON string
    .catch(function(error) {
      console.log(error);
  }); // Log any errors with Fetch
}
