# frontend.py
frontend.py includes frontend.py.schema, which creates an instance template based on container_instance_template.py. This template is used to create a managed instance group and an autoscaler. The template also creates a network load balancer that has a forwarding rule with a single public IP address. It also creates:

A target pool that refers to the managed instance group.

A health check attached to the target pool.

# nodejs.py
nodejs.py includes nodejs.py.schema, which brings the frontend and backend templates together.

Note that the frontend is frontend.py.

The backend is /common/python/container_vm.py.

This is a VM running a Docker container with MySQL, so it doesn't require a custom template.

# Other files
/common/python/container_instance_template.py

/common/python/container_vm.py

/common/python/container_helper.py

