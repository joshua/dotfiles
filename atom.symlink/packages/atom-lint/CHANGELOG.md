# Changelog

## Development

## v0.11.3

* Fix a bug where singlequotes used as apostrophe in violation messages were marked up as code snippets. ([@yujinakayama])

## v0.11.2

* [#45](https://github.com/yujinakayama/atom-lint/issues/45): Fix a bug where the tooltip was cut off by the top of the editor when the file has only a few lines. ([@yujinakayama])

## v0.11.1

* Fix a bug where violation highlights weren't placed properly when the editor (tab) is not active and the file is reloaded by a modification by another process. ([@yujinakayama])

## v0.11.0

* [#44](https://github.com/yujinakayama/atom-lint/pull/44): Add Rust support via rustc. ([@shtirlic])
* Beautify and mark up violation messages. ([@yujinakayama])

## v0.10.1

* [#42](https://github.com/yujinakayama/atom-lint/issues/42): Fix error `Uncaught ReferenceError: _ is not defined` when some violations that are currently out of sight in the editor scroll view are moved by a modification (e.g. insertion of a line at beginning of the file). ([@yujinakayama])

## v0.10.0

* [#34](https://github.com/yujinakayama/atom-lint/issues/34): Support column range highlight for RuboCop offenses. ([@yujinakayama])
* [#40](https://github.com/yujinakayama/atom-lint/pull/40): Add C/C++/Objective-C support via Clang. ([@wesbland])
* Violation highlight now follows source modification. ([@yujinakayama])
* Fix strange appearance of non-related tooltips on modification. ([@yujinakayama])

## v0.9.0

* Add shell script support via ShellCheck. ([@yujinakayama])
* Allow to show tooltips with mouseover on a violation character. ([@yujinakayama])
* Place tooltip smartly according to the violation position in the editor. ([@yujinakayama])
* Show tooltip if the cursor is at a violation on open and on modification by another process. ([@yujinakayama])
* Fix a bug causing useless beep on **Move to Previous/Next Violation** after once atom-lint enabled again by toggling. ([@yujinakayama])
* [#33](https://github.com/yujinakayama/atom-lint/issues/33): Fix strange shadow of tooltip with Atom themes that don't have the Less variable `@syntax-background-color`. ([@yujinakayama])

## v0.8.1

* [#30](https://github.com/yujinakayama/atom-lint/issues/30): Merge `PATH` and `GEM_PATH` of the login shell and the shell where Atom was launched when running command so that shell-instance-specific `PATH` (e.g. RVM's gemset) can be used. ([@yujinakayama])

## v0.8.0

* [#21](https://github.com/yujinakayama/atom-lint/issues/21): Add Puppet support via puppet-lint. ([@yujinakayama])
* [#27](https://github.com/yujinakayama/atom-lint/pull/27): Add CSS support via CSSLint. ([@jonrohan][])
* [#28](https://github.com/yujinakayama/atom-lint/pull/28): Add SCSS support via SCSS-Lint. ([@jonrohan][])
* [#25](https://github.com/yujinakayama/atom-lint/issues/25): Allow to disable linting on specific files with configuration. ([@yujinakayama])
* Rerun lint when the file was reloaded with modification by another process. ([@yujinakayama])
* Improve tooltip style. ([@yujinakayama])
* Tweak position of the icons in the status bar. ([@yujinakayama])
* Display a message in the status bar when the current active linter is not installed. ([@yujinakayama])

## v0.7.0

* [#8](https://github.com/yujinakayama/atom-lint/issues/8): Display current active linter name and violation summary in the status bar. ([@yujinakayama])

## v0.6.0

* [#23](https://github.com/yujinakayama/atom-lint/pull/23): Add Go support via gc. ([@moshee][])

## v0.5.2

* [#19](https://github.com/yujinakayama/atom-lint/issues/19), [#20](https://github.com/yujinakayama/atom-lint/issues/20): Fix `Uncaught TypeError: Cannot call method 'sort' of undefined` on failure of linting. ([@yujinakayama][])

## v0.5.1

* Fix a bug where sometimes style of HLint results in tooltip were not applied. ([@yujinakayama][])

## v0.5.0

* [#16](https://github.com/yujinakayama/atom-lint/pull/16): Support multiline in tooltips. ([@x0l][])
* [#18](https://github.com/yujinakayama/atom-lint/pull/18): Add CoffeeLint support. ([@x0l][])
* Markup HLint results in tooltip. ([@yujinakayama][])

## v0.4.1

* Minimize additional startup time of Atom caused by atom-lint. ([@yujinakayama][])

## v0.4.0

* [#10](https://github.com/yujinakayama/atom-lint/pull/10): Add Haskell support via HLint. ([@x0l][])
* [#11](https://github.com/yujinakayama/atom-lint/pull/11): Add JavaScript support via JSHint. ([@benjohnson][])
* Add “Move to Next/Previous Violation”. ([@yujinakayama][])
* Fix a bug where linters were possibly run multiple times on a save. ([@yujinakayama][])
* Fix an odd animation on red violation arrows when the editor was clicked. ([@yujinakayama][])

## v0.3.0

* [#9](https://github.com/yujinakayama/atom-lint/pull/9): Add Python support via flake8. ([@danielgtaylor][])

## v0.2.0

* Display violation marks for each line on gutter. ([@yujinakayama])
* Fix wrong use of key for offenses in RuboCop's JSON result. ([@yujinakayama])

## v0.1.2

* [#1](https://github.com/yujinakayama/atom-lint/issues/1): Use `PATH` of the login shell even if Atom is launched from Finder or Dock so that executable `rubocop` can be found properly. ([@yujinakayama])
* [#1](https://github.com/yujinakayama/atom-lint/issues/1): Use config `atom-lint.rubocop.path` as an executable path for `rubocop` if it's set. ([@yujinakayama])

## v0.1.1

* Fix broken image in README. ([@yujinakayama])

## v0.1.0

* Initial release. ([@yujinakayama])

[@yujinakayama]: https://github.com/yujinakayama
[@danielgtaylor]: https://github.com/danielgtaylor
[@x0l]: https://github.com/x0l
[@benjohnson]: https://github.com/benjohnson
[@moshee]: https://github.com/moshee
[@jonrohan]: https://github.com/jonrohan
[@wesbland]: https://github.com/wesbland
[@shtirlic]: https://github.com/shtirlic
