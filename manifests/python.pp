define upstart::python (
  $service   = $title,
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

