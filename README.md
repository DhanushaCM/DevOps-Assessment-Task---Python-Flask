# DevOps-Assessment-Task---Python-Flask
simple python REST app.

Task:  Creating a Docker container for a basic Python Flask application, designed to function as a RESTful service 

Description: Creating a Docker container for a basic Python Flask application as a RESTful service involves encapsulating the Flask code and dependencies within a self-c             ontained environment. First we have to define a Dockerfile with instructions for setting up the environment, installing the required packages, and copying t             he Flask application into the container. After building the Docker image, run it as a container, specifying port mapping to expose  RESTful service. This co             ntainerization simplifies deployment and ensures that the Flask application runs consistently across different environments.

Execution Steps: 
    
For doing the task I have used AWS Ec2 instance. Before starting install git, docker.       
Step 1: Creating a directory to work. Using mkdir Devops-task can create a directory. Copy the provided application code written in python, requirements.txt                      file to the working directory.
Step 2: Create a dockerfile for creating a container for the application.
                     
# Use base image as python
 FROM python:latest
# Set the working directory inside the container
WORKDIR /app
# Copy the requirements file into the container
COPY requirements.txt /app
# Install dependencies mentioned in requirements.txt file
RUN pip install -r requirements.txt
# Copy the application code into the container
COPY . /app
# Expose the port the app runs on
EXPOSE 5000
# Define the command to run the application
CMD python app.py

Step 3 :Create a docker-compose.yaml file
        version: '3'
services:
  app:
    build: .
    ports:
      - "5000:5000"
    depends_on:
      - db
      - redis
    environment:
      APP_HOST: 127.0.0.1
      DATABASE_URI: mysql+pymysql://DBuser:123456@db:3306/DTapp
      APP_PORT: 5000
      REDIS_HOST: redis
      REDIS_PORT: 6379
      DATABASE_URL: mysql://DBuser:123456@db:3306/DTapp
      REDIS_URL: redis://redis:6379
    restart: always
    networks:
      - task-network
  db:
    image: mysql:5.7
    environment:
      MYSQL_ROOT_PASSWORD: DTapp123456
      MYSQL_DATABASE: DTapp
      MYSQL_USER: DBuser
      MYSQL_PASSWORD: 123456
    networks:
      - task-network
  redis:
    image: redis:latest
    ports:
       - '6739:6739'
    networks:
       - task-network
networks:
  task-network:
In this docker-compose file, three services are created. One for application, One for database, One for redis.

For application service, name is app. The Dockerfile created earlier is build to docker image then to container and the port is 5000. The app service depends on db and redis service. The environment variables are given which where rquired to run the application. 
For database service, name is db. The database used here is mysql, so the image is pulled from the repository. The credentials are provided.
For redis, the image is pulled from repository and the port is 6739.

To run the docker-compose file, used the command docker-compose up -d. Then the all the three containers are created, started and start to run.


Testing

Basic testing involves verifying the services and containers are configured and working correctly.
Checking the status of  containers and ensure they are running using the below command
docker-compose ps
Accessing the Flask application in a web browser.
Testing the endpoints of the application.
Testing the network connection between the three containers are configured correctly.
Verifying the database are congigured correctly. 
Run some sample requests in the web application to confirm it's communicating with the database and Redis. Like if application writes to the database and stores data in Redis, perform these operations and check that the data is stored correctly. Here, when a palindrome is given then if it is a palindrome it is moved to the database atherwise not. checking whether it is working properly.
Checking if Redis server is correctly configured.
Inspecting the logs of the containers to check for any errors or issues.For that used docker-compose logs to view the logs for all containers managed by Docker Compose.

Issues faced

After completing the application, tried to access the application using http://127.0.0.1:5000 but its was not accessible. But while checking the docker logs, container logs it is showing that the application is running on the same IP. Done numourous troubleshoot bt cann't find the solution.But will be able to findout by doing more troubleshooting but the application is accesible using the aws instance IP. And all the application end points are getting.

The other issue was faced a problem in network of the containers since the app container and redis are on different network. After troubleshooting, change all the containers to the comman network. So the issue is solved.

I regret to inform you that I encountered challenges in implementing the CI/CD workflow for deploying the application. Despite my best efforts, I faced technical complexities that prevented me from completing the task.
