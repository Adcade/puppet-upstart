define upstart::python (
  $service   = $title,
  $appdir,
  $main_py,
  $main_args = "",
  $user      = "root",
  $group     = "root",
  $logdir    = "/tmp",
) {

  file { "/etc/init/${service}.conf":
    ensure  => file,
    content => template("${module_name}/python.init.erb"),
    before  => Service[$service],
  }

  service { $service:
    ensure  => running,
    enable  => true,
  }
}

