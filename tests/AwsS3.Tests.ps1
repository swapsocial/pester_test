Import-Module AWSPowerShell

Describe 'AWS Resource Tests' {

    # Initialize an array to store results
    $results = @()

    Context 'S3 Bucket Tests' {

        It 'Should check if the S3 bucket exists' {
            $bucketName = 'northstar-terraform-resources'
            $bucket = Get-S3Bucket -BucketName $bucketName -ErrorAction SilentlyContinue
            
            # Store the result
            $results += [PSCustomObject]@{
                Test = 'S3 Bucket Exists'
                Result = if ($bucket) { 'Pass' } else { 'Fail' }
                Details = if ($bucket) { 'Bucket exists' } else { 'Bucket does not exist' }
            }
        }

        It 'Should check if S3 bucket versioning is enabled' {
            $bucketName = 'northstar-terraform-resources'
            $versioning = Get-S3BucketVersioning -BucketName $bucketName -ErrorAction SilentlyContinue

            # Store the result
            $results += [PSCustomObject]@{
                Test = 'S3 Bucket Versioning Enabled'
                Result = if ($versioning.Status -eq 'Enabled') { 'Pass' } else { 'Fail' }
                Details = if ($versioning.Status -eq 'Enabled') { 'Versioning is enabled' } else { 'Versioning is not enabled' }
            }
        }
    }

    Context 'EKS Cluster Tests' {

        It 'Should check if the EKS cluster is active' {
            $clusterName = 'dots-ns-eks_cluster'
            $cluster = Get-EksCluster -Name $clusterName -ErrorAction SilentlyContinue

            # Store the result
            $results += [PSCustomObject]@{
                Test = 'EKS Cluster Status'
                Result = if ($cluster.Status -eq 'ACTIVE') { 'Pass' } else { 'Fail' }
                Details = if ($cluster.Status -eq 'ACTIVE') { 'Cluster is active' } else { 'Cluster is not active' }
            }
        }

        It 'Should check if the EKS cluster has the correct IAM role' {
            $clusterName = 'dots-ns-eks_cluster'
            $cluster = Get-EksCluster -Name $clusterName -ErrorAction SilentlyContinue
            
            # Store the result
            $expectedRoleArn = 'arn:aws:iam::your-account-id:role/your-cluster-role'  # Update with the correct ARN
            $results += [PSCustomObject]@{
                Test = 'EKS Cluster IAM Role'
                Result = if ($cluster.RoleArn -eq $expectedRoleArn) { 'Pass' } else { 'Fail' }
                Details = if ($cluster.RoleArn -eq $expectedRoleArn) { 'IAM role is correct' } else { 'IAM role is incorrect' }
            }
        }
    }

    Context 'Bastion Host Tests' {

        It 'Should check if the Bastion host exists' {
            $bastionInstanceId = 'i-0b6cbd52f96e3d465' 
            $bastionHost = Get-EC2Instance -InstanceId $bastionInstanceId -ErrorAction SilentlyContinue
            
            # Store the result
            $results += [PSCustomObject]@{
                Test = 'Bastion Host Exists'
                Result = if ($bastionHost) { 'Pass' } else { 'Fail' }
                Details = if ($bastionHost) { 'Bastion host exists' } else { 'Bastion host does not exist' }
            }
        }

        It 'Should check if the Bastion host is running' {
            $bastionInstanceId = 'i-0b6cbd52f96e3d465'  # Replace with your Bastion host ID
            $bastionHost = Get-EC2Instance -InstanceId $bastionInstanceId -ErrorAction SilentlyContinue
            
            # Store the result
            $results += [PSCustomObject]@{
                Test = 'Bastion Host Running'
                Result = if ($bastionHost.State.Name -eq 'running') { 'Pass' } else { 'Fail' }
                Details = if ($bastionHost.State.Name -eq 'running') { 'Bastion host is running' } else { 'Bastion host is not running' }
            }
        }
    }
    # Print the results in a formatted table
    $results | Format-Table -AutoSize
}
