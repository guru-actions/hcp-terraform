# HCP Terraform Runner Action

A composite CloudBees action for executing Terraform operations via HCP Terraform.

## Purpose

This action provides a unified interface for running Terraform operations (plan, apply, drift detection) through HCP Terraform. It supports both stub mode for testing/demos and live mode for real infrastructure operations.

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `environment` | Target environment (e.g., dev, prod) | Yes | - |
| `operation` | Terraform operation: `plan`, `apply`, or `drift` | Yes | - |
| `workspace` | HCP Terraform workspace name | Yes | - |
| `stub_mode` | Run in stub mode (true) or live mode (false) | No | `true` |

## Outputs

| Output | Description |
|--------|-------------|
| `run_id` | HCP Terraform run ID |
| `run_url` | URL to the HCP Terraform run |
| `status` | Run status: `planned`, `applied`, or `drifted` |
| `summary_json` | Terraform plan summary as JSON string |

## Modes

### Stub Mode (Default)

When `stub_mode: true`, the action:
- Generates a realistic run ID (timestamp-based UUID)
- Returns a mock HCP Terraform URL
- Sets status based on operation type
- Returns a sample Terraform plan summary JSON

**Use stub mode for:**
- Testing workflows
- Demos and presentations
- Development without HCP Terraform access

### Live Mode (Not Yet Implemented)

When `stub_mode: false`, the action will:
- Authenticate with HCP Terraform API
- Execute real Terraform operations
- Return actual run results

**Status:** Live mode is a placeholder. Attempting to use it will result in an error.

## Usage Example

```yaml
- name: Run Terraform Plan
  uses: guru-actions/hcp-terraform@v0.1
  with:
    environment: dev
    operation: plan
    workspace: hcp-dev
    stub_mode: true
```

## Future Roadmap

- Implement HCP Terraform API integration
- Add authentication (API token support)
- Support for variables and configuration
- Enhanced drift detection with remediation workflows
- Integration with CloudBees evidence and compliance features
