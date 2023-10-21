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
#EXPOSE 5000
# Define the command to run the application
CMD python app.py

