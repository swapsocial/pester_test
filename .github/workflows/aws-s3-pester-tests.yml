name: Run Pester Tests for AWS S3 Bucket

on:
  push:
    branches:
      - main  # Run tests on push to the main branch
  pull_request:
    branches:
      - main  # Run tests on pull requests targeting the main branch

jobs:
  run-pester-tests:
    runs-on: windows-latest  # Use a Windows runner to run PowerShell scripts

    steps:
      # Checkout the repository code
      - name: Checkout code
        uses: actions/checkout@v3

      # Set up AWS CLI and PowerShell modules
      - name: Set up AWS CLI and PowerShell modules
        run: |
          # Install AWS CLI
          Invoke-WebRequest https://awscli.amazonaws.com/AWSCLIV2/latest/windows/awscliv2.msi -OutFile awscliv2.msi
          Start-Process msiexec.exe -ArgumentList '/i', 'awscliv2.msi', '/quiet', '/norestart' -Wait
          Remove-Item -Force awscliv2.msi

          # Install the AWS PowerShell module
          Install-Module -Name AWSPowerShell -Force -Scope CurrentUser

      # Configure AWS credentials
      - name: Set up AWS credentials
        run: |
          aws configure set aws_access_key_id ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws configure set aws_secret_access_key ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws configure set region ${{ secrets.AWS_REGION }}

      # Install Pester module
      - name: Install Pester module
        run: |
          Install-Module -Name Pester -Force -Scope CurrentUser

      # Run the Pester tests
      - name: Run Pester Tests
        run: |
          # Run the Pester tests for AWS S3
          Invoke-Pester -Path ./tests/AwsS3.Tests.ps1
