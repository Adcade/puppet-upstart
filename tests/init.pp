Exec {
  path => '/usr/bin:/bin:/usr/sbin:/sbin'
}
exec {'apt-get update': } -> Package<||>

include java7
include vertx

$testdir = '/opt/test'

file { $testdir:
  ensure  => directory,
  recurse => true;
}

file { "${testdir}/adserver.jar":
  ensure  => file,
  source  => "puppet:///modules/upstart/adserver.jar",
  require => File[$testdir];
} ->

upstart::java { "adworker":
  main_class => "com.adcade.SessionEventWorker",
  classpath  => ["${testdir}/adserver.jar"],
}

include nodejs

file { "${testdir}/app.js":
  ensure => file,
  source => "puppet:///modules/upstart/app.js",
} ->

upstart::node { 'nodeapp':
  appdir    => $testdir,
  mainappjs => "app.js",
  require   => Class['nodejs'];
}