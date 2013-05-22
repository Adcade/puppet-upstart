Exec {
  path => '/usr/bin:/bin:/usr/sbin:/sbin'
}
exec {'apt-get update': } -> Package<||>

include java7
include vertx

file { '/tmp/Server.java':
  ensure => file,
  source => "puppet:///modules/javaservice/Server.java",
} ->

upstart::java { "vserver":
  main_class => "Server.java",
  classpath  => ["/tmp"],
}

file { '/tmp/Worker.java':
  ensure => file,
  source => "puppet:///modules/javaservice/Worker.java",
} ->

upstart::java { "vworker":
  main_class => "Worker.java",
  classpath  => "/tmp",
}

