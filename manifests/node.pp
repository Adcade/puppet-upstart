define upstart::node (
  $service   = $title,
  $appdir,
  $main_js,
  $main_args = "",
  $user      = "root",
  $group     = "root",
  $logdir    = "/tmp",
) {
  include stdlib

  file { "/etc/init/${service}.conf":
    ensure  => file,
    content => template("${module_name}/node.init.erb"),
    before  => Service[$service],
  }

  service { $service:
    ensure  => running,
    enable  => true,
  }
}
