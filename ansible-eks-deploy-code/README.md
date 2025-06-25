# README.md

## How to Run the Ansible Test Playbook

This repository contains an Ansible playbook (`test_playbook.yaml`) that validates your NGINX deployment and service on an AWS EKS cluster.

### Prerequisites

- Ansible installed on your machine.
- The `kubernetes.core` Ansible collection installed:
  ```sh
  ansible-galaxy collection install kubernetes.core
  ```
- Your Kubernetes config file (`~/.kube/config`) must be set up and point to your EKS cluster.

### Running the Playbook

1. Open a terminal and navigate to the directory containing `test_playbook.yaml`.
2. Run the following command:
   ```sh
   ansible-playbook test_playbook.yaml
   ```

### What Happens

- Ansible executes each task in the playbook.
- It checks for the existence of the kubeconfig file.
- It queries your EKS cluster for the NGINX deployment and service.
- It asserts that:
  - The deployment exists, has 2 replicas, and exposes port 80.
  - The service exists, is of type `LoadBalancer`, and exposes port 80.
- If all checks pass, the playbook completes successfully. If any check fails, Ansible reports an error.

---
```# README.md

## How to Run the Ansible Test Playbook

This repository contains an Ansible playbook (`test_playbook.yaml`) that validates your NGINX deployment and service on an AWS EKS cluster.

### Prerequisites

- Ansible installed on your machine.
- The `kubernetes.core` Ansible collection installed:
  ```sh
  ansible-galaxy collection install kubernetes.core
  ```
- Your Kubernetes config file (`~/.kube/config`) must be set up and point to your EKS cluster.

### Running the Playbook

1. Open a terminal and navigate to the directory containing `test_playbook.yaml`.
2. Run the following command:
   ```sh
   ansible-playbook test_playbook.yaml
   ```

### What Happens

- Ansible executes each task in the playbook.
- It checks for the existence of the kubeconfig file.
- It queries your EKS cluster for the NGINX deployment and service.
- It asserts that:
  - The deployment exists, has 2 replicas, and exposes port 80.
  - The service exists, is of type `LoadBalancer`, and exposes port 80.
- If all checks pass, the playbook completes successfully. If any check fails, Ansible reports an error.