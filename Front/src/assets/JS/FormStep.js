export function nextformstep () {
    // let form_step = document.querySelector('#form_step')
    // form_step.classList.remove('noactive')
    // form_step.classList.add('active')

    let slider_form = document.querySelector('.slider_form')
    slider_form.scrollLeft += slider_form.offsetWidth  
    
} 
export function beforeformstep () {
    // let form_step = document.querySelector('#form_step')
    // form_step.classList.remove('active')
    // form_step.classList.add('noactive')
    let slider_form = document.querySelector('.slider_form')
    slider_form.scrollLeft -= slider_form.offsetWidth  
     
} 
export function countform (){
    let form_step = document.querySelectorAll('#form_step')
    form_step.forEach((item) => {
        console.log(item.length)
        console.log(item)
    }) 
}