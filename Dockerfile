FROM --platform=linux/amd64 ubuntu:22.04 AS build

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

FROM --platform=linux/amd64 ubuntu:22.04 AS runtime

RUN apt-get update && apt-get install -y --no-install-recommends \
    libjemalloc2 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build /src/bin/GraphAligner /usr/local/bin/GraphAligner

ENTRYPOINT ["GraphAligner"]
