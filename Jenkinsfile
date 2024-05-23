node {
  stage('Fetch Code') {
    checkout scm
  }

  stage('Build Image') {
    def ruby_version = readFile('.ruby-version').trim()
    def image = docker.build(
      "umts/fleetfocus-api:${env.BUILD_ID}",
      "--build-arg RUBY_VERSION=${ruby_version} ./"
    )
  }
}
