import unittest
import requests
import os
import time


class Test(unittest.TestCase):
    def test_response_code(self):
        for _ in range(int(os.environ.get('NUM_OF_TEST', "1"))):
            response = requests.get('http://counter')
            self.assertEqual(200, response.status_code)
            time.sleep(0.01)
