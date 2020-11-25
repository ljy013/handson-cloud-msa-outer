terraform {
  backend "gcs" {
    bucket = "architect-certification-289902-23-tfstate"
    prefix = "jenkins"
  }
}