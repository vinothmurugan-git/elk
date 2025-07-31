<h1 id="🚀-elk-stack-on-docker-elasticsearch-logstash-kibana">🚀 ELK Stack on Docker (Elasticsearch, Logstash, Kibana)</h1>
<p>A ready-to-use <strong>ELK stack</strong> (Elasticsearch, Logstash, Kibana) configured with <strong>Docker Compose</strong>, featuring:</p>
<ul>
<li>Elasticsearch 8.15.1 with security enabled</li>
<li>Logstash 8.15.1 with monitoring credentials</li>
<li>Kibana 8.15.1</li>
<li>Healthchecks and persistent storage</li>
<li>Custom entrypoint script for Elasticsearch</li>
</ul>
<h2 id="📦-services-overview">📦 Services Overview</h2>
<table>
<thead>
<tr>
<th>Service</th>
<th>Port(s)</th>
<th>Description</th>
</tr>
</thead>
<tbody><tr>
<td>Elasticsearch</td>
<td><code>9200</code></td>
<td>REST API for data storage and search</td>
</tr>
<tr>
<td>Logstash</td>
<td><code>5044</code>, <code>5000</code>, <code>9600</code></td>
<td>Data ingestion and transformation pipeline</td>
</tr>
<tr>
<td>Kibana</td>
<td><code>5601</code></td>
<td>Visualization and dashboard UI</td>
</tr>
</tbody></table>
<h2 id="🧰-prerequisites">🧰 Prerequisites</h2>
<ul>
<li><a href="https://docs.docker.com/get-docker/">Docker</a></li>
<li><a href="https://docs.docker.com/compose/install/">Docker Compose</a></li>
</ul>
<h2 id="⚙️-setup-instructions">⚙️ Setup Instructions</h2>
<ol>
<li><p><strong>Clone this repository:</strong></p>
<pre><code class="language-bash">git clone https://github.com/your-username/elk-docker.git
cd elk-docker
</code></pre>
</li>
<li><p><strong>Make sure</strong> <code>entrypoint.sh</code>, <code>logstash.conf</code>, <strong>and</strong> <code>kibana.yml</code> are present in the repo root (see structure below).</p>
</li>
<li><p><strong>Start the stack:</strong></p>
<pre><code>docker-compose up
</code></pre>
<p> It may take a minute or two to fully initialize. Elasticsearch must pass its healthcheck before Kibana and Logstash start.</p>
</li>
<li><p><strong>Access Kibana:</strong></p>
<p> <a href="http://localhost:5601">http://localhost:5601</a>
 Log in using:
 Username: elastic
 Password: elasticpasswd</p>
</li>
</ol>
<h2 id="🔐-security">🔐 Security</h2>
<p>Elasticsearch security is enabled by default.</p>
<ul>
<li><p>Built-in user authentication is required (elasticpasswd is set via environment variable).</p>
</li>
<li><p>You can update user credentials or set up additional users using the Elasticsearch API.</p>
</li>
</ul>
<h2 id="🧪-healthcheck">🧪 Healthcheck</h2>
<p>Elasticsearch includes a healthcheck to ensure it is ready before dependent services start. It checks if port 9200 is reachable.</p>
<h3 id="🗃️-folder-structure">🗃️ Folder Structure</h3>
<pre><code>elk-docker/
├── docker-compose.yml
├── entrypoint.sh                  # Custom Elasticsearch startup script
├── kibana.yml                     # Kibana configuration
├── logstash.conf                  # Logstash pipeline configuration
└── README.md
</code></pre>
<h2 id="📄-configuration-notes">📄 Configuration Notes</h2>
<p><strong>Elasticsearch</strong></p>
<ul>
<li><p>Runs in single-node mode with basic license.</p>
</li>
<li><p>Persistent volume es_data stores indexed data.</p>
</li>
<li><p>Custom entrypoint script is mounted to ensure controlled startup.</p>
</li>
</ul>
<p><strong>Logstash</strong></p>
<ul>
<li><p>Loads pipeline from logstash.conf.</p>
</li>
<li><p>Ports 5044, 5000 (TCP/UDP), and 9600 are exposed for Beats, syslog, and monitoring.</p>
</li>
</ul>
<p><strong>Kibana</strong></p>
<ul>
<li><p>Uses kibana.yml from your local directory for configuration.</p>
</li>
<li><p>Persistent volume kibana_data stores dashboard data.</p>
</li>
</ul>
<h2 id="🛑-stopping-the-stack">🛑 Stopping the Stack</h2>
<p>To shut down the services:</p>
<pre><code>docker-compose down
</code></pre>
<p>To remove all volumes and data:</p>
<pre><code>docker-compose down -v
</code></pre>
