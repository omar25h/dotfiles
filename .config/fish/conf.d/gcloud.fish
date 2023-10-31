if status --is-interactive
  # GCloud only loves python 3.8
  set -gx CLOUDSDK_PYTHON (brew --prefix)/opt/python@3.8/libexec/bin/python
  source (brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc
end

set -gx USE_GKE_GCLOUD_AUTH_PLUGIN True
set -gx GOOGLE_APPLICATION_CREDENTIALS $HOME/.config/gcloud/application_default_credentials.json
