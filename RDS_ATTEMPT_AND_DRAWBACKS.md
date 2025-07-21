# 🛑 Drawbacks & Lessons Learned

## Attempted AWS RDS Integration

**I attempted to migrate the backend database from a local MySQL instance to AWS RDS to provide a cloud-hosted, persistent, and employer-accessible data source.**
This would have allowed reviewers to experience the application with up-to-date, pre-populated stock data and without any local DB setup.

### Challenges Encountered

- **Cloud Latency & Throughput:**  
  AWS RDS introduces network latency and stricter resource limits compared to local MySQL. My application’s price update logic, which performs many rapid, concurrent queries, worked well locally but overwhelmed the RDS instance, causing timeouts and connection failures.
- **Connection Pooling:**  
  The default HikariCP/JDBC connection pool settings were not tuned for cloud environments, leading to dropped or stalled connections under load.
- **Batch Processing:**  
  The price update orchestrator was designed for low-latency local DBs and did not batch or throttle queries, which is essential for cloud DBs.
- **Resource Constraints:**  
  Entry-level RDS instances (e.g., db.t2.micro) have limited CPU, memory, and max connections, which are quickly exhausted by high-frequency operations.
- **Complex Debugging:**  
  Diagnosing cloud DB issues is more complex due to the interplay of AWS networking, security groups, VPCs, and instance health.

### Result

- **After extensive debugging and optimization attempts, I determined that the current architecture and query patterns are not well-suited for a cloud-hosted RDS instance without significant refactoring (batching, async processing, or RDS upgrades).**
- **For the best demo experience, the project defaults to a local MySQL database.**  
  All features work reliably and responsively in this configuration.

### What I Learned

- Cloud DBs require careful connection management, batching, and async processing.
- Localhost development can mask performance and scaling issues that only appear in production-like environments.
- It’s important to document and communicate these lessons to future maintainers and reviewers.

---

## Other Project Drawbacks & Limitations

- **No Production-Grade Cloud Deployment:**  
  The project is not currently deployed on a public cloud or behind a managed load balancer.
- **No Automated CI/CD:**  
  Builds and deployments are manual; no GitHub Actions or similar pipeline is set up.
- **Limited Test Coverage:**  
  While core flows are tested, there is no comprehensive automated test suite.
- **No Horizontal Scaling:**  
  The backend is designed as a monolith and does not support horizontal scaling out-of-the-box.
- **Sensitive Data in Config:**  
  For demo purposes, some credentials are present in `application.yml`. In production, these should be managed via environment variables or a secrets manager.
- **Kafka/Redis Assumptions:**  
  The app assumes Kafka and Redis are running locally or in Docker Compose; cloud or remote brokers would require config changes.

---

## Summary

> **I made a good-faith effort to migrate to AWS RDS and documented the technical and architectural challenges encountered. This process deepened my understanding of cloud-native best practices and the importance of scalable, resilient backend design.**
