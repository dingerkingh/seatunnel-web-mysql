Apache SeaTunnel Web Docker Setup
=================================

This repository provides a Dockerized setup for running the **Apache SeaTunnel Web**, including MySQL and SeaTunnel Master services, with shared connectors for seamless integration. Follow the steps below to build, configure, and run the setup.

Table of Contents
-----------------

-   [Prerequisites](#prerequisites)
-   [Setup Overview](#setup-overview)
-   [Installation Steps](#installation-steps)
-   [Configuration](#configuration)
-   [Running the Services](#running-the-services)
-   [Troubleshooting](#troubleshooting)
-   [Contributing](#contributing)
-   [License](#license)

* * * * *

Prerequisites
-------------

Make sure you have the following installed:

-   [Docker](https://www.docker.com/)
-   Docker Compose

* * * * *

Setup Overview
--------------

The Docker setup includes:

1.  **SeaTunnel Web**: The web UI for managing SeaTunnel pipelines.
2.  **SeaTunnel Master**: Manages pipeline execution.
3.  **MySQL**: Backend database for SeaTunnel Web.
4.  **Shared Connectors**: Volume-based integration for connectors.

### Services

| Service | Port | Description |
| --- | --- | --- |
| SeaTunnel Web | 8801 | Web UI |
| SeaTunnel Master | 5801 | SeaTunnel cluster master node |
| MySQL | 3306 | MySQL database for SeaTunnel Web |

* * * * *

Installation Steps
------------------

1.  **Clone the Repository**:

    bash

    Copy code

    `git clone https://github.com/yourusername/seatunnel-web-docker.git
    cd seatunnel-web-docker`

2.  **Build Docker Images**:

    Build the required images, ensuring no cache is used to avoid stale builds:

    bash

    Copy code

    `docker-compose build --no-cache`

3.  **Start the Services**:

    Bring up the services with Docker Compose:

    bash

    Copy code

    `docker-compose up`

* * * * *

Configuration
-------------

### Environment Variables

Adjust the following environment variables in the `docker-compose.yml` file as needed:

#### **SeaTunnel Web**

| Variable | Default Value | Description |
| --- | --- | --- |
| `SEATUNNEL_MASTER_HOST` | `172.16.0.2` | SeaTunnel Master IP address |
| `MYSQL_HOST` | `172.16.0.200` | MySQL database host |
| `MYSQL_PORT` | `3306` | MySQL database port |
| `MYSQL_DB` | `seatunnel` | Database name |
| `MYSQL_USER` | `root` | MySQL username |
| `MYSQL_PASSWORD` | `123456` | MySQL password |

* * * * *

Running the Services
--------------------

1.  **Access SeaTunnel Web**:

    -   Open a browser and navigate to: [http://localhost:8080](http://localhost:8080/).
2.  **Connectors**:

    -   Shared connectors are automatically copied from the `shared-connectors` volume to the `/app/libs` directory on startup.

* * * * *

Troubleshooting
---------------

### Common Issues

#### **SeaTunnel Web Starts Without Shared Connectors**

Ensure the `shared-connectors` volume is correctly mounted and populated:

bash

Copy code

`docker exec -it seatunnel_web ls /shared-connectors`

#### **MySQL Connection Issues**

Verify the `MYSQL_HOST` and `MYSQL_PORT` variables in the `docker-compose.yml` file match the MySQL container's IP and port.

#### **Cache Issues**

If updates are not reflected, clear Docker caches:

bash

Copy code

`docker-compose down
docker-compose build --no-cache`

#### **File Permissions**

Ensure the `entrypoint.sh` script is executable:

bash

Copy code

`chmod +x seatunnel-web/entrypoint.sh`

* * * * *

Contributing
------------

Contributions are welcome! Please fork the repository, make your changes, and submit a pull request.

* * * * *

License
-------

This project is licensed under the Apache 2.0 License. See the LICENSE file for details.
