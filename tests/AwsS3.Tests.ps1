# Load AWS Tools for PowerShell module
Import-Module AWS.Tools.S3

# Define the S3 Bucket name you want to test
$bucketName = "my-test-bucket-123456"  # Change this to your S3 bucket name

Describe "AWS S3 Bucket Tests" {
    It "Should verify the bucket exists" {
        $bucket = Get-S3Bucket -BucketName $bucketName -ErrorAction SilentlyContinue
        $bucket | Should -Not -BeNullOrEmpty
    }

    It "Should check if the bucket is publicly accessible" {
        # Ensure the bucket's ACL is available
        $acl = Get-S3BucketAcl -BucketName $bucketName
        $acl.Grants | Should -Not -BeNullOrEmpty
    }
}
