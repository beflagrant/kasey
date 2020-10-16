// kasey - kasey.js

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
// require("channels");
require("bootstrap");

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// import "bootstrap";

//document.addEventListener("turbolinks:load", () => {
//  $('[data-toggle="tooltip"]').tooltip();
//});

require("trix");
require("@rails/actiontext");

// prevents attachments in trix editor
document.addEventListener("trix-file-accept", function(event) {
    console.log("preventing file accept");
    event.preventDefault();
});

require("./dropzone.js");

