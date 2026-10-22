FROM --platform=linux/amd64 ubuntu:22.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    libbamtools-dev \
    libdivsufsort-dev \
    libjemalloc-dev \
    libprotobuf-dev \
    libsparsehash-dev \
    libsdsl-dev \
    pkg-config \
    protobuf-compiler \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src
COPY . .
RUN make bin/GraphAligner

ENTRYPOINT ["/src/bin/GraphAligner"]
