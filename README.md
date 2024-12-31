# Flask Application with CI/CD on AWS ECS 🚀

This repository contains a Flask application deployed on AWS ECS (Elastic Container Service) using Fargate. The application is built with Docker and deployed using a CI/CD pipeline that leverages Jenkins (or GitHub Actions). This README provides steps to set up, deploy, and access the application.

---

## 1. **Steps to Set Up and Deploy the Application** 🛠️

### **Prerequisites** ✅
Before setting up the application, ensure you have the following:

<ul>
  <li><strong>AWS Account:</strong> Ensure you have an active AWS account. 🌐</li>
  <li><strong>AWS CLI:</strong> Install and configure the AWS CLI on your local machine with the appropriate access keys. 🔑</li>
  <li><strong>Docker:</strong> Install Docker to build and push container images. 🐳</li>
  <li><strong>Terraform:</strong> Ensure Terraform is installed to provision cloud infrastructure. 🌱</li>
  <li><strong>Jenkins (or GitHub Actions):</strong> Set up a Jenkins server or use GitHub Actions for the CI/CD pipeline. 🧑‍💻</li>
</ul>

### **Setup Instructions** 📋
Follow the steps below to set up the application:

<ol>
  <li><strong>Clone the Repository:</strong>
    <pre><code>git clone <repository-link></code></pre>
    <pre><code>cd <repository-name></code></pre>
  </li>
  <li><strong>Set up AWS Resources using Terraform:</strong>
    <p>Ensure that your AWS credentials are configured by running:</p>
    <pre><code>aws configure</code></pre>
    <p>Initialize Terraform:</p>
    <pre><code>terraform init</code></pre>
    <p>Apply the Terraform configuration to create the required cloud resources:</p>
    <pre><code>terraform apply</code></pre>
    <p>This will create the VPC, subnets, ECS cluster, security group, and other necessary resources.</p>
  </li>


  <img src="images/aram simple architecture.png" alt="CLOUD ARCHITECTURE" width="600"/>

  <li><strong>Set up CI/CD Pipeline (Jenkins):</strong>
    <ul>
      <li><strong>Jenkins:</strong> Set up a Jenkins pipeline to automate the build and deployment. ⚙️</li>
    </ul>
  </li>


  <li><strong>Deploy the Application:</strong>
    <p>Once the pipeline runs, it will deploy the Flask application to AWS ECS using the Fargate launch type. 🚢</p>
  </li>
</ol>

<img src="images/Screenshot 2024-12-30 at 10.54.47 PM.png" alt="PIPELINE" width="600"/>

---

## 2. **Cloud Resources Used** ☁️

### **VPC and Subnets:**
- **VPC (Virtual Private Cloud):** A custom VPC with the CIDR block `10.0.0.0/16` is created to ensure that the application is isolated in its own network.
- **Public Subnets:**
  - `10.0.1.0/24` (in Availability Zone `ap-south-1a`)
  - `10.0.3.0/24` (in Availability Zone `ap-south-1b`)

### **Security Group:**
- A security group is created to allow inbound HTTP traffic on port 5000 (for the Flask application) from any IP address (`0.0.0.0/0`).

### **ECS (Elastic Container Service):**
- **ECS Cluster:** `ARAM-app-cluster` is the ECS cluster used to run the application tasks.
- **ECS Task Definition:** `aram-task`, which runs the Flask application as a container.
  - **CPU:** 256 units
  - **Memory:** 512 MiB
  - **Container Port:** 5000
- **ECS Service:** `aram-service`, which ensures that the desired number of task instances are running.

### **Load Balancer:**
- **ALB (Application Load Balancer):**
  - **Listener:** Port 80, which is used to forward HTTP requests.
  - **Target Group:** Routes traffic to ECS tasks running on port 5000. The ALB handles the routing to the ECS tasks.

### **IAM Role:**
- **ecsTaskExecutionRole:** A role with permissions to pull images from Docker Hub or AWS ECR, push logs to CloudWatch, and interact with ECS.

---

## 3. **Instructions to Access the Deployed Application** 🔑

### **Accessing the Flask Application:**
Once the application is deployed, it will be accessible through the **Application Load Balancer (ALB)**.

### **Steps to Access the Deployed Application:**
1. **Find the ALB DNS Name:**
    <ul>
      <li>Log into the AWS Management Console.</li>
      <li>Navigate to <strong>EC2</strong> → <strong>Load Balancers</strong>.</li>
      <li>Find the ALB named <code>ecs-lb</code> and copy the <strong>DNS name</strong>.</li>
    </ul>
   
2. **Access the Application:**
    <p>Open a web browser and paste the ALB DNS name into the address bar:</p>
    <pre><code>http://<ALB-DNS-Name></code></pre>
    <p>This will route you to the Flask application running on ECS. 🌐</p>

---

## 4. **Optional: Debugging and Logs** 🐞

### **Viewing Logs in CloudWatch:**
- **CloudWatch Logs:** If there are any issues with the application, logs can be viewed in CloudWatch under the log group for the ECS service.
    <ul>
      <li>Navigate to <strong>CloudWatch</strong> → <strong>Logs</strong>.</li>
      <li>Look for log streams associated with your ECS service and container logs.</li>
    </ul>

---

## 5. **Contributing** 💻

Feel free to fork this repository and contribute by submitting pull requests. Ensure you follow the best practices for CI/CD and cloud security.

---

## 6. **License** 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 7. **Contact Information** 📬

For any questions or feedback, please reach out to:
<ul>
  <li><strong>Email:</strong> pandian0114@example.com</li>
  <li><strong>LinkedIn:</strong> <a href="www.linkedin.com/in/pandian0114">Dhinesh Pandian</a></li>
</ul>
