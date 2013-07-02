define upstart::node (
  $service   = $title,
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
