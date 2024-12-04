# AWS Infrastructure with CloudFront, S3, and WAF

[Previous content remains the same until Troubleshooting section, then adds:]

## Troubleshooting

Common issues and solutions:

1. **CloudFront 403 Errors**:
   - Check S3 bucket policy
   - Verify OAC configuration
   - Ensure WAF rules aren't blocking legitimate traffic
   - Verify function associations are correct

2. **SSL Certificate Issues**:
   - Ensure DNS validation records exist
   - Verify certificate region (must be us-east-1)
   - Check certificate renewal status
   - Confirm domain ownership

3. **S3 Access Issues**:
   - Check bucket policy
   - Verify CloudFront distribution settings
   - Confirm IAM roles and permissions
   - Check S3 bucket versioning status

4. **WAF Blocking Legitimate Traffic**:
   - Review rate limiting thresholds
   - Check WAF logs for false positives
   - Verify IP reputation lists
   - Adjust rule group settings

## Development Workflow

1. **Local Development**:
```bash
# Clone repository
git clone https://github.com/yourusername/yourrepo.git

# Install required tools
brew install terraform
brew install aws-cli

# Configure AWS credentials
aws configure

# Initialize Terraform workspace
terraform init
```

2. **Testing Changes**:
```bash
# Validate Terraform configurations
terraform validate

# Check formatting
terraform fmt

# Review planned changes
terraform plan
```

3. **CI/CD Integration**:
- GitHub Actions workflow examples
- Deployment validation steps
- Rollback procedures

## Infrastructure Updates

### Breaking Changes

The following changes require careful consideration:
1. S3 bucket name changes
2. CloudFront distribution updates
3. WAF rule modifications
4. Route53 record changes

### Update Procedures

1. **Terraform State Management**:
```bash
# Backup Terraform state
terraform state pull > backup.tfstate

# Import existing resources
terraform import aws_cloudfront_distribution.s3_distribution DISTRIBUTION_ID
```

2. **Emergency Rollback**:
```bash
# Revert to previous state
terraform plan -target=aws_cloudfront_distribution.s3_distribution -out=rollback.plan
terraform apply rollback.plan
```

## Monitoring and Alerts

### CloudWatch Alarms

1. **Error Rate Monitoring**:
```hcl
resource "aws_cloudwatch_metric_alarm" "error_rate" {
  alarm_name = "high-error-rate"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods = "2"
  metric_name = "5xxErrorRate"
  namespace = "AWS/CloudFront"
  period = "300"
  statistic = "Average"
  threshold = "5"
  alarm_description = "This metric monitors error rates"
  alarm_actions = [aws_sns_topic.alerts.arn]
}
```

2. **Cost Monitoring**:
- Budget alerts configuration
- Resource utilization tracking
- Anomaly detection

### Logging

1. **Log Analysis**:
- CloudWatch Logs Insights queries
- Access pattern analysis
- Security event monitoring

2. **Retention Policies**:
- Log rotation settings
- Archival procedures
- Compliance requirements

## Disaster Recovery

### Backup Procedures

1. **S3 Data**:
- Cross-region replication
- Versioning configuration
- Backup retention policies

2. **Infrastructure Configuration**:
- Terraform state backup
- Configuration version control
- Documentation maintenance

### Recovery Procedures

1. **Service Restoration**:
- Priority order for recovery
- Communication procedures
- Validation checkpoints

2. **Data Recovery**:
- S3 version restoration
- Cross-region failover
- Data integrity verification

## Performance Optimization

### CloudFront Settings

1. **Cache Optimization**:
- Cache behavior tuning
- Origin response optimization
- Compression settings

2. **Origin Settings**:
- Keep-alive timeout
- Origin timeout
- Origin response timeout

### S3 Performance

1. **Access Patterns**:
- Prefix optimization
- Partitioning strategy
- Request rate management

## Compliance and Security

### Audit Procedures

1. **Regular Audits**:
- Security group review
- IAM permission audit
- SSL certificate monitoring
- WAF rule validation

2. **Compliance Checks**:
- Resource tagging compliance
- Encryption verification
- Access logging validation

### Security Procedures

1. **Incident Response**:
- Security event identification
- Response procedures
- Escalation matrix
- Post-incident review

## Support and Maintenance

### Regular Maintenance

1. **Weekly Tasks**:
- Log review
- Performance monitoring
- Security updates

2. **Monthly Tasks**:
- Infrastructure cost review
- Resource optimization
- Backup verification

### Contact Information

For support:
- Technical Issues: devops@example.com
- Security Concerns: security@example.com
- Emergency Contact: oncall@example.com

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Changelog

### [1.0.0] - 2024-01-01
- Initial release
- Basic infrastructure setup

### [1.1.0] - 2024-02-01
- Added WAF configuration
- Improved logging
- Enhanced security features