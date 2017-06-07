const timeOptions =
  [ 'morning',
    'afternoon',
    'evening'
  ]

const getTimeButtons = (time) => {
  let timeOptions = {}
  timeOptions.button = document.querySelector(`[${time}]`)
  timeOptions.radio = document.querySelector(`[${time}-radio]`)
  return timeOptions
}

const timeButtons = timeOptions.map(getTimeButtons)

const setHandler = ({ button, radio }) => {
  if (button) {
    button.addEventListener('click', () => {
      radio ? radio.click() : null
    })
  }
}

const addListeners = () => timeButtons.map(setHandler)

export default addListeners
