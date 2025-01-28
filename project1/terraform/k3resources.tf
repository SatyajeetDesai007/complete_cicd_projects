# Configure the Kubernetes provider
provider "kubernetes" {
  host                   = "https://${aws_instance.k8s_instance.public_ip}:6443"
  cluster_ca_certificate = base64decode("LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUJlRENDQVIyZ0F3SUJBZ0lCQURBS0JnZ3Foa2pPUFFRREFqQWpNU0V3SHdZRFZRUUREQmhyTTNNdGMyVnkKZG1WeUxXTmhRREUzTXpnd05UWTNOelF3SGhjTk1qVXdNVEk0TURrek1qVTBXaGNOTXpVd01USTJNRGt6TWpVMApXakFqTVNFd0h3WURWUVFEREJock0zTXRjMlZ5ZG1WeUxXTmhRREUzTXpnd05UWTNOelF3V1RBVEJnY3Foa2pPClBRSUJCZ2dxaGtqT1BRTUJCd05DQUFSd0hoNUdQbU5rUElJdTN1UzlNMXZuSnpNRmRSM21qd2dXb3ROSmdhUU0KWm9KakpSV1Q1YzVGaGJuWm5KaUpOZGJtK05JVklqZjVaVFZXQkt5Nzk5TndvMEl3UURBT0JnTlZIUThCQWY4RQpCQU1DQXFRd0R3WURWUjBUQVFIL0JBVXdBd0VCL3pBZEJnTlZIUTRFRmdRVTd5ODE2WVdlalh4U3lZRTc4eE1BCmYvWUsvUWd3Q2dZSUtvWkl6ajBFQXdJRFNRQXdSZ0loQU1xVUpwdnpQbTl3OUt2bFlpV1VrWjlaN2xaaXlYREIKUzNibHRzTC9HbmFSQWlFQTQ3cmw5VUhWQ1BkSUVHNk9rQnJrNkRaMjlnd3lhUk54SUNaWlJoV0xiUXM9Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K")
  config_path = "C:/Users/satya/.kube/config"
}

# Kubernetes Deployment for Flask App
resource "kubernetes_deployment" "flask_app" {
  metadata {
    name = "flask-app"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "flask-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "flask-app"
        }
      }

      spec {
        container {
          name  = "flask-app"
          image = "satyajeetdesai/flask-app:latest"

          port {
            container_port = 5000
          }
        }
      }
    }
  }
}

# Kubernetes Service for Flask App
resource "kubernetes_service" "flask_app" {
  metadata {
    name = "flask-app-service"
  }

  spec {
    selector = {
      app = "flask-app"
    }

    port {
      protocol = "TCP"
      port     = 80
      target_port = 5000
    }

    type = "LoadBalancer"
  }
}
