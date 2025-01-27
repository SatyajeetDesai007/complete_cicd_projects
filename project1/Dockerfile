# Use an official Python runtime as the base image
FROM python:3.12-slim

# Set the working directory inside the container
WORKDIR /app

# Step 3: Copy the current directory contents into the container at /app
COPY . /app

# Install dependencies from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Step 5: Expose port 5000 to access the app
EXPOSE 5000

# Step 6: Set the command to run the Flask app
CMD ["python", "app.py"]
