import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  switch(id, target) {
    this.element.querySelectorAll('.w-1\\/2')
        .forEach(el => el.classList.replace('btn-active', 'btn-primary'));
    target.classList.replace('btn-primary', 'btn-active');
    document.querySelectorAll('form').forEach(el => el.classList.contains('hidden') ? null : el.classList.add('hidden'));
    document.getElementById(id).classList.remove('hidden');
  }

  connect() {
    this.switch('login', this.element.querySelector('.w-1\\/2'));
  }

  menu(event) {
    this.switch(event.params.id, event.target);
  }

  login(event) {
    event.preventDefault();
    let frm = new FormData(event.target);
    let el = this.element.querySelector('#alert');
    fetch(event.params.url, {
      method: 'POST',
      body: frm,
      credentials: "same-origin",
      headers: new Headers({
        'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').attributes["content"].value
      })
    }).then(resp => resp.json())
        .then(js => {
          if (js.error !== undefined) {
            el.innerText = js.error;
            el.classList.remove('hidden');
          } else {
            location.href = js.url;
          }
      });
  }

  signup(event) {
    let frm = new FormData(event.target);
    let el = this.element.querySelector('#alert');
    event.preventDefault();
    if (frm.get('pass').length < 1) {
      el.innerText = 'Password too small';
      el.classList.remove('hidden');
    } else if (frm.get('pass2').length < 1) {
      el.innerText = 'Passwords not same';
      el.classList.remove('hidden');
    } else if (frm.get('pass') !== frm.get('pass2')) {
      el.innerText = 'Passwords not same';
      el.classList.remove('hidden');
    } else {
      el.classList.add('hidden');
      fetch(event.params.url, {
        method: 'POST',
        body: frm,
        credentials: "same-origin",
        headers: new Headers({
          'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').attributes["content"].value
        })
      }).then(resp => resp.json())
          .then(js => {
            if (js.error !== undefined) {
              el.innerText = js.error;
              el.classList.remove('hidden');
            } else {
              location.href = js.url;
            }
          });
    }
  }
}
