# Why?

Questions:
  * Why was HTTP/2 introduced
    - Data compression -> Make responses smaller so sites load faster
    - Asynchronous communication -> Send resources before they are explicitly requested
    - Better Pipelining
    - Fix head-of-line blocking issue of HTTP 1.1
    - Better multiplexing of connections over a single TCP connection
    - Request prioritization
  * What are the incompatibilities with HTTP/1
    - Headers are now compressed as well as the body
    - Chunked encoding (data streaming) is deprecated in favor of new mechanisms
    -
