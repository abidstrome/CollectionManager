document.addEventListener('turbo:load', () => {
    document.querySelectorAll('a[data-confirm], button[data-confirm]').forEach(element => {
      element.addEventListener('click', function (e) {
        if (!confirm(this.getAttribute('data-confirm'))) {
          e.preventDefault();
        }
      });
    });
  });
  