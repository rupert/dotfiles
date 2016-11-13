#!/bin/sh

set -e

package() {
  [ -e "$HOME/.local/venvs/$1" ] && return 0
  pipsi install $1
}

package coursera-dl
package httpie
package pygments
package stapler
package virtualenvwrapper
