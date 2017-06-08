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

const getButton = (timePeriod) => document.querySelector(`[${timePeriod}]`)
const getRadioInput = (timePeriod) => document.querySelector(`[${timePeriod}-radio]`)
const removeClass = el => className => el.classList.remove(className)
const addClass = el => className => el.classList.add(className)

const getButtonRadioPair = (timePeriod) => {
  let radioButtonPair = {}
  radioButtonPair.button = getButton(timePeriod)
  radioButtonPair.radio = getRadioInput(timePeriod)
  return radioButtonPair
}

const setEventListener = (buttons) => ({ button, radio }) => {
  if (button) {
    button.addEventListener('click', () => {
      updateClasses(buttons, button)
      radio ? radio.click() : null
    })
  }
}

const updateClasses = (buttons, button) => {
  const classes = ['white', 'bg-dark-red']
  buttons.map(button => classes.map(removeClass(button)))
  classes.map(addClass(button))
}

const handleTimeOptions = () => {
  const timeButtons = timeOptions.map(getButton)
  const dayButtons = dayOptions.map(getButton)

  timeOptions.map(getButtonRadioPair).map(setEventListener(timeButtons))
  dayOptions.map(getButtonRadioPair).map(setEventListener(dayButtons))
}

export default handleTimeOptions
