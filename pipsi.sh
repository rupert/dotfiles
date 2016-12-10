#!/bin/sh

set -e

package() {
  [ -e "$HOME/.local/venvs/$1" ] || pipsi install "$1"
}

package coursera-dl
package flake8
package httpie
package pygments
package stapler
package virtualenvwrapper
