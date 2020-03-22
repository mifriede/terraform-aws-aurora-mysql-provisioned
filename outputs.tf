output "cluster_arn" {
  value       = aws_rds_cluster.this.arn
  description = "ARN of cluster"
}
output "cluster_id" {
  value       = aws_rds_cluster.this.id
  description = "The RDS Cluster Identifier"
}
output "cluster_resource_id" {
  value       = aws_rds_cluster.this.cluster_resource_id
  description = "The RDS Cluster Resource ID"
}
output "cluster_members" {
  value       = aws_rds_cluster.this.cluster_members
  description = "List of RDS Instances that are a part of this cluster"
}
output "endpoint" {
  value       = aws_rds_cluster.this.endpoint
  description = "The DNS address of the Aurora Cluster"
}
output "reader_endpoint" {
  value       = aws_rds_cluster.this.reader_endpoint
  description = "A read-only endpoint for the Aurora cluster"
}
output "instances_arn" {
  value       = aws_rds_cluster_instance.this[*].arn
  description = "ARN of cluster instances"
}
output "instances_id" {
  value       = aws_rds_cluster_instance.this[*].id
  description = "The Instances identifier"
}
output "instances_endpoint" {
  value       = aws_rds_cluster_instance.this[*].endpoint
  description = "The DNS address for this instances"
}
output "instances_dbi_resource_id" {
  value       = aws_rds_cluster_instance.this[*].dbi_resource_id
  description = "The region-unique, immutable identifier for the DB instances"
}
