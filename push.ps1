clear;

# get .env variables
Get-Content .env | foreach {
    $name, $value = $_.split('=')
    if ([string]::IsNullOrWhiteSpace($name) -or $name.Contains('#')) {
     continue
    }
    Set-Content env:\$name $value
}

# push to dockerhub
docker push mrjamiebowman/debezium:$env:DEBEZIUM_VERSION

