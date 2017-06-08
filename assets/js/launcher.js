const { intercomSettings } = window

const bootIntercom = (intercomSettings) => window.Intercom
  ? window.Intercom('boot', {
    app_id: 'mboc2bs2',
    user_id: intercomSettings.user_id
  })
  : null

const showIntercom = () => window.Intercom
  ? window.Intercom('show')
  : null

export const handleIntercomLaunch = () => {
  if (intercomSettings) {
    bootIntercom(intercomSettings)
    if (intercomSettings.autoShow) {
      showIntercom()
    }
  }
}
