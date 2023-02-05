import unittest
import requests


class Test(unittest.TestCase):
    def test_response_code(self):
        response = requests.get('http://counter')
        self.assertEqual(200, response.status_code)

    def test_response_code_1(self):
        response = requests.get('http://counter')
        self.assertEqual(200, response.status_code)

    def test_response_code_2(self):
        response = requests.get('http://counter')
        self.assertEqual(200, response.status_code)

    def test_response_code_3(self):
        response = requests.get('http://counter')
        self.assertEqual(200, response.status_code)
