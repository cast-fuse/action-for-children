const timeOptions =
  [ 'morning',
    'afternoon',
    'evening'
  ]

const dayOptions =
  [ 'mon',
    'tues',
    'wed',
    'thurs',
    'fri',
    'sat',
    'sun',
    'any'
  ]

const setEventListener = ({ button, radio }) => {
  if (button) {
    button.addEventListener('click', () => {
      radio ? radio.click() : null
    })
  }
}

const addEventListeners = (timePeriod) => {
  let radioButtonPair = {}
  radioButtonPair.button = document.querySelector(`[${timePeriod}]`)
  radioButtonPair.radio = document.querySelector(`[${timePeriod}-radio]`)
  setEventListener(radioButtonPair)
}

const addListeners = () => {
  timeOptions.map(addEventListeners)
  dayOptions.map(addEventListeners)
}

export default addListeners
