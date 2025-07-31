<h1 id="🚀-elk-stack-on-docker-elasticsearch-logstash-kibana">🚀 ELK Stack on Docker (Elasticsearch, Logstash, Kibana)</h1>
<p>A ready-to-use <strong>ELK stack</strong> (Elasticsearch, Logstash, Kibana) configured with <strong>Docker Compose</strong>, featuring:</p>
<ul>
<li>Elasticsearch 8.15.1 with security enabled</li>
<li>Logstash 8.15.1 with email alerts</li>
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
<li>Gmail account or SMTP email service for Logstash alerts</li>
</ul>
<h2 id="⚙️-setup-instructions">⚙️ Setup Instructions</h2>
<ol>
<li><p><strong>Clone this repository:</strong></p>
<pre><code class="language-bash">git clone https://github.com/your-username/elk-docker.git
cd elk-docker
</code></pre>
</li>
<li><p><strong>Required Files Explained</strong></p>
<p> Make sure the following files are present in your project root:</p>
<p><code>entrypoint.sh</code> –  <em>Custom Elasticsearch Startup Script</em></p>
<ul>
<li>This script starts Elasticsearch, waits until it&#39;s fully running, and then creates a kibana_user account needed for Kibana to connect.</li>
</ul>
<p><code>kibana.yml</code> – <em>Kibana Configuration</em></p>
<ul>
<li>This config enables encryption, external access, and allows Kibana to securely connect to Elasticsearch using the kibana_user account.</li>
</ul>
<p><em>Encryption Key Length Requirements</em></p>
<ul>
<li><p>Kibana requires that each of the following encryption keys be at least 32 characters long:</p>
<p>   <code>xpack.security.encryptionKey</code></p>
<p>   <code>xpack.encryptedSavedObjects.encryptionKey</code></p>
<p>   <code>xpack.reporting.encryptionKey</code></p>
</li>
<li><p>A minimum of 32 characters ensures proper AES-256 encryption strength.</p>
</li>
</ul>
<p><code>logstash.conf</code> – <em>Logstash Pipeline Configuration</em></p>
<p>This file defines the full data flow through Logstash: where data comes from, how it’s processed, and where it goes.</p>
<p><strong>Purpose:</strong></p>
<p><strong>Input:</strong> Listens for logs (in this case, JSON over TCP port 5000).</p>
<p><strong>Filter:</strong> Tags log entries containing &quot;error&quot;, &quot;exception&quot;, or &quot;failed&quot; in the message.</p>
<p><strong>Output:</strong></p>
<ul>
<li>Sends logs to Elasticsearch for indexing.</li>
<li>Outputs logs to console for debugging.</li>
<li>Sends email alerts for tagged error logs using SMTP.</li>
</ul>
<p> 📡 It’s the heart of your log processing pipeline—customizable, extendable, and powerful for real-time log handling.</p>
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
<h2 id="🛑-stopping-the-stack">🛑 Stopping the Stack</h2>
<p>To shut down the services:</p>
<pre><code>docker-compose down
</code></pre>
<p>To remove all volumes and data:</p>
<pre><code>docker-compose down -v
</code></pre>
