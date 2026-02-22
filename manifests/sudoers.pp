# @summary Create a sudoers entry in /etc/sudoers.d/.
#
# Allow restricted root access for specified users. The name of the defined
# type must consist of only letters, numbers and underscores. If the name
# has incorrect characters the defined type will fail.
#
# @param ensure
#   Controls the existence of the sudoers entry. Valid values: present, absent.
#
# @param users
#   Array of users that are allowed to execute the command(s).
#
# @param group
#   Group that can run the listed commands. Cannot be combined with users.
#
# @param hosts
#   Array of hosts that the command(s) can be executed on.
#
# @param cmnds
#   List of commands that the user can run.
#
# @param comment
#   Optional comment to include in the sudoers file.
#
# @param runas
#   The user(s) that the command may be run as.
#
# @param tags
#   Tags associated with the commands (e.g. NOPASSWD, NOEXEC).
#
# @param defaults
#   Override some of the compiled in default values for sudo.
#
# @example Basic usage
#   sudo::sudoers { 'worlddomination':
#     ensure   => 'present',
#     comment  => 'World domination.',
#     users    => ['pinky', 'brain'],
#     runas    => ['root'],
#     cmnds    => ['/bin/bash'],
#     tags     => ['NOPASSWD'],
#     defaults => ['env_keep += "SSH_AUTH_SOCK"'],
#   }
#
define sudo::sudoers (
  Optional[Variant[String, Array[String]]] $users    = undef,
  Optional[String]                         $group    = undef,
  Variant[String, Array[String]]           $hosts    = 'ALL',
  Variant[String, Array[String]]           $cmnds    = 'ALL',
  Optional[String]                         $comment  = undef,
  Enum['present', 'absent']               $ensure   = 'present',
  Variant[String, Array[String]]           $runas    = ['root'],
  Variant[String, Array[String]]           $tags     = [],
  Variant[String, Array[String]]           $defaults = [],
) {
  # filename as per the manual or aliases as per the sudoer spec must not
  # contain dots.
  # As having dots in a username is legit, let's fudge
  $sane_name = regsubst($name, '\.', '_', 'G')
  $sudoers_user_file = "/etc/sudoers.d/${sane_name}"

  if $sane_name !~ /^[A-Za-z][A-Za-z0-9_]*$/ {
    fail("Will not create sudoers file \"${sudoers_user_file}\" (for user \"${name}\") should consist of letters numbers or underscores.")
  }

  if $users != undef and $group != undef {
    fail('You cannot define both a list of users and a group. Choose one.')
  }

  if $ensure == 'present' {
    file { $sudoers_user_file:
      content      => epp('sudo/sudoers.epp', {
          'sane_name' => $sane_name,
          'comment'   => $comment,
          'users'     => $users,
          'group'     => $group,
          'hosts'     => $hosts,
          'runas'     => $runas,
          'cmnds'     => $cmnds,
          'tags'      => $tags,
          'defaults'  => $defaults,
      }),
      owner        => 'root',
      group        => 'root',
      mode         => '0440',
      validate_cmd => '/usr/sbin/visudo -c -f %',
    }
  }
  else {
    file { $sudoers_user_file:
      ensure => 'absent',
    }
  }
}
