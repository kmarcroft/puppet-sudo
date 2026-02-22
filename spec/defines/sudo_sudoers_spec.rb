require 'spec_helper'

describe 'sudo::sudoers', type: :define do
  let(:title) { 'world.domination' }

  context 'minimum params' do
    let(:params) { { users: ['joe'] } }

    it { is_expected.to contain_file('/etc/sudoers.d/world_domination') }
  end

  context 'setting sudo for a user' do
    let(:params) do
      {
        users: ['pinky', 'brain'],
        comment: 'Today we\'re going to take over the world',
        runas: ['animaniacs'],
        cmnds: ['/bin/bash'],
        tags: ['LOG_INPUT', 'LOG_OUTPUT'],
        defaults: ['env_keep += "SSH_AUTH_SOCK"'],
      }
    end

    it { is_expected.to contain_file('/etc/sudoers.d/world_domination').with_content(%r{^# Today\swe're\sgoing\sto\stake\sover\sthe\sworld$}) }
    it { is_expected.to contain_file('/etc/sudoers.d/world_domination').with_content(%r{^User_Alias\s*WORLD_DOMINATION_USERS\s=\spinky,\sbrain$}) }
    it { is_expected.to contain_file('/etc/sudoers.d/world_domination').with_content(%r{^Runas_Alias\s*WORLD_DOMINATION_RUNAS\s=\sanimaniacs$}) }
    it { is_expected.to contain_file('/etc/sudoers.d/world_domination').with_content(%r{^Cmnd_Alias\s*WORLD_DOMINATION_CMNDS\s=\s/bin/bash$}) }
    it { is_expected.to contain_file('/etc/sudoers.d/world_domination').with_content(%r{^WORLD_DOMINATION_USERS\sWORLD_DOMINATION_HOSTS\s=\s\(WORLD_DOMINATION_RUNAS\)\sLOG_INPUT:\sLOG_OUTPUT:\sWORLD_DOMINATION_CMNDS$}) }
    it { is_expected.to contain_file('/etc/sudoers.d/world_domination').with_content(%r{Defaults!WORLD_DOMINATION_CMNDS env_keep \+= "SSH_AUTH_SOCK"}) }
  end

  context 'setting sudo for a group' do
    let(:params) do
      {
        group: 'lab',
        comment: 'Today we\'re going to take over the world',
        runas: ['animaniacs'],
        cmnds: ['/bin/bash'],
        tags: ['LOG_INPUT', 'LOG_OUTPUT'],
        defaults: ['env_keep += "SSH_AUTH_SOCK"'],
      }
    end

    it { is_expected.to contain_file('/etc/sudoers.d/world_domination').with_content(%r{^# Today\swe're\sgoing\sto\stake\sover\sthe\sworld$}) }
    it { is_expected.to contain_file('/etc/sudoers.d/world_domination').with_content(%r{^Runas_Alias\s*WORLD_DOMINATION_RUNAS\s=\sanimaniacs$}) }
    it { is_expected.to contain_file('/etc/sudoers.d/world_domination').with_content(%r{^Cmnd_Alias\s*WORLD_DOMINATION_CMNDS\s=\s/bin/bash$}) }
    it { is_expected.to contain_file('/etc/sudoers.d/world_domination').with_content(%r{%lab\sWORLD_DOMINATION_HOSTS\s=\s\(WORLD_DOMINATION_RUNAS\)\sLOG_INPUT:\sLOG_OUTPUT:\sWORLD_DOMINATION_CMNDS$}) }
    it { is_expected.to contain_file('/etc/sudoers.d/world_domination').with_content(%r{Defaults!WORLD_DOMINATION_CMNDS env_keep \+= "SSH_AUTH_SOCK"}) }
  end

  context 'using strings instead of arrays' do
    let(:params) do
      {
        users: 'riton',
        runas: 'root',
        cmnds: '/bin/bash',
        tags: 'NOPASSWD',
        defaults: 'env_keep += "KRB5CCNAME"',
      }
    end

    it { is_expected.to contain_file('/etc/sudoers.d/world_domination').with_content(%r{^User_Alias\s*WORLD_DOMINATION_USERS\s=\sriton$}) }
    it { is_expected.to contain_file('/etc/sudoers.d/world_domination').with_content(%r{^Runas_Alias\s*WORLD_DOMINATION_RUNAS\s=\sroot$}) }
    it { is_expected.to contain_file('/etc/sudoers.d/world_domination').with_content(%r{^Cmnd_Alias\s*WORLD_DOMINATION_CMNDS\s=\s/bin/bash$}) }
    it { is_expected.to contain_file('/etc/sudoers.d/world_domination').with_content(%r{^WORLD_DOMINATION_USERS\sWORLD_DOMINATION_HOSTS\s=\s\(WORLD_DOMINATION_RUNAS\)\sNOPASSWD:\sWORLD_DOMINATION_CMNDS$}) }
    it { is_expected.to contain_file('/etc/sudoers.d/world_domination').with_content(%r{Defaults!WORLD_DOMINATION_CMNDS env_keep \+= "KRB5CCNAME"}) }
  end

  context 'validate_cmd is always present' do
    let(:params) { { users: ['joe'] } }

    it { is_expected.to contain_file('/etc/sudoers.d/world_domination').with_validate_cmd('/usr/sbin/visudo -c -f %') }
  end

  context 'absent' do
    let(:params) { { users: 'notneeded', ensure: 'absent' } }

    it { is_expected.to contain_file('/etc/sudoers.d/world_domination').with_ensure('absent') }
  end
end
