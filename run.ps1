param(
    $Regirtry="bcr-de01.inside.bosch.cloud",
    $Organization="scl2bp",
    $lastParam
)

docker run -d --restart always -n fmuchecker -p 9180:8080 $Regirtry/$Organization/fmuchecker:latest
