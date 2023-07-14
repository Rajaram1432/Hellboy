#!/bin/bash

# Set the email subject
subject="Email Subject Here"

# Set the recipient email addresses
recipients="email1@example.com,email2@example.com"

# Set the email body
body="Email body text goes here."

# Set the path to the files you want to attach
file1="/path/to/file1.txt"
file2="/path/to/file2.pdf"

# Compose the email
{
    echo "To: $recipients"
    echo "Subject: $subject"
    echo "Content-Type: multipart/mixed; boundary=\"boundary123\""
    echo
    echo "--boundary123"
    echo "Content-Type: text/plain"
    echo
    echo "$body"
    echo
    echo "--boundary123"
    echo "Content-Type: application/octet-stream; name=\"$(basename $file1)\""
    echo "Content-Disposition: attachment; filename=\"$(basename $file1)\""
    echo
    cat $file1
    echo
    echo "--boundary123"
    echo "Content-Type: application/octet-stream; name=\"$(basename $file2)\""
    echo "Content-Disposition: attachment; filename=\"$(basename $file2)\""
    echo
    cat $file2
    echo
    echo "--boundary123--"
} | sudo ssmtp $recipients
