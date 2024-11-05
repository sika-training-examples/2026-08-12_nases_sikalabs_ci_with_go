#!/bin/sh

sleep 1 && echo "GET / 200" >> /tmp/java.log
sleep 1 && echo "GET /livez 200" >> /tmp/java.log
sleep 1 && echo "Exception in thread "main" java.lang.IllegalStateException: A book has a null property" >> /tmp/java.log
sleep 1 && echo "       at com.example.myproject.Author.getBookIds(Author.java:38)" >> /tmp/java.log
sleep 1 && echo "       at com.example.myproject.Bootstrap.main(Bootstrap.java:14)" >> /tmp/java.log
sleep 1 && echo "Caused by: java.lang.NullPointerException" >> /tmp/java.log
sleep 1 && echo "       at com.example.myproject.Book.getId(Book.java:22)" >> /tmp/java.log
sleep 1 && echo "       at com.example.myproject.Author.getBookIds(Author.java:35)" >> /tmp/java.log
sleep 1 && echo "       ... 1 more" >> /tmp/java.log
sleep 1 && echo "GET /livez 200" >> /tmp/java.log
sleep 1 && echo "GET /hello 200" >> /tmp/java.log
