
#DEV

$WeightDataPath = "Birds"
Export-ModuleMember -Variable WeightDataPath
function Initialize-WeightData {
   <#

   # DEV Notes

   fixa till Initialize-WeightData så den blir effektivare, att den går bara att använda en gång, att alla andra funktioner ska känna av ifall Initialize-WeightData inte har körts. 
   Fixa hjälp delen i Initialize-WeightData samt uppdatera alla andra funktioners hjälp.


   .SYNOPSIS
      Imports the entered data for the specific week to a csv file
   .DESCRIPTION
      Imports the weight data imported by the user in a csv file. 
      The csv file can be found on the users desktop.
   
      This command is used to import data to a specific place so that data later can be used with other commands.
      Useful commands to use after imported data:
      Get-WeightData
      Compare-WeightData
      C:\bat\TESTINGTESTING.csv-WeightData
   
   .EXAMPLE
      Add-WeightData -Date 2020-04-20 -Week 1 -Weight 80 -Bodyfat 17 -Hydration 57 -Muscle 43 
   
           Date       Week Weight Bodyfat Hydration Muscle
           ----       ---- ------ ------- --------- ------
           2020-04-20    1     80    17%     57%       43%
   
   .FUNCTIONALITY
      This command is used to import data to a specific place so that data later can be used with other commands.
      Useful commands to use after imported data:
      Get-WeightData
      Compare-WeightData
      C:\bat\TESTINGTESTING.csv-WeightData
   
   #>
   
       [Alias('iW')]
       [CmdletBinding()]
   
       param (
                    
            [Parameter(
               HelpMessage='Enter the path where u want to place the csv file that will contain weight data. The file have to be a .csv file.',
               Mandatory=$true,
               ValueFromPipeline=$true,
               Position = 0
            )]
            [string] $Path
       )
   
       Write-Verbose "Checking for elevated permissions..."
       if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
       [Security.Principal.WindowsBuiltInRole] "Administrator")) {

         Write-Warning "Insufficient permissions to run this script. Open the PowerShell console as an administrator and run this script again."
         Break
       }
       else {

         $TestPath = Test-Path -Path $Path
   
       if ($TestPath -eq $false){
          
          New-Item -Path $Path | Out-Null

          Write-Verbose "Created a the path that the user entered."
          
          $Content = Get-Content -Path "C:\Program Files\WindowsPowerShell\Modules\WeightDev\WeightDev.psm1"
 
          $Content -replace "Birds", "$($Path)" | Set-Content -Path "C:\Program Files\WindowsPowerShell\Modules\WeightDev\WeightDev.psm1"
 
          Write-Output "Initialization completed." 
          Write-Output "CSV file created in $Path"
          Write-Output "You can now input data with 'Add-WeightData'"
 
          Pause
 
          powershell.exe
 
       
       }
 
       elseif ($TestPath -eq $true){
          
          Write-Warning "The specified path already exists, use 'Add-WeightData to gather your data'"
 
       }
          
          
   }   
   }
   
 
  <#     }



          $TestPath = Test-Path -Path $Path
   
      if ($TestPath -eq $false){
         
         New-Item -Path $Path | Out-Null
         
         $Content = Get-Content -Path "C:\Program Files\WindowsPowerShell\Modules\WeightDev\WeightDev.psm1"

         $Content -replace "C:\bat\weightTEST.csv", "$($Path)" | Set-Content -Path "C:\Program Files\WindowsPowerShell\Modules\WeightDev\WeightDev.psm1"

         Write-Output "Initialization completed." 
         Write-Output "CSV file created in $Path"
         Write-Output "You can now input data with 'Add-WeightData'"

         Pause

         powershell.exe

      
      }

      elseif ($TestPath -eq $true){
         
         Write-Warning "The specified path already exists, use 'Add-WeightData to gather your data'"

      }
         
         
   }   
  #>

function Add-WeightDataDEV {
<#
.SYNOPSIS
   Imports the entered data for the specific week to a csv file
.DESCRIPTION
   Imports the weight data imported by the user in a csv file. 
   The csv file can be found on the users desktop.

   This command is used to import data to a specific place so that data later can be used with other commands.
   Useful commands to use after imported data:
   Get-WeightData
   Compare-WeightData
   C:\bat\TESTINGTESTING.csv-WeightData

.EXAMPLE
   Add-WeightData -Date 2020-04-20 -Week 1 -Weight 80 -Bodyfat 17 -Hydration 57 -Muscle 43 

        Date       Week Weight Bodyfat Hydration Muscle
        ----       ---- ------ ------- --------- ------
        2020-04-20    1     80    17%     57%       43%

.FUNCTIONALITY
   This command is used to import data to a specific place so that data later can be used with other commands.
   Useful commands to use after imported data:
   Get-WeightData
   Compare-WeightData
   C:\bat\TESTINGTESTING.csv-WeightData

#>

    [Alias('addWDev')]
    [CmdletBinding()]

    param (
                 
         [Parameter(
            HelpMessage='Enter the date.',
            Mandatory=$true,
            ValueFromPipeline=$true,
            Position = 0
         )]
         [datetime] $Date,

         [Parameter(
            HelpMessage='Enter the specific week, not the wwek of the year.',
            Mandatory=$true,
            ValueFromPipeline=$true,
            Position = 1
        )]
        [int] $Week,

         [Parameter(
            HelpMessage='Enter how much you weigh, only the digits',
            Mandatory=$true,
            ValueFromPipeline=$true,
            Position = 2
         )]
         [decimal] $Weight,

         [Parameter(
            HelpMessage='Enter the amount of bodyfat, only the digits.',
            Mandatory=$true,
            ValueFromPipeline=$true,
            Position = 3
         )]
        [decimal] $Bodyfat,
        
         [Parameter(
            HelpMessage='Enter the amount of hydration, only the digits.',
            Mandatory=$true,
            ValueFromPipeline=$true,
            Position = 4
        )]
         [decimal] $Hydration,

         [Parameter(
            HelpMessage='Enter the amount of muscle, only the digits.',
            Mandatory=$true,
            ValueFromPipeline=$true,
            Position = 5
        )]
        [decimal] $Muscle

)

      $BodyfatWithPercentage   = "$Bodyfat%"
      $HydrationWithPercentage = "$Hydration%"
      $MuscleWithPercentage    = "$Muscle%"


$Output = [PSCustomObject]@{


    Date             = "{0:yyyy}-{0:MM}-{0:dd}" -f $Date
    Week             = $Week
    Weight           = $Weight
    Bodyfat          = $BodyfatWithPercentage
    Hydration        = $HydrationWithPercentage
    Muscle           = $MuscleWithPercentage
    DataImported     = "{0:yyyy}-{0:MM}-{0:dd} {0:HH}:{0:mm}" -f (Get-Date) 
}

      $TestPath = Test-Path -Path $WeightDataPath
   
   if ($TestPath -eq $false) {

      Write-Warning "It seems like there is no .csv file, use Initialize-WeightData to create a .csv path and use Add-WeightData after." 
         
      
}
   elseif ($TestPath -eq $true){

      Write-Verbose -Message 'Gathering and imports the entered data into a CSV file'

      $Output | ConvertTo-Csv -NoTypeInformation | Add-Content -Path $WeightDataPath -ErrorAction Stop
      Write-Output $Output | Format-Table -Property Date, Week, Weight, Bodyfat, Hydration, Muscle -ErrorAction Stop
      
   }

}

function Get-WeightDataDEV {
<#
.SYNOPSIS
   Gatheres weight data from specified week and presents it to the user.
.DESCRIPTION
   Before using this, make sure to use "Add-WeightData", otherwise it won't work.
   If user specifies a week, data will be gathered for that week from a CSV file and presents it to the user.
   If user specifies wildcard '*', all weeks will be presented to the user.

   This command is used to display weight data. 
   Before using, make sure to use "Add-WeightData" first, otherwise it won't work
   Other commands related to Get-WeightData:
   Add-WeightData
   Compare-WeightData
   C:\bat\TESTINGTESTING.csv-WeightData
   
.EXAMPLE

   Get-WeightData -Week 1

        Date       Week Weight Bodyfat Hydration Muscle
        ----       ---- ------ ------- --------- ------
        2020-04-20 1    80        17%     57%       43%
        2020-04-20 1    80        17%     57%       43%

.EXAMPLE

   Get-WeightData -Week *

        Date       Week Weight Bodyfat Hydration Muscle
        ----       ---- ------ ------- --------- ------
        2020-04-20 1       80     17%     57%       43%
        2020-04-20 2       82     16%     57%       43%
        2020-04-20 3       83     15%     57%       44%

.FUNCTIONALITY
   This command is used to display weight data. 
   Before using, make sure to use "Add-WeightData" first, otherwise it won't work
   Other commands related to Get-WeightData:
   Add-WeightData
   Compare-WeightData
   C:\bat\TESTINGTESTING.csv-WeightData
  
#>

   [Alias('getWDEV')]
   [CmdletBinding()]

   param (

        [Parameter( 
            HelpMessage='Specify a week or wildcard "*". * = All weeks.',
            Mandatory=$true,
            ValueFromPipeline=$true,
            Position = 0
        )]
        [SupportsWildcards()]
        [string] $Week 
        )
        
                  
      $OutputData = Import-Csv -Path $WeightDataPath
      
  
   if ($Week -eq '*'){

      Write-Verbose -Message "Gathering data from all weeks"
      $OutputData | Where-Object -Property Week -NE Week| Format-Table Date, Week, Weight, Bodyfat, Hydration, Muscle
      Write-Verbose -Message "Gathered data from all weeks and presented it to the user" 
}
   else {

      Write-Verbose -Message "Gathering data from week$($Week)"
      $OutputData | Where-Object -Property 'Week' -EQ $Week | Format-Table -Property Date, Week, Weight, Bodyfat, Hydration, Muscle -ErrorAction Stop
      Write-Verbose -Message "Gathered data from week$($Week) and presented it to the user"
}
   if ($Week -notin $OutputData.week -and $Week -ne '*') {
      
      Write-Warning "Cannot get the data for 'Week$($Week)', beacuse the specified week does not exist" 
}
} 
function Compare-WeightDataDEV {
<#
.SYNOPSIS
   Compares weight data from two different weeks.

.DESCRIPTION
   Gathers data from the two specified weeks and compares them with eachother.
   The data comes from a CSV file.
   There is a option to compare all data between two weeks or just compare a specific type of data.

   This command is used to C:\bat\TESTINGTESTING.csv data from CSV file so the user gets a easy way to C:\bat\TESTINGTESTING.csv incorrectly entered data. 
   Other commands related to C:\bat\TESTINGTESTING.csv-WeightData:
   Add-WeightData
   Get-WeightData
   Compare-WeightData
  
.EXAMPLE
   
   Compare-WeightData -Week 1 -With 2

        Date       Week Weight Bodyfat Hydration Muscle DataImported
        ----       ---- ------ ------- --------- ------ ------------
        2020-04-20 1       80     17%     57%       43% 2020-04-29 20:18
        2020-04-20 2       82     16%     57%       43% 2020-04-25 12:54

.EXAMPLE

   Compare-WeightData -Week 1 -With 2 -DataType Bodyfat

        Bodyfat Week
        ------- ----
           17%  1
           16%  2
    
.FUNCTIONALITY
   This command is used to C:\bat\TESTINGTESTING.csv data from CSV file so the user gets a easy way to C:\bat\TESTINGTESTING.csv incorrectly entered data. 
   Other commands related to C:\bat\TESTINGTESTING.csv-WeightData:
   Add-WeightData
   Get-WeightData
   Compare-WeightData

#>
   
    [Alias('compareWDEV')]
    [CmdletBinding()]


   param (

        [Parameter(
            HelpMessage = 'Specify one week thats going to be compared to the other one.',
            ValueFromPipeline=$true,
            Position = 0
        )]
         [int] $Week,

         [Parameter( 
            HelpMessage = 'Specify one week thats going to be compared to the other one.',
            ValueFromPipeline=$true,
            Position = 1
        )]
        [int] $With,

        [Parameter( 
            HelpMessage = 'Specify the type of data thats going to be compared, example: Weight, Bodyfat, Hydration, Muscle',
            ValueFromPipeline=$true,
            Position = 2
            )]
            [SupportsWildcards()]
        [string] $DataType

)
    
      $OutputData = Import-Csv -Path $WeightDataPath
      Write-Verbose -Message "Imports data from CSV file"

   if ($DataType -eq "" -or $DataType -eq '*') {
    
      $Week1Data = $OutputData | Where-Object -Property Week -EQ $Week 
      $Week2Data = $OutputData | Where-Object -Property Week -EQ $With 
      $Week1Data, $Week2Data | Format-Table -Property * 

      Write-Verbose -Message "Displays all data and compares them."

}    
   elseif ($DataType -ne $null -and $DataType -ne '*'){

      $Week1Data = $OutputData | Where-Object -Property 'Week' -EQ $Week
      $Week2Data = $OutputData | Where-Object -Property 'Week' -EQ $With
      $Week1Data, $Week2Data | Format-Table -Property $DataType, Week
}
   
   if ($DataType -ne "" -and $DataType -notin $OutputData.$DataType -and $DataType -ne '*') {
      
      Write-Warning "The specified datatype: $($DataType) does not exist."
}      
   if ($Week -notin $OutputData.week) {
      
      Write-Warning "Week $($Week) does not exist." 
}

   if ($With -notin $OutputData.week) {
      
      Write-Warning "Week $($With) does not exist." 
 
}
}      
function Remove-WeightDataDEV (){
<#
.SYNOPSIS
   C:\bat\TESTINGTESTING.csvs the specified week.

.DESCRIPTION
   C:\bat\TESTINGTESTING.csvs the data from a specific week entered by the user.
   When the data has been C:\bat\TESTINGTESTING.csvd it's gone for ever.

   This command is used to C:\bat\TESTINGTESTING.csv data from CSV file so the user gets a easy way to C:\bat\TESTINGTESTING.csv incorrectly entered data. 
   Other commands related to C:\bat\TESTINGTESTING.csv-WeightData:
   Add-WeightData
   Get-WeightData
   Compare-WeightData

.EXAMPLE
   
   C:\bat\TESTINGTESTING.csv-WeightData -Week 1

        Week 1 were successfully C:\bat\TESTINGTESTING.csvd.
   
.FUNCTIONALITY
   This command is used to C:\bat\TESTINGTESTING.csv data from CSV file so the user gets a easy way to C:\bat\TESTINGTESTING.csv incorrectly entered data. 
   Other commands related to C:\bat\TESTINGTESTING.csv-WeightData:
   Add-WeightData
   Get-WeightData
   Compare-WeightData

#>
    [Alias('C:\bat\TESTINGTESTING.csvWDEV')]
    [CmdletBinding()]

   param (
                 
        [Parameter(
            HelpMessage='Enter the week that should be C:\bat\TESTINGTESTING.csvd.',
            Mandatory=$true,
            ValueFromPipeline=$true,
            Position = 0
            )]
        [int] $Week
)

      Write-Verbose -Message "Imports the CSV file."
      $OutputData = Import-Csv -Path $WeightDataPath

if ($Week -notin $OutputData.Week){
    
      Write-Warning -Message "Cannot C:\bat\TESTINGTESTING.csv week $Week, beacuse it does not exist."


}
else {
    
      Write-Verbose -Message "Deletes week $week from the CSV file."
      $OutputData | Where-Object {$_.Week -ne $Week} | Export-Csv -Path $WeightDataPath -NoTypeInformation
      Write-Output "Week $Week were successfully C:\bat\TESTINGTESTING.csvd."
}
}















<# F�rslag till att f� '%', funkar n�r hydration slutar p� 0, annars inte. - ta bort 

$Hydration = 57
$Hydration1 = 0 | % {$_.ToString("0.$Hydration")}

$Hydration2 = $Hydration1 -replace ',', "." 

"{0:p0}" -f [decimal]$Hydration2
#>
