// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import { Turbo } from "@hotwired/turbo-rails";
import "controllers"
import "jquery"





Turbo.start();

  $(document).on("turbo:load", function() {
    const tagInputs = document.querySelectorAll('[data-role="tagsinput"]');
    tagInputs.forEach((input) => {
      new Tagify(input, {
        whitelist: [],
        autoComplete: {
          enabled: true,
          rightKey: true
        },
        dropdown: {
          maxItems: 20,
          classname: "tags-look",
          enabled: 0, // Always show suggestions dropdown
          closeOnSelect: false
        },
        callbacks: {
          "input": (e) => {
            fetchTags(e.detail.value, (suggestions) => {
              e.detail.tagify.settings.whitelist = suggestions;
              e.detail.tagify.dropdown.show(e.detail.value); // Show the suggestions dropdown
            });
          }
        }
      });
    });
  });
  function fetchTags(query, callback) {
    fetch(`/tags?q=${query}`)
      .then(response => response.json())
      .then(tags => callback(tags))
      .catch(error => console.error('Error fetching tags:', error));
  }