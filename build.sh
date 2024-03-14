#!/bin/bash

# use a local .emacs.d dir, not the global version, so this can be built without affecting local emacs
HOME=. emacs --batch -l ./org-export.el
