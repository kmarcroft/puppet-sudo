# puppet-sudo

Manage sudo and individual sudoers entries via `/etc/sudoers.d/`.

The name of each `sudo::sudoers` resource must consist of only letters,
numbers and underscores and should be unique. Dots in resource names are
automatically replaced with underscores.

## Fork Notice

This module is a fork of [arnoudj/puppet-sudo](https://github.com/arnoudj/puppet-sudo),
originally created by **Arnoud de Jonge**. All credit for the original design
and implementation goes to Arnoud and the original
[contributors](https://github.com/arnoudj/puppet-sudo/graphs/contributors).

This fork (3.0.0+) modernises the module for Puppet 8.x / OpenVox 8.x compatibility.

## Requirements

- Puppet 8.x or OpenVox 8.x
- puppetlabs/stdlib >= 9.0.0

### Supported Operating Systems

- RedHat / CentOS / OracleLinux / Rocky / AlmaLinux 8, 9, 10
- Debian 11, 12, 13
- Ubuntu 22.04, 24.04

## Class: `sudo`

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `sudoers` | `Hash` | `{}` | Hash of sudoers entries, created via `sudo::sudoers`. |
| `manage_sudoersd` | `Boolean` | `false` | Purge unmanaged files from `/etc/sudoers.d/`. |
| `manage_package` | `Boolean` | `true` | Whether to manage the `sudo` package. |
| `sudoers_file` | `String` | `''` | A `puppet:///` source to install as `/etc/sudoers`. |

## Defined Type: `sudo::sudoers`

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `ensure` | `Enum['present','absent']` | `'present'` | Whether the entry should exist. |
| `users` | `Optional[Variant[String, Array[String]]]` | `undef` | Users allowed to run commands. Cannot combine with `group`. |
| `group` | `Optional[String]` | `undef` | Group allowed to run commands. Cannot combine with `users`. |
| `hosts` | `Variant[String, Array[String]]` | `'ALL'` | Hosts the commands can be executed on. |
| `cmnds` | `Variant[String, Array[String]]` | `'ALL'` | Commands the user/group can run. |
| `runas` | `Variant[String, Array[String]]` | `['root']` | User(s) the commands may be run as. |
| `tags` | `Variant[String, Array[String]]` | `[]` | Tags: `NOPASSWD`, `PASSWD`, `NOEXEC`, `EXEC`, `SETENV`, `NOSETENV`, `LOG_INPUT`, `NOLOG_INPUT`, `LOG_OUTPUT`, `NOLOG_OUTPUT`. |
| `defaults` | `Variant[String, Array[String]]` | `[]` | Override compiled-in sudo defaults for these commands. |
| `comment` | `Optional[String]` | `undef` | Comment to include in the sudoers file. |

## Examples

### Puppet manifest

```puppet
sudo::sudoers { 'worlddomination':
  ensure   => 'present',
  comment  => 'World domination.',
  users    => ['pinky', 'brain'],
  hosts    => ['foo.lab', 'bar.lab'],
  runas    => ['root'],
  cmnds    => ['ALL'],
  tags     => ['NOPASSWD'],
  defaults => ['env_keep += "SSH_AUTH_SOCK"'],
}
```

### Hiera / ENC

```yaml
classes:
  sudo:
    sudoers:
      worlddomination:
        ensure: present
        comment: "World Domination."
        users:
          - pinky
          - brain
        hosts:
          - foo.lab
          - bar.lab
        runas:
          - root
        cmnds:
          - ALL
        tags:
          - NOPASSWD
        defaults:
          - 'env_keep += "SSH_AUTH_SOCK"'
```

## Development

### Run syntax, lint and unit tests

```sh
bundle install
bundle exec rake test
```

### CI

This module uses [GitHub Actions](.github/workflows/ci.yml) for automated
lint, syntax, unit tests, and a smoke test using OpenVox 8.

## Contributors

This module was originally written by [Arnoud de Jonge](https://github.com/arnoudj).
Thanks to all [original contributors](https://github.com/arnoudj/puppet-sudo/graphs/contributors).
