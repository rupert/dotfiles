#!/bin/sh

set -e

package() {
  [ -e "$HOME/.local/venvs/$2" ] || pipsi install --python "$(which python"$1")" "$2"
}

package 3 csvkit
package 3 coursera-dl
package 3 edx-dl
package 3 flake8
package 3 httpie
package 3 ipython
package 3 pygments
package 2 stapler
package 3 virtualenvwrapper
package 3 yapf
