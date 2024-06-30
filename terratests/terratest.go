package test

import (
    "fmt"
    "testing"

    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/stretchr/testify/assert"
)

func TestTerraformEks(t *testing.T) {
    t.Parallel()

    terraformOptions := &terraform.Options{
        TerraformDir: "../tf",
        Vars: map[string]interface{}{
            // Add any variables you want to override here
        },
    }

    defer terraform.Destroy(t, terraformOptions)

    // Run terraform init and terraform apply. Fail the test if there are any errors.
    terraform.InitAndApply(t, terraformOptions)

    // Run terraform output to get the value of an output variable
    clusterName := terraform.Output(t, terraformOptions, "cluster_name")

    // Verify that the cluster name is as expected
    assert.NotEmpty(t, clusterName)
    fmt.Printf("Cluster name is: %s\n", clusterName)
}