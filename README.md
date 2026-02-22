# puppet-sudo

Allow restricted root access for specified users. The name of the defined
type must consist of only letters, numbers and underscores and should be
unique. If the name has incorrect characters the defined type will fail.
Sudoers entries realised with the `sudo::sudoers` defined type will be
stored in `"/etc/sudoers.d/[typename]"`.

## Fork Notice

This module is a fork of [arnoudj/puppet-sudo](https://github.com/arnoudj/puppet-sudo),
originally created by **Arnoud de Jonge**. All credit for the original design
and implementation goes to Arnoud and the original
[contributors](https://github.com/arnoudj/puppet-sudo/graphs/contributors).

This fork (3.0.0+) modernises the module for Puppet 8.x / OpenVox 8.x compatibility.

## Requirements

- Puppet 8.x or OpenVox 8.x
- puppetlabs/stdlib >= 9.0.0

This module expects that your OS/Distribution supports /etc/sudoers.d,
which is true for all modern Linux distributions. If this is not the case,
you can overwrite the default sudoers file with your own using the
`sudoers_file` parameter of the sudo class, and add the line:

    #include /etc/sudoers.d

## Parameters for class sudo

### sudoers

Hash of sudoers entries, which will be created via sudo::sudoers.

### manage\_sudoersd

Boolean - should puppet clean /etc/sudoers.d/ of untracked files?

### sudoers\_file

Override the /etc/sudoers file with the file specified by this parameter.

## Parameters for type sudo::sudoers

### ensure

Controls the existence of the sudoers entry. Set this attribute to
present to ensure the sudoers entry exists. Set it to absent to
delete any computer records with this name Valid values are present,
absent.

### users

Array of users that are allowed to execute the command(s).

### group

Group that is allowed to execute the command(s). Cannot be combined with 'users'.

### hosts

Array of hosts that the command(s) can be executed on. Denying hosts using a bang/exclamation point may also be used.

### cmnds

List of commands that the user can run.

### runas

The user that the command may be run as.

### cmnds

The commands which the user is allowed to run.

### tags

A command may have zero or more tags associated with it.  There are
eight possible tag values, NOPASSWD, PASSWD, NOEXEC, EXEC, SETENV,
NOSETENV, LOG_INPUT, NOLOG_INPUT, LOG_OUTPUT and NOLOG_OUTPUT.

### defaults

Override some of the compiled in default values for sudo.

## Example

A sudoers entry can be defined within a class or node definition:

    sudo::sudoers { 'worlddomination':
      ensure   => 'present',
      comment  => 'World domination.',
      users    => ['pinky', 'brain'],
      hosts    => ['foo.lab', 'bar.lab'],
      runas    => ['root'],
      cmnds    => ['ALL'],
      tags     => ['NOPASSWD'],
      defaults => [ 'env_keep += "SSH_AUTH_SOCK"' ]
    }

or via an ENC:

    ---
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

## Run syntax, lint and unit tests

```
bundle exec rake test
```

## Run [beaker](https://github.com/puppetlabs/beaker) acceptance tests

```
bundle exec rspec spec/acceptance/
```

## Contributors

This module was originally written by [Arnoud de Jonge](https://github.com/arnoudj).
Thanks to all [original contributors](https://github.com/arnoudj/puppet-sudo/graphs/contributors).

Thanks to [all contributors](https://github.com/arnoudj/puppet-sudo/graphs/contributors).
