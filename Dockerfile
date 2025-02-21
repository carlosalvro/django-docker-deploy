# setting up base image
FROM python:3.13-slim AS builder

# prevents python buffering stdout and stderr

ENV PIP_DISABLE_PIP_VERSION_CHECK=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# sets up the working directory for any RUN, CMD, ENTRYPOINT, COPY and ADD instructions 
RUN mkdir /app

WORKDIR /app

# install dependencies
RUN pip install --upgrade pip
COPY ./requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

FROM python:3.13-slim

RUN useradd -m -r appuser && \
  mkdir /app && \
  chown -R appuser /app

# Copy the Python dependencies from the builder stage
COPY --from=builder /usr/local/lib/python3.13/site-packages/ /usr/local/lib/python3.13/site-packages/
COPY --from=builder /usr/local/bin/ /usr/local/bin/

# Set the working directory
WORKDIR /app

# Copy application code
COPY --chown=appuser:appuser . .

# Set environment variables to optimize Python
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1 

# Switch to non-root user
USER appuser

# Expose the application port
EXPOSE 8000 

# Make entry file executable
RUN chmod +x  /app/start.sh

# Start the application using Gunicorn
CMD ["/app/start.sh"]