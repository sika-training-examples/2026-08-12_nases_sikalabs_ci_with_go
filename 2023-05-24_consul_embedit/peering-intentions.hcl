Kind      = "service-intentions"
Name      = "counter"

Sources = [
  {
    Name   = "frontend-service"
    Peer   = "counter"
    Action = "allow"
  }
]
