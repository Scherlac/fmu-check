
param(
    $UserID  ="scl2bp",
    $UserToken = "",
    $Regirtry="bcr-de01.inside.bosch.cloud",
    $Organization="scl2bp",
    [switch]$CreateRepository,
    $lastParam
)

if ($CreateRepository.IsPresent) {
    $data = @{
        immutableTags= $True;
        longDescription= "_PUBLIC_RISK_ACCEPTED_";
        name= "fmuchecker";
        scanOnPush= $False;
        shortDescription= "Validate an FMU and get the meta information from the model description";
        tagLimit= 0;
        visibility= "public";
        }
    $dataJSON = ( $data | ConvertTo-Json )

    cur  l -u ${UserID}:$UserToken -X POST "https://$Regirtry/api/v0/repositories/$Organization" `
        -H   "accept: application/json" `,
        -H "Content-Type: application/json" `
        -d "$dataJSON"
}

docker build --no-cache -t $Regirtry/$Organization/fmuchecker .
docker push $Regirtry/$Organization/fmuchecker
