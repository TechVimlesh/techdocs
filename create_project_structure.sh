<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kafka Test Application</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        h1, h2 {
            color: #333;
        }
        .card {
            background-color: white;
            border-radius: 5px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"], textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 15px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
        }
        button:hover {
            background-color: #45a049;
        }
        .message {
            padding: 10px;
            margin: 10px 0;
            border-radius: 4px;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .tab {
            overflow: hidden;
            border: 1px solid #ccc;
            background-color: #f1f1f1;
            border-radius: 4px 4px 0 0;
        }
        .tab button {
            background-color: inherit;
            float: left;
            border: none;
            outline: none;
            cursor: pointer;
            padding: 14px 16px;
            transition: 0.3s;
            font-size: 16px;
            color: #333;
            margin: 0;
        }
        .tab button:hover {
            background-color: #ddd;
        }
        .tab button.active {
            background-color: #4CAF50;
            color: white;
        }
        .tabcontent {
            display: none;
            padding: 20px;
            border: 1px solid #ccc;
            border-top: none;
            border-radius: 0 0 4px 4px;
            animation: fadeEffect 1s;
        }
        @keyframes fadeEffect {
            from {opacity: 0;}
            to {opacity: 1;}
        }
        .messages-container {
            max-height: 300px;
            overflow-y: auto;
            border: 1px solid #ddd;
            padding: 10px;
            margin-top: 10px;
            border-radius: 4px;
        }
        .additional-props {
            margin-top: 10px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .prop-row {
            display: flex;
            margin-bottom: 5px;
        }
        .prop-row input {
            margin-right: 5px;
        }
        .prop-row button {
            padding: 5px 10px;
        }
        .status-indicator {
            display: inline-block;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            margin-left: 10px;
        }
        .connected {
            background-color: #4CAF50;
        }
        .disconnected {
            background-color: #f44336;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Kafka Test Application <span id="connection-status" class="status-indicator disconnected" title="Not connected"></span></h1>
        
        <div class="tab">
            <button class="tablinks active" onclick="openTab(event, 'producer')">Producer</button>
            <button class="tablinks" onclick="openTab(event, 'consumer')">Consumer</button>
            <button class="tablinks" onclick="openTab(event, 'configuration')">Configuration</button>
            <button class="tablinks" onclick="openTab(event, 'diagnostics')">Diagnostics</button>
        </div>
        
        <div id="producer" class="tabcontent" style="display: block;">
            <h2>Send Message</h2>
            <div class="card">
                <div class="form-group">
                    <label for="topic">Topic:</label>
                    <input type="text" id="topic" value="test-topic">
                </div>
                <div class="form-group">
                    <label for="key">Key:</label>
                    <input type="text" id="key" value="testKey">
                </div>
                <div class="form-group">
                    <label for="message">Message:</label>
                    <textarea id="message" rows="5">Test message content</textarea>
                </div>
                <button onclick="sendMessage()">Send Message</button>
                <div id="send-result"></div>
            </div>
        </div>
        
        <div id="consumer" class="tabcontent">
            <h2>Received Messages</h2>
            <div class="card">
                <button onclick="startConsumer()">Start Consumer</button>
                <button onclick="stopConsumer()">Stop Consumer</button>
                <button onclick="clearMessages()">Clear Messages</button>
                <div class="messages-container" id="received-messages">
                    <p>No messages received yet...</p>
                </div>
            </div>
        </div>
        
        <div id="configuration" class="tabcontent">
            <h2>Kafka Configuration</h2>
            <div class="card">
                <div class="form-group">
                    <label for="bootstrap-servers">Bootstrap Servers:</label>
                    <input type="text" id="bootstrap-servers">
                </div>
                <div class="form-group">
                    <label for="client-id">Client ID:</label>
                    <input type="text" id="client-id">
                </div>
                <div class="form-group">
                    <label for="consumer-group-id">Consumer Group ID:</label>
                    <input type="text" id="consumer-group-id">
                </div>
                <div class="form-group">
                    <label for="concurrency">Concurrency:</label>
                    <input type="text" id="concurrency">
                </div>
                
                <h3>Additional Producer Properties</h3>
                <div id="producer-props" class="additional-props">
                    <div class="prop-row">
                        <input type="text" placeholder="Key" class="prop-key">
                        <input type="text" placeholder="Value" class="prop-value">
                        <button onclick="addProducerProp()">+</button>
                    </div>
                </div>
                
                <h3>Additional Consumer Properties</h3>
                <div id="consumer-props" class="additional-props">
                    <div class="prop-row">
                        <input type="text" placeholder="Key" class="prop-key">
                        <input type="text" placeholder="Value" class="prop-value">
                        <button onclick="addConsumerProp()">+</button>
                    </div>
                </div>
                
                <button onclick="saveConfig()">Save Configuration</button>
                <button onclick="refreshConfig()">Refresh Configuration</button>
                <div id="config-result"></div>
            </div>
        </div>
        
        <div id="diagnostics" class="tabcontent">
            <h2>Kafka Diagnostics</h2>
            <div class="card">
                <button onclick="testConnection()">Test Connection</button>
                <button onclick="listTopics()">List Topics</button>
                <div id="diagnostics-result"></div>
            </div>
        </div>
    </div>

    <script>
        // Application state
        let isConsumerRunning = false;
        let consumerInterval;
        let currentConfig = {};
        let producerProps = {};
        let consumerProps = {};
        
        // Initialize the application
        window.onload = function() {
            loadConfig();
            testConnection();
        };
        
        // Tab functionality
        function openTab(evt, tabName) {
            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("tabcontent");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tablinks");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");
            }
            document.getElementById(tabName).style.display = "block";
            evt.currentTarget.className += " active";
        }
        
        // Producer functions
        function sendMessage() {
            const topic = document.getElementById('topic').value;
            const key = document.getElementById('key').value;
            const message = document.getElementById('message').value;
            
            const resultElement = document.getElementById('send-result');
            resultElement.innerHTML = "<p>Sending message...</p>";
            
            fetch('/api/kafka/send', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    topic: topic,
                    key: key,
                    message: message
                }),
            })
            .then(response => response.text())
            .then(data => {
                resultElement.innerHTML = `<p class="message success">${data}</p>`;
            })
            .catch((error) => {
                resultElement.innerHTML = `<p class="message error">Error: ${error}</p>`;
            });
        }
        
        // Consumer functions
        function
