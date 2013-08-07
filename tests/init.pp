Exec {
  path => '/usr/bin:/bin:/usr/sbin:/sbin'
}
exec {'apt-get update': } -> Package<||>

include java7

$testdir = '/opt/test'

file { $testdir:
  ensure  => directory,
  recurse => true;
}

file { "${testdir}/Server.class":
  ensure  => file,
  source  => "puppet:///modules/upstart/Server.class",
  require => File[$testdir];
} ->

upstart::java { "javaapp":
  main_class => "Server",
  classpath  => [$testdir],
}

include nodejs

file { "${testdir}/app.js":
  ensure => file,
  source => "puppet:///modules/upstart/app.js",
} ->

upstart::node { 'nodeapp':
  appdir    => $testdir,
  main_js => "app.js",
  require   => Class['nodejs'];
}

file { "${testdir}/app.py":
  ensure => file,
  source => "puppet:///modules/upstart/app.py",
} ->

upstart::python { 'pyapp':
  appdir    => $testdir,
  main_py => "app.py",
}
