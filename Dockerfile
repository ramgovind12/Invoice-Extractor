
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file first to leverage Docker caching
COPY requirements.txt .

# Install pip and create a virtual environment
RUN pip install --upgrade pip && \
    pip install virtualenv && \
    virtualenv venv && \
    ./venv/bin/pip install -r requirements.txt  # Install dependencies

# Copy the rest of the application files
COPY . /app

# Expose the port Streamlit will run on
EXPOSE 8501

# Set environment variables for the virtual environment
ENV PATH="/app/venv/bin:$PATH"

# Command to run the Streamlit app
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]