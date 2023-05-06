source /opt/kayobe/venvs/kayobe/bin/activate.fish
set -x base_path /opt/kayobe
set -x KOLLA_SOURCE_PATH {$base_path}/src/kolla-ansible
set -x KOLLA_VENV_PATH {$base_path}/venvs/kolla-ansible

set REPO_DIR (cd (dirname (status -f)); and pwd)
set -x KAYOBE_CONFIG_ROOT {$REPO_DIR}
set -x KAYOBE_CONFIG_PATH {$KAYOBE_CONFIG_ROOT}/kayobe
