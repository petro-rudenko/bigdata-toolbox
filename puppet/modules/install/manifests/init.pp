class install {

  file{"/tmp/install":
    ensure => directory
  }
  
  include ambari-server
  include ambari-bluprints
}
