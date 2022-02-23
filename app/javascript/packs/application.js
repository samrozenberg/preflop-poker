// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// import { joinGame } from "../game_features/join_game"
// joinGame()

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import "controllers"
import "bootstrap"


var result = document.getElementById("result");
var amount = document.getElementById("amount");
function change() {
  console.log("Hello");
  result.innerText = amount.value;
}
amount.addEventListener('change', change);


// const errorMessage = document.querySelector('.errors')
// console.log(errorMessage);
// errorMessage.innerHTML = "Incorrect Email/Password. \<br>Please review the errors below:"


// const modal = document.querySelector('.modal')
// $(document).ready(function () {
//   $('.modal').modal('hide');
// })


// const picture = document.getElementById("upfile1");
// console.log("Helloooooo");
// console.log(picture);
// const fileinput = document.getElementById("user-photo");
// console.log(fileinput);


// function fileupload() {
//   console.log("Hello");
//   fileinput.trigger('click');
// }

// picture.addEventListener('click', fileupload);
