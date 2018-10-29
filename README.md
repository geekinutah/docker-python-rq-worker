# docker-python-rq-worker
A docker build for rq workers
*RQ is a simple library for creating background jobs and processing them.*

* What is RQ?

  RQ (Redis Queue) is a simple Python library for queueing jobs and
  processing them in the background with workers. It is backed by Redis and
  it is designed to have a low barrier to entry. It can be integrated in your
  web stack easily.

  For more info: http://python-rq.org/

* What language is RQ written in?

  Python (v3.x)

* How do I create a Docker container?

  ```
     docker build -t rq-worker .
     docker run -d --hostname redis --name redis redis
     docker run -d --link redis:redis --name rq_worker -e "REDIS_HOST=redis" rq-worker
  ```

  You may need to import some python code for rq_worker to do the job. You can
  do this by mounting a volume.

  ```
    docker run -d --link redis:redis --name rq_worker
    -v <some_path>:/pythonimports rq-worker
  ```

* Environment Variables

  REDIS_HOST default is redis, the hostname that rq worker will connect to.

  REDIS_PORT default is 6379, the port that rq worker will use.

  REDIS_DB   default is 0, change this to use a different redis db.

  RQ_QUEUE   default is actually default, you can use space seperated names.

  LOG_LEVEL  default is DEBUG

  PIP_PACKAGES default is none, put comma seperated lists of packages that
  should be installed here. For example 'foopackage,otherpackage'

* Volumes

  There is a /pythonimports volume which is added to the rq runtime python
  path.
