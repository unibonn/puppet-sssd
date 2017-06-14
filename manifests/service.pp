# == Class: sssd::service
#
#  This is an internal class.
#  The main entry point for the module is the init class
#

class sssd::service {
  if $sssd::manage_service {
    if $sssd::service_provider != '' {
      service{$sssd::service_name:
        provider => $sssd::service_provider,
        ensure => $sssd::service_ensure,
        enable => $sssd::service_enable,
      }
    }
    else
    {
      service{$sssd::service_name:
        ensure => $sssd::service_ensure,
        enable => $sssd::service_enable,
      }
    }
    if $sssd::flush_cache_on_change {
      exec{'sss_cache flush':
        command     => 'sss_cache -E',
        path        => $sssd::sss_cache_path,
        refreshonly => true,
        returns     => [0, 2],
        require     => Service[$sssd::service_name]
      }
    }
  }
}
