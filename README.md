# vcf-east-2024-classes

## Building presentation

The presentations can be built into a local build/ directory with the following:

``` shell
./build.sh
```

This will download required emacs packages, and run org-publish to produce relevant output.
All the actual code is in the local `org-publish.el` file, the shell script above just runs
emacs in batch mode using that emacs lisp script.
