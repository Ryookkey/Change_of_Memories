// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "bootstrap/dist/css/bootstrap.css";
import "../stylesheets/application.css";

Rails.start()
Turbolinks.start()
ActiveStorage.start()

document.addEventListener('DOMContentLoaded', function() {
  const cards = document.querySelectorAll('.detailCard');

  cards.forEach(function(card) {
    card.addEventListener('click', function() {
      card.classList.toggle('elevated');
    });
  });
});
