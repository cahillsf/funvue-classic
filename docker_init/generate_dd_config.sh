cat <<EOF
{
  "environment": "dev",
  "service": "nginx",
  "operation_name_override": "nginx.handle",
  "agent_host": "${DD_AGENT_HOST}",
  "agent_port": 8126
}
EOF