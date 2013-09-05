Exec { path => [ "/bin/", "/sbin/", "/usr/bin/", "/usr/sbin/" ] }

define line($file, $line, $ensure = 'present') {
    case $ensure {
        default : { err ( "unknown ensure value ${ensure}" ) }
        present: {
            exec { "/bin/echo '${line}' >> '${file}'":
                unless => "/bin/grep -qFx '${line}' '${file}'"
            }
        }
        absent: {
            exec { "/bin/grep -vFx '${line}' '${file}' | /usr/bin/tee '${file}.new' > /dev/null 2>&1; mv -f '${file}.new' '${file}' > /dev/null 2>&1":
              onlyif => "/bin/grep -qFx '${line}' '${file}'"
            }

         }
    }
}

class prepare {
  file { "/etc/bashrc": ensure => present, }

  line { java_home:
       file => "/etc/bashrc",
       line => 'export JAVA_HOME=/usr/jdk/jdk1.6.0_31/',
   }

   line { java_path:
       file => "/etc/bashrc",
       line => 'export PATH="${JAVA_HOME}bin:$PATH"',
       require => Line[java_home],
   }

   exec { "add_java_to_alternatives":
     command => "alternatives --install /usr/bin/java java /usr/jdk/jdk1.6.0_31/bin/java 1 && alternatives --set java /usr/jdk/jdk1.6.0_31/bin/java"
   }
   
}

include prepare
include hdp
include storm
include spark
