clear

# get .env variables
Get-Content .env | foreach {
    $name, $value = $_.split('=')
    if ([string]::IsNullOrWhiteSpace($name) || $name.Contains('#')) {
     continue
    }
    Set-Content env:\$name $value
}

# push to docker hub
docker push mrjamiebowman/debezium:$DEBEZIUM_VERSION
