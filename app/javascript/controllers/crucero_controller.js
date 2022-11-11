import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // $('#product_primary_img').bind('change', function() {
    //   size_in_megabytes = this.files[0].size/1024/1024
    //   if (size_in_megabytes > 5) {
    //     alert('El tamaño maximo del archivo debe ser menor a 5MB. Seleccionar otro archivo.')
    //   }
    // })
  }

  loadDestinations(e) {
    debugger
    const regionId = e.target.value
    const destinationsEl = document.querySelector("#cruise_destination_id")
    destinationsEl.insertAdjacentHTML('afterbegin', '<option>Cargando subcategorias ...</option>')

    const request = new Request(`/cruises/new.json?region_id=${regionId}`)
    fetch(request)
      .then(response => response.json())
      .then(data => {
        debugger
        const destinations = data.destinations
        destinationsEl.innerHTML = ""
        destinationsEl.innerHTML += '<option>--- No seleccionado ---</option>'
        destinations.forEach(dest => {
          destinationsEl.innerHTML += `<option value=\"${dest.id}\">${dest.name}</option>`
        })
      })
  }

  incrementValue(e) {
    debugger
    const fieldName = e.target.dataset.field
    const parent = e.target.closest('.input-group')
    const input = `input[name='${fieldName}']`
    const currentVal = parseInt(parent.querySelector(input).value, 10)
    if (!isNaN(currentVal)) {
      parent.querySelector(input).value = currentVal + 1
    } else {
      parent.querySelector(input).value = 1
    }
  }

  decrementValue(e) {
    debugger
    const fieldName = e.target.dataset.field
    const parent = e.target.closest('.input-group')
    const input = `input[name='${fieldName}']`
    const currentVal = parseInt(parent.querySelector(input).value, 10);
    if (!isNaN(currentVal) && currentVal > 1 ) {
      parent.querySelector(input).value = currentVal - 1
    } else {
      parent.querySelector(input).value =1
    }
  }
}
