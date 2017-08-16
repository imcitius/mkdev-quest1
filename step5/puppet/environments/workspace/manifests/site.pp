node default {

  user {"maven":
    ensure => "present",
    home => "/home/maven",
    managehome => true,
  }

 $packages = [ "mc", "git", "nano", "@Development tools", "java-1.8.0-openjdk" ]

 Package { ensure => "installed" }
 package { $packages: }

 include maven::maven

 $project_path = "/home/maven/fast_blank"

 file { "${project_path}":
   ensure => directory,
   owner => "maven",
 }

 file { "/home/maven/.m2/":
   ensure => directory,
   owner => "maven",
 }

 file { "pom.xml":
   path => "${project_path}/pom.xml",
   source => 'puppet:///modules/files/pom.xml',
   ensure => present,
   owner => "maven",
 }

 file { "maven-settings.xml":
   path => "/home/maven/.m2/settings.xml",
   source => 'puppet:///modules/files/maven-settings.xml',
   ensure => present,
   owner => "maven",
 }

# vcsrepo { "${project_path}/src":
#  ensure   => present,
#  provider => git,
#  source   => "https://github.com/SamSaffron/fast_blank.git",
#  user     => "maven",
# }

 file_line { "repo user":
   path  => "/etc/maven/settings.xml",
   line  => "<username>mvn</username>",
   match => "<username>repouser</username>",
 }

 file_line { "repo password":
   path  => "/etc/maven/settings.xml",
   line  => "<username>mvn</username>",
   match => "<password>repopwd</password",
 }

 exec { "mvn scm:checkout":
  cwd      => "${project_path}",
  user     => "maven",
  path     => "/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/opt/puppetlabs/bin:/home/maven/.local/bin:/home/maven/bin",
 }

 exec { "mvn package":
  cwd      => "${project_path}",
  user     => "maven",
  path     => "/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/opt/puppetlabs/bin:/home/maven/.local/bin:/home/maven/bin",
 }

 exec { "mvn deploy":
  cwd      => "${project_path}",
  user     => "maven",
  path     => "/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/opt/puppetlabs/bin:/home/maven/.local/bin:/home/maven/bin",
 }


}

class { "maven::maven":
  version => "3.5.0",
  repo => {
      url => "http://repo.maven.apache.org/maven2",
      username => "",
      password => "",
  }
}

Maven {
  user  => "maven",
  group => "maven",
  repos => "http://repo.maven.apache.org/maven2"
}