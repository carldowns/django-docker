FROM python:2.7
RUN mkdir -p /app 
WORKDIR /app 
COPY . /app/ 
RUN pip install --no-cache-dir -r requirements.txt 
EXPOSE 8000
RUN ["chmod", "+x", "/app/start.sh"]
CMD ["/app/start.sh"]
