// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import { Turbo } from "@hotwired/turbo-rails";
import "controllers"
import "jquery" 





Turbo.start();

document.addEventListener('turbo:load', () => {
  const tagInputs = document.querySelectorAll('[data-role="tagsinput"]');
  tagInputs.forEach((input) => {
      const tagify = new Tagify(input, {
        whitelist: [],
        autoComplete: {
          enabled: true,
          rightKey: true
        },
        dropdown: {
          maxItems: 20,
          classname: "tags-look",
          enabled: 0,
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

      input.closest('form').addEventListener('submit', () => {
        input.value = tagify.value.map(tag => tag.value).join(',');
      });


    });
  });
  function fetchTags(query, callback) {
    // console.log(`Fetching tags for query: ${query}`);
    fetch(`/tags?q=${query}`)
      .then(response => {
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        return response.json();
      })
      .then(tags => {
        // console.log('Fetched tags:', tags);
        callback(tags);
      })
      .catch(error => {
        // console.error('Error fetching tags:', error);
        alert('Error fetching tags. Please try again later.'); // Notify the user
      });
  }