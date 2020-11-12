# Capacitor CLI diff for @capacitor/android

This repository exposes an Capacitor CLI app generated with
`npx cap init` and `npx add android` with each version of Capacitor CLI.

A dedicated branch per version makes changes very easy
to watch. For example:

* https://github.com/tobika/capacitor-cli-diff/compare/1.5.3...2.0.0
* https://github.com/tobika/capacitor-cli-diff/compare/2.0.0...2.4.2

See table below for the complete list.

Note that this is inspired and the script heavily copied from [Angular CLI diff](https://github.com/cexbrayat/angular-cli-diff).

## Version changes

Version|Compare view|Stats
----|----|----
3.0.0-alpha.1|[3.0.0-alpha.0...3.0.0-alpha.1](https://github.com/tobika/capacitor-cli-diff/compare/3.0.0-alpha.0...3.0.0-alpha.1)| 1 file changed, 3 insertions(+), 3 deletions(-)
3.0.0-alpha.0|[2.4.2...3.0.0-alpha.0](https://github.com/tobika/capacitor-cli-diff/compare/2.4.2...3.0.0-alpha.0)| 5 files changed, 37 insertions(+), 32 deletions(-)
2.4.2|[2.4.1...2.4.2](https://github.com/tobika/capacitor-cli-diff/compare/2.4.1...2.4.2)| 1 file changed, 3 insertions(+), 3 deletions(-)
2.4.1|[2.0.0...2.4.1](https://github.com/tobika/capacitor-cli-diff/compare/2.0.0...2.4.1)| 6 files changed, 90 insertions(+), 49 deletions(-)
2.0.0|[1.5.3...2.0.0](https://github.com/tobika/capacitor-cli-diff/compare/1.5.3...2.0.0)| 11 files changed, 45 insertions(+), 29 deletions(-)
1.5.3|[1.0.0...1.5.3](https://github.com/tobika/capacitor-cli-diff/compare/1.0.0...1.5.3)| 6 files changed, 26 insertions(+), 7 deletions(-)
1.0.0|[1.0.0...1.0.0](https://github.com/tobika/capacitor-cli-diff/compare/1.0.0...1.0.0)| 57 files changed, 882 insertions(+)


## Why this repository ?

After an upgrade of `@capacitor/core` and `@capacitor/android` on your project, you'll have to keep the configuration up-to-date, and it can be hard to keep track.

This project lets you easily know what changed. For example, from
[1.5.3 to the 2.0.0](https://github.com/tobika/capacitor-cli-diff/compare/1.5.3...2.0.0).
