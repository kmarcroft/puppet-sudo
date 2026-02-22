# @summary Manage sudo and sudoers entries.
#
# Allow restricted root access for specified users. The sudo class is
# specifically created to be used from an ENC.
#
# @param sudoers
#   Hash of sudoers entries which will be created via sudo::sudoers.
#
# @param manage_sudoersd
#   Should puppet clean /etc/sudoers.d/ of untracked files?
#
# @param manage_package
#   Whether to manage the sudo package.
#
# @param sudoers_file
#   Puppet file source to install as /etc/sudoers.
#
# @example Basic usage
#   class { 'sudo':
#     sudoers => {
#       'worlddomination' => {
#         ensure  => 'present',
#         comment => 'World domination.',
#         users   => ['pinky', 'brain'],
#         runas   => ['root'],
#         cmnds   => ['/bin/bash'],
#         tags    => ['NOPASSWD'],
#       },
#     },
#   }
#
class sudo (
  Hash             $sudoers         = {},
  Boolean          $manage_sudoersd = false,
  Boolean          $manage_package  = true,
  String           $sudoers_file    = '',
) {
  $sudoers.each |String $title, Hash $params| {
    sudo::sudoers { $title:
      * => $params,
    }
  }

  if $manage_package {
    package { 'sudo':
      ensure => installed,
    }
  }

  file { '/etc/sudoers.d':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0750',
    purge   => $manage_sudoersd,
    recurse => $manage_sudoersd,
    force   => $manage_sudoersd,
  }

  if $sudoers_file =~ /^puppet:\/\// {
    file { '/etc/sudoers':
      ensure => file,
      owner  => 'root',
      group  => 'root',
      mode   => '0440',
      source => $sudoers_file,
    }
  }
}
