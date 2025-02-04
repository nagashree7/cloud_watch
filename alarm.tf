resource "aws_cloudwatch_metric_alarm" "alarms12"{

  alarm_name          = "demo-alarm"
  alarm_description   = "monitors ec2 cpu utilisation"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  namespace   = "AWS/EC2"
  metric_name = "CPUUtilization"
  threshold           = 85
  period              = 120
  unit                = "Count"

  
  statistic   = "Average"
  treat_missing_data = "breaching"
  dimensions = {
    InstanceId = aws_instance.vm.id
  }

  alarm_actions = ["arn:aws:automate:us-east-1:ec2:stop"]
}
resource "aws_sns_topic" "snss12" {
  name = "CloudWatchAlarms"
}
resource "aws_sns_topic_subscription" "snss12" {
  topic_arn = aws_sns_topic.snss12.arn
  protocol = "email"
  endpoint = "nagashree.nagashree@kyndryl.com"
}
/*resource "aws_iam_policy" "sns_publish_policy" {
  name        = "sns-publish-policy"
  description = "Policy to allow SNS publish"
  
  # Define the permissions in the policy
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sns:Publish",
        Effect = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "example_role" {
  name = "example-role"

  # Attach the policy to the IAM role
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"  # Replace with the appropriate service
        }
      }
    ]
  })
}

# Attach the sns-publish-policy to the IAM role
resource "aws_iam_policy_attachment" "example_attachment" {
  policy_arn = aws_iam_policy.sns_publish_policy.arn
  roles      = [aws_iam_role.example_role.name]
}*/

