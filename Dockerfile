FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

RUN apt-get update && \
    apt-get install -y \
        build-essential \
        cmake \
        libgmp-dev \
        libsodium-dev \
        nasm \
        curl \
        m4 \
        git \
        wget \
        unzip \
        pkg-config \
        nlohmann-json3-dev \
        libssl-dev \
        llvm-dev \
        libclang-dev \
        clang \
        libclang-common-15-dev \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH="/usr/local/cargo/bin:${PATH}"

WORKDIR /opt
RUN git clone https://github.com/worm-privacy/miner.git
WORKDIR /opt/miner
RUN make download_params && \
    cargo install --path .

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
