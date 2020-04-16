# Base Image
FROM ubuntu

# Set up OS and necessary packages
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install software-properties-common -y
RUN apt-get install wget -y
RUN apt-get install curl -y
RUN apt-get install git -y

# Set up NodeJS
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash
RUN apt-get install nodejs -y

# Set up NGINX
RUN apt-get install nginx -y
RUN wget -O init-deb.sh https://www.linode.com/docs/assets/660-init-deb.sh
RUN mv init-deb.sh /etc/init.d/nginx
RUN chmod +x /etc/init.d/nginx
RUN /usr/sbin/update-rc.d -f nginx defaults

# Configure NGINX and expose the necessary ports
RUN rm /etc/nginx/sites-enabled/default
COPY /nginx-config.conf /etc/nginx/sites-enabled/default
RUN service nginx restart
EXPOSE 80
EXPOSE 8888

# Set up Python and PIP
RUN apt-get install python3.7 -y
RUN apt-get install python3-distutils -y
RUN wget https://bootstrap.pypa.io/get-pip.py
RUN python3.7 get-pip.py

# Get the latest master branch version of SKF
RUN git clone https://github.com/blabla1337/skf-flask.git

# Move the files to the correct location
RUN mkdir /skf
WORKDIR /skf
RUN cp /../skf-flask/requirements.txt .
RUN cp /../skf-flask/logging.conf /
RUN cp -R /../skf-flask/Angular ./angular
RUN cp -R /../skf-flask/skf /
RUN rm -r /skf-flask

# Install the python requirements
RUN pip install -r requirements.txt

# Install the necessary front-end assets
WORKDIR /skf/angular
RUN npm install -g @angular/cli
RUN npm install

# Set up the start-up script
COPY /skf-start.sh /
RUN ["chmod", "+x", "/skf-start.sh"]
ENTRYPOINT [ "/skf-start.sh" ]