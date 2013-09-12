define upstart::java (
  $service   = $title,
  $main_class,
  $classpath = [],
  $user      = "root",
  $group     = "root",
  $logfile   = "/tmp/${title}.stdio",
  $XMS       = '256M',
  $XMX       = '1G',
  $XSS       = '2048K',
) {
  include stdlib

  if is_string($classpath) {
    $cp = [$classpath]
  } else {
    $cp = $classpath
  }

  file { "/etc/${service}.conf":
    ensure  => file,
    content => template("${module_name}/java.conf.erb"),
  }

  file { "/etc/init/${service}.conf":
    ensure  => file,
    content => template("${module_name}/java.init.erb"),
  }

  service { $service:
    ensure  => running,
    enable  => true,
    subscribe => File["/etc/${service}.conf", "/etc/init/${service}.conf"],
  }
}
