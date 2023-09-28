$Paths = Get-WmiObject Win32_UserProfile | Select-Object LocalPath | Where-Object {$_.LocalPath -like '*User*'} #Imports all full directories with the UserProfile property and setting to an array.

$Counter = 1

while ($true) {
    Clear-Host

    Write-Host "User Profile Selection Menu:"

    foreach ($profile in $Paths) {
        Write-Host "$Counter. $($profile.LocalPath)" #Prints only profile path
        $Counter++
    
        }
    Write-Host "0. Exit"
    
     
    $choice = Read-Host "Enter the number of the profile you would like to select (Select 0 to Exit)" #User selects choice
    
    $choice = [int]$choice 

    

    if ($choice -eq 0) {
        break
        }

    if ($choice -gt 0 -and $choice -le $Paths.Count) {
        $selectedProfile = $Paths[$choice - 1].LocalPath #Setting path to chosen directory
        Set-Location -Path $selectedProfile
        
        $childItems = Get-ChildItem -Force #Array of child items of Selected Directory

        foreach ($item in $childItems){
            if (Test-Path -PathType Container -Path $item.FullName){
                $userFolders = [System.Environment+SpecialFolder]::GetNames([System.Environment+SpecialFolder]) | Where-Object { [System.Environment]::GetFolderPath($_) -eq $item.FullName}
                if ($null -ne $userFolders) {
                    Write-Host "$($item.FullName)"


                }
                

      }
                
    }
    break
}
}
