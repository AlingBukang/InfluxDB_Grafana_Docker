This project aims to help technical testers setup observability and monitoring solution locally for learning, exploring, and testing purposes. Docker Compose is used to simplify and speed up deployment of multiple containers.

# Why Telegraf, InfluxDB, Grafana 

The TIG stack - A powerful monitoring solution with great dashboards.


[InfluxDB](https://docs.influxdata.com/influxdb/v2.5/get-started/)
: an open-source time series database. It gets the metrics data that agents such as Telegraf collect and stores it as time series data


[Telegraf](https://docs.influxdata.com/influxdb/v2.5/telegraf-configs/) 
: a server-based agent that collects and sends aggregated metrics data and events from databases, systems, and IoT sensors to an storage system such as InfluxDB.
The most common metrics that Telegraf collects from machines are CPU utilization, memory (RAM) usage, disk (ROM) usage, and computer processors.


[Grafana](https://grafana.com/docs/grafana/latest/getting-started/get-started-grafana-influxdb/) 
: a data visualisation platform that pulls from a wide variety of different datasources, i.e. InfluxDB. It allows developers to create interactive graphs, charts, and dashboards using a connected data source. 


# Quick start

There are a few things you should know and install.
- [ ] Install Docker
- [ ] Clone this repo
- [ ] Install JMeter

**Launch the containers:**
> docker-compose up -d

The InfluxDB image contains some extra functionality to automatically bootstrap the system. This functionality is enabled by setting the DOCKER_INFLUXDB_INIT_MODE environment variable to the value `setup` when running the container. See `influxv2.env` for other env variables used to configure the setup logic.

After starting the container, you can use the web interface at http://localhost:8086/ to customise the Influx bucket.

**Test with JMeter:**

Use this sample JMeter script: `scripts\Jmeter_test.jmx`

# Grafana Setup
Configure InfluxDB data source for Grafana with the following settings:

**Query Language:** FLUX

**URL:** http://influxdb:8086

**InfluxDB Details:**
```
Organisation: Expert
Token: my-super-secret-auth-token
Bucket: jmeter_results
```

# Telegraf Setup
The Telegraf agent will collect CPU usage, memory (RAM) usage, disk usage, and computer processor utilization from the host machine.

I've included Telegarf here for local testing purposes only. The server agent should be installed, configured and launched on the SUT servers, i.e. applications and backend servers, to start collecting metrics.

Refer to the [official installation guide.](https://docs.influxdata.com/telegraf/v1.21/introduction/installation/?t=Windows)


# Dashboards

InfluxDB has some dashboard templates contributed by community builders that can be used to help get started quickly. There are various templates for different use cases.

To use JMeter dashboard template, for example, go to Settings-> Templates and enter this URL: 
[JMeter dashboard template](https://raw.githubusercontent.com/influxdata/community-templates/master/apache_jmeter/apache_jmeter.yml)  


![InfluxDB's JMeter dashboard](img\JMeter_dash.png)

For Grafana, upload `scripts\jmeter-influxdb2-visualizer_7.json` template to get you started. 

![Grafana dashboard](img\Grafana_dash.png)


# Gotchas & Tips
- Use alpine docker images to save on resources.
- InfluxDB organisation name defaults to Expert and bucket name is jmeter_results. To change these, update influxv2.env file and don't forget to update JMeter corresponding variables as well.
- InfluxDB also has a delightful visualisation capability that you could use over or in conjuction with Grafana.
- If Grafana dashboard template doesn't work:
  
    Chech your JMeter backed listener config is correct.
    ![JMeter InfluxDB2 Backend Listener](img\JMeter_InfluxDB_plugin.png)


## References:
[Automate InfluxDb Bootstrap](https://github.com/docker-library/docs/blob/master/influxdb/README.md)

[Grafana Dashboad Plugin](https://grafana.com/grafana/dashboards/13644-jmeter-load-test-org-md-jmeter-influxdb2-visualizer-influxdb-v2-0-flux)

[InfluxDB API Endpoints](https://docs.influxdata.com/influxdb/v2.5/reference/api/)
