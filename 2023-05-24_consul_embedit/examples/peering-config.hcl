Kind = "exported-services"
Name = "default"
Services = [
  {
    Name      = "counter"
    Consumers = [
      {
        Peer = "fra"
      }
    ]
  },
    {
    Name      = "redis"
    Consumers = [
      {
        Peer = "fra"
      }
    ]
  }
]
