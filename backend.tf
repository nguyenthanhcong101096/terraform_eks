terraform {
  backend "s3" {
    bucket = "congnt-terraform"
    key    = "ft_state.state"
  }
}
