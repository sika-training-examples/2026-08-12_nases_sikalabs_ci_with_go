#!/usr/bin/env python3

import json
import random

print(
    json.dumps(
        {
            "all": {
                "hosts": random.choice(
                    [
                        ["vm0a.sikademo.com"],
                        ["vm1a.sikademo.com"],
                        ["vm10a.sikademo.com", "vm11a.sikademo.com"],
                    ]
                )
            }
        }
    )
)
