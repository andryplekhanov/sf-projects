**to start:**

```sudo apt install apache2-utils```

```sudo htpasswd -c /etc/apache2/.htpasswd user1```

```sudo cat /etc/apache2/.htpasswd > ./auth```

```kubectl create secret generic auth-basic --from-file=auth```

```kubectl apply -f configmap.yaml```

```kubectl apply -f deployment.yaml```


**to check:**

```kubectl exec -it deployment.apps/nginx-sf  -- sh```

`curl sf-webserver` - 401 Authorization Required

`curl -u 'user1:password1' sf-webserver` - must be 200 OK
