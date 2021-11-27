FROM alpine:3.15

ENV PATH=$PATH:/root/.cargo/bin

WORKDIR /app

RUN apk add alpine-sdk --update

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain nightly-2021-11-17 &&\
    rustup target add wasm32-unknown-unknown --toolchain nightly-2021-11-17

COPY . .

RUN git submodule update --remote --recursive  &&\
    cargo test --no-run

CMD cargo test
