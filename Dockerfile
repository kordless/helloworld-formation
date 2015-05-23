FROM phusion/baseimage
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y

ADD server.py /giant/
RUN echo Hello from Giant Swarm. \\o/ > /giant/index.html

WORKDIR /giant/

ENTRYPOINT ["python3"]
CMD ["server.py"]

EXPOSE 8000