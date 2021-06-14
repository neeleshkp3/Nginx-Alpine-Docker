server {
    server_name abc.xyz.com;
    listen 80;
    location / {
        resolver 127.0.0.11 valid=5s;
        set $backend "abc:";
        proxy_pass http://$backend;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }   
}
