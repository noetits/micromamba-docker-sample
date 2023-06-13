FROM mambaorg/micromamba:1.4.3

USER root
# packages list. The --no-install-recommends avoids installing recommended packages that are not necessary for a tiny docker image: https://phoenixnap.com/kb/docker-image-size
RUN	apt-get update && apt-get install --no-install-recommends -y \
    curl \
    # clean up apt cache to save space
    && rm -rf /var/lib/apt/lists/* \
USER mambauser
COPY --chown=$MAMBA_USER:$MAMBA_USER env.yaml /tmp/env.yaml
RUN micromamba install -y -n base -f /tmp/env.yaml && \
    micromamba clean --all --yes
CMD ["bash", "-c", "while true; do sleep 1; done"]