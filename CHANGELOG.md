# Changelog

All notable changes to this project will be documented in this file.

## [3.0.2] - 2026-02-22

### Fixed

- Fixed CI smoke test: correct OpenVox apt repo URL (apt.voxpupuli.org)
- Fixed CI smoke test: use OS version instead of codename for deb filename
- Fixed CI smoke test: use correct binary path (/opt/puppetlabs/bin/puppet)
- Fixed CI smoke test: symlink module directory to match module name

## [3.0.1] - 2026-02-22

### Fixed

- Removed obsolete beaker acceptance test section from README
- Removed duplicate contributors line in README

## [3.0.0] - 2026-02-22

Forked from [arnoudj/puppet-sudo](https://github.com/arnoudj/puppet-sudo) by
**Arnoud de Jonge**. Full credit for the original module design and all releases
up to 2.0.0 belongs to Arnoud and the original contributors.

### Breaking Changes

- Minimum Puppet version is now 8.0.0
- Minimum puppetlabs/stdlib version is now 9.0.0
- Removed support for Puppet 3.x–7.x
- Removed support for EOL operating systems (RHEL 5/6, CentOS 5/6, Scientific Linux, Debian 6/7, Ubuntu 10.04–14.04)
- Package ensure changed from `latest` to `installed`

### Added

- Typed parameters on all classes and defined types
- EPP template replacing legacy ERB template
- Puppet Strings documentation (`@summary`, `@param`, `@example`)
- Support for Rocky Linux 8/9 and AlmaLinux 8/9
- `validate_cmd` is now always set on sudoers files

### Changed

- Replaced `create_resources()` with modern `each` iterator and splat operator
- Converted ERB template (`sudoers.erb`) to EPP (`sudoers.epp`)
- Updated OS support: RedHat 8/9, CentOS 8/9, OracleLinux 8/9, Debian 11/12, Ubuntu 22.04/24.04
- Updated stdlib dependency to `>= 9.0.0 < 10.0.0`
- Updated Gemfile for modern tooling (puppet-lint 4, rspec-puppet 4, puppet-syntax 4)
- Updated `.fixtures.yml` to use HTTPS for stdlib repository
- Modernised RSpec tests to use `is_expected.to` syntax

### Removed

- Legacy `$::puppetversion` fact usage (removed in Puppet 8)
- `versioncmp` conditional for Puppet < 3.5 compatibility
- `validate_cmd()` stdlib function call (removed in modern stdlib)
- Beaker acceptance test dependencies
- Travis CI gems and configuration
- ERB template (`templates/sudoers.erb`)

---

*All releases below were made by [Arnoud de Jonge](https://github.com/arnoudj)
in the original [arnoudj/puppet-sudo](https://github.com/arnoudj/puppet-sudo) repository.*

## [1.3.0]

### Added

- Support for managing a group instead of a list of users
- Support for `defaults` parameter on sudoers entries
- Support for overriding `/etc/sudoers` via `sudoers_file` parameter

## [1.2.0]

### Added

- Support for `manage_package` parameter
- Support for `manage_sudoersd` to purge unmanaged files

## [1.1.0]

### Added

- Support for string parameters in addition to arrays
- Validation of sudoers file names

## [1.0.0]

### Added

- Initial release
- `sudo` class for managing the sudo package and `/etc/sudoers.d/`
- `sudo::sudoers` defined type for managing individual sudoers entries
