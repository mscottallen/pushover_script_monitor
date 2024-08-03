# Pushover Monitor and Notify Script

This script monitors a specified job or script running on your server and sends a notification via Pushover when the job completes. It's useful for long-running processes where you want to be alerted upon completion.

## Prerequisites

- **Pushover Account**: You need a Pushover account to obtain an API token and User key.
- **curl**: Ensure `curl` is installed on your server. You can install it using your package manager. For example, on Ubuntu, run:
  ```bash
  sudo apt-get install curl
  ```

## Usage

1. **Clone the Repository**: Clone this repository to your local machine or server.

   ```bash
   git clone https://github.com/mscottallen/pushover_script_monitor.git
   cd monitor-and-notify
   ```

2. **Configure the Script**: Open `pushover_monitor.sh` in a text editor and set the following variables:
   - `JOB_NAME`: The command or script name to monitor.
   - `API_TOKEN`: Your Pushover API token.
   - `USER_KEY`: Your Pushover user key.
   - `MESSAGE`: The notification message. It can include `${JOB_NAME}` to dynamically insert the job name.

   Example:
   ```bash
   #!/bin/bash

   JOB_NAME="your_script_name" # The command or script name to monitor
   API_TOKEN="your_pushover_api_token"
   USER_KEY="your_pushover_user_key"
   MESSAGE="Your job (${JOB_NAME}) has completed."

   # Monitor the job
   while pgrep -f "$JOB_NAME" > /dev/null; do
     sleep 60 # Check every 60 seconds
   done

   # Send Pushover notification
   curl -s \
     --form-string "token=${API_TOKEN}" \
     --form-string "user=${USER_KEY}" \
     --form-string "message=${MESSAGE}" \
     https://api.pushover.net/1/messages.json
   ```

3. **Make the Script Executable**: Ensure the script has executable permissions.

   ```bash
   chmod +x pushover_monitor.sh
   ```

4. **Run the Script**: Execute the script in the background to start monitoring your job.

   ```bash
   ./pushover_monitor.sh &
   ```

   This will start the script and it will monitor the specified job every 60 seconds. Once the job completes, it will send a notification via Pushover.

## Example

Here is an example scenario:

- You have a Python script located at `/path/to/your_script.py` that takes a long time to run.
- You want to be notified via Pushover when the script finishes.

Steps:

1. Open `pushover_monitor.sh` and configure it as follows:

   ```bash
   #!/bin/bash

   JOB_NAME="/path/to/your_script.py"
   API_TOKEN="your_pushover_api_token"
   USER_KEY="your_pushover_user_key"
   MESSAGE="Your job (${JOB_NAME}) has completed."

   # Monitor the job
   while pgrep -f "$JOB_NAME" > /dev/null; do
     sleep 60 # Check every 60 seconds
   done

   # Send Pushover notification
   curl -s \
     --form-string "token=${API_TOKEN}" \
     --form-string "user=${USER_KEY}" \
     --form-string "message=${MESSAGE}" \
     https://api.pushover.net/1/messages.json
   ```

2. Save the file and make it executable:

   ```bash
   chmod +x pushover_monitor.sh
   ```

3. Run the script in the background:

   ```bash
   ./pushover_monitor.sh &
   ```

4. When your script (`/path/to/your_script.py`) completes, you will receive a notification via Pushover.

## Setting Up Pushover

To set up Pushover and obtain your User Key and API Token, follow these steps:

1. **Create a Pushover Account**:
   - Go to [Pushover](https://pushover.net/) and sign up for an account if you don't already have one.
   - After signing up, log in to your account.

2. **Get Your User Key**:
   - Once logged in, go to your [dashboard](https://pushover.net/).
   - Your User Key will be displayed on the main dashboard page. It is a long alphanumeric string.

3. **Create an Application to Get the API Token**:
   - Go to the [Create an Application/API Token](https://pushover.net/apps/build) page.
   - Fill in the details for your application (e.g., name, description) and click the "Create Application" button.
   - After creating the application, you will be provided with an API Token.

4. **Configure the Script with Your Credentials**:
   - Open `monitor_and_notify.sh` in a text editor.
   - Set the `API_TOKEN` and `USER_KEY` variables with the values obtained from the Pushover dashboard.
   - Example:
     ```bash
     API_TOKEN="your_pushover_api_token"
     USER_KEY="your_pushover_user_key"
     ```

Now, your script is configured to send notifications via Pushover when the monitored job completes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.