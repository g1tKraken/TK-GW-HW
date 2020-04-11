' GWU Data Analytics Bootcamp
' Homework week two
' Todd Karr

Sub stockcheck()
        
    debugMode = False
    'debugMode = True
    
    For Each sl In Worksheets
        
        Dim tickerStr As String
        Dim annualChangeDbl As Double
        Dim openingYearPriceDbl As Double
        Dim closingYearPriceDbl As Double
        
        Dim percentChangeDbl As Double
        Dim totalVolumeLng As Long
        
        Dim startRow As Long
        
        Dim reportingRow As Integer
        
        annualChangeDbl = 0
        reportingRow = 1
        
        sl.Range("I1:L" & sl.Cells(Rows.Count, 12).End(xlUp).Row).ClearContents
        
        sl.Range("I1").Value = "Ticker"
        sl.Range("J1").Value = "Yearly Change"
        sl.Range("K1").Value = "Percent Change"
        sl.Range("L1").Value = "Total Stock Volume"
        
        
        
        If debugMode Then
            sl.Range("N1").Value = "Opening Prince" 'col 14
            sl.Range("O1").Value = "Closing Prince" 'col 15
            sl.Range("H1").Value = "Debug (row tracker)"
        End If
        
        ' debug on this ("A") worksheet only, remove for prod
        ' Dim ws As Worksheet: Set ws = ThisWorkbook.Worksheets("A")
        
        lastRow = sl.Cells(Rows.Count, 1).End(xlUp).Row
        
        If debugMode Then
            lastRow = 800
        End If
        
        ' MsgBox (lastRow)
        
        ' Ensure the rows are sorted correctly
        With sl.Sort
            .SortFields.Clear
            .SortFields.Add Key:=sl.Range("A1"), Order:=xlAscending
            .SortFields.Add Key:=sl.Range("B1"), Order:=xlAscending
            .SetRange sl.Range("A1:G" & lastRow)
            .Header = xlYes
            .Apply
        End With
            
        
        For i = 2 To lastRow
           ' loop finds a new stock
           If tickerStr <> sl.Cells(i, 1).Value Then
                tickerStr = sl.Cells(i, 1).Value
                
                ' start new stock reporting row
                reportingRow = reportingRow + 1
                
                'annualChangeDbl = Cells(i, 6).Value
                
                
                sl.Range("I" & reportingRow).Value = tickerStr
                openingYearPriceDbl = sl.Cells(i, 3).Value
                
                If debugMode Then
                    sl.Range("N" & reportingRow).Value = openingYearPriceDbl
                End If
                
                'totalVolumeLng = Cells(i, 7).Value
                startRow = i
            ' loop finds the same stock
            Else
            
                'totalVolumeLng = (totalVolumeLng + Cells(i, 7).Value)
                
                If tickerStr <> sl.Cells(i + 1, 1).Value Or i = lastRow Then
                    
                    closingYearPriceDbl = sl.Cells(i, 6).Value
                    
                    If debugMode Then
                        sl.Range("O" & reportingRow).Value = closingYearPriceDbl
                    End If
                    
                    annualChangeDbl = closingYearPriceDbl - openingYearPriceDbl
                    
                    sl.Range("J" & reportingRow).Value = annualChangeDbl
                    If annualChangeDbl <> 0 Then
                        sl.Range("K" & reportingRow).Value = (annualChangeDbl / openingYearPriceDbl) ' * 100
                    Else
                        sl.Range("K" & reportingRow).Value = annualChangeDbl
                    End If
                    
                    'Range("L" & reportingRow).Value = totalVolumeInt
                    sl.Range("L" & reportingRow).Value = "=Sum(G" & startRow & ":G" & i & ")"
                    
                    'totalVolumeInt = 0
                End If
            End If
        
            If debugMode Then
                sl.Range("H" & reportingRow).Value = i
            End If
            
            If sl.Range("J" & reportingRow).Value > 0 Then
                sl.Range("J" & reportingRow).Interior.ColorIndex = 4
            Else
                sl.Range("J" & reportingRow).Interior.ColorIndex = 3
            End If
            
        Next i
        
        'Range("K2:K" & reportingRow).Style = "Percent"
        sl.Range("K2:K" & reportingRow).NumberFormat = "0.00%"
              
    Next sl 'stockList
End Sub