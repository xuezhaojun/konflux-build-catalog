# Minimal Dockerfile to make repository buildable for Konflux
# This is a basic container that does nothing but allows build processes to complete

FROM registry.access.redhat.com/ubi8/ubi-minimal:latest

# Set metadata
LABEL name="konflux-build-catalog" \
      description="Konflux Build Catalog - Pipeline definitions" \
      version="1.0.0"

# Create a non-root user for security
RUN microdnf install -y shadow-utils && \
    useradd -r -u 1001 -g root -s /sbin/nologin catalog-user && \
    microdnf clean all

# Copy pipeline files to demonstrate this is a pipeline catalog
COPY pipelines/ /pipelines/
COPY .tekton/ /.tekton/

# Switch to non-root user
USER 1001

# Set working directory
WORKDIR /pipelines

# Default command that does nothing but keeps container running if needed
CMD ["sleep", "infinity"]