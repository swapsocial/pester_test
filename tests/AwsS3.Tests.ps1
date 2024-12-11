# Load AWS PowerShell Module
Import-Module AWSPowerShell

# Define the S3 Bucket name you want to test
$bucketName = "northstar-terraform-resources"  # Change this to your S3 bucket name

Describe "AWS S3 Bucket Tests" {
    It "Should verify the bucket exists" {
        $bucket = Get-S3Bucket -BucketName $bucketName -ErrorAction SilentlyContinue
        $bucket | Should -Not -BeNullOrEmpty
    }

    It "Should check if the bucket is publicly accessible" {
        # You can implement additional checks, such as inspecting the bucket's permissions
        $acl = Get-S3BucketAcl -BucketName $bucketName
        $acl.Grants | Should -Not -BeNullOrEmpty
    }
}
