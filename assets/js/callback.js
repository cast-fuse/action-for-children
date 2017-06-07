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

const getRadioButtonPair = (timePeriod) => {
  let radioButtonPair = {}
  radioButtonPair.button = document.querySelector(`[${timePeriod}]`)
  radioButtonPair.radio = document.querySelector(`[${timePeriod}-radio]`)
  return radioButtonPair
}

const timePairs = timeOptions.map(getRadioButtonPair)
const dayPairs = dayOptions.map(getRadioButtonPair)

const setTimeHandlers = ({ button, radio }) => {
  if (button) {
    button.addEventListener('click', () => {
      radio ? radio.click() : null
    })
  }
}

const addListeners = () => {
  timePairs.map(setTimeHandlers)
  dayPairs.map(setTimeHandlers)
}

export default addListeners
