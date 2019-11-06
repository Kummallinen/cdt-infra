pipeline {
  agent {
    kubernetes {
      label 'cdt-master-68bfe11'
      yamlFile 'jenkins/pod-templates/cdt-full-pod-standard.yaml'
    }
  }
  options {
    timestamps()
    disableConcurrentBuilds()
  }
  stages {
    stage('Git Clone') {
      steps {
        container('cdt') {
          git branch: 'master', url: 'git://git.eclipse.org/gitroot/cdt/org.eclipse.cdt.git'
        }
      }
    }
    stage('Run build') {
      steps {
        container('cdt') {
          timeout(activity: true, time: 20) {
            withEnv(['MAVEN_OPTS=-Xmx768m -Xms768m']) {
                sh "/home/vnc/.vnc/xstartup_metacity.sh ; \
                sleep 1s; \
                (Xephyr -screen 1024x768 :51 &) ; \
                sleep 1s; \
                export DISPLAY=:51 ; \
                sleep 1s; \
                (metacity --sm-disable --replace &) ; \
                sleep 1s; \
                /usr/share/maven/bin/mvn \
clean verify -B -V \
  -DskipDocs \
  -Pskip-tests-except-cdt-other \
  -Ddsf.gdb.tests.timeout.multiplier=50 \
  -Dindexer.timeout=300 \
  -Dmaven.repo.local=/home/jenkins/.m2/repository \
  --settings /home/jenkins/.m2/settings.xml"
            }
          }
        }
      }
    }
  }
  post {
    always {
      container('cdt') {
        junit '*/*/target/surefire-reports/*.xml'
        archiveArtifacts '**/target/work/data/.metadata/.log,releng/org.eclipse.cdt.repo/target/org.eclipse.cdt.repo.zip,releng/org.eclipse.cdt.repo/target/repository/**,releng/org.eclipse.cdt.testing.repo/target/org.eclipse.cdt.testing.repo.zip,releng/org.eclipse.cdt.testing.repo/target/repository/**,debug/org.eclipse.cdt.debug.application.product/target/product/*.tar.gz,debug/org.eclipse.cdt.debug.application.product/target/products/*.zip,debug/org.eclipse.cdt.debug.application.product/target/products/*.tar.gz,debug/org.eclipse.cdt.debug.application.product/target/repository/**,lsp4e-cpp/org.eclipse.lsp4e.cpp.site/target/repository/**,lsp4e-cpp/org.eclipse.lsp4e.cpp.site/target/org.eclipse.lsp4e.cpp.repo.zip'
      }
    }
  }
}
