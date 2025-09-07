##**Author**
##**Bilal Rauther**
##https://github.com/rauther1/

#**PowerShell Log Analyzer**

A simple script to analyze **SharePoint ULS logs** or **Windows log exports**.  
It extracts `ERROR` and `WARNING` lines, then generates a clean CSV or HTML report.  

---

## Features
- Parses log files for errors and warnings  
- Exports to **CSV** (default) or **HTML**  
- Highlights key fields: Timestamp, Process, Level, Message  
- Lightweight, no external dependencies  

---

## Usage

### 1. Clone the repo
```powershell
git clone https://github.com/<your-username>/LogAnalyzer.git
cd LogAnalyzer

##**Run script**
# Export results to CSV
.\LogAnalyzer.ps1 -LogPath "C:\Logs\ULS.log" -OutputPath "report.csv"

# Export results to HTML
.\LogAnalyzer.ps1 -LogPath "C:\Logs\ULS.log" -OutputPath "report.csv" -HTML

**Sample Output**

##CSV Example

"Timestamp","Process","Message","Level"
"09-02-2025 11:05:32","mssdmn.exe","IdentityNotMappedException","ERROR"
"09-02-2025 11:05:53","mssearch.exe","SocketException: No such host is known","WARNING"

##**To do:**
Add filtering by date range
Add summary stats (total errors vs warnings)
Add export to JSON
