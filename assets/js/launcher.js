const launcherButton = () => document.querySelector('[launch-intercom]')

const bootIntercom = () => window.Intercom('boot', {
  app_id: 'jbn53yxb',
  email: 'andrew@andrew.com'
})

const showIntercom = () => window.Intercom('show')

const addLauncherListener = () => {
  const btn = launcherButton()
  if (btn) {
    btn.addEventListener('click', showIntercom)
  }
}

export const initAskQuestionBtn = () => {
  bootIntercom()
  addLauncherListener()
}
