Attribute VB_Name = "HPmod"
' Das Programm ist geschrieben von Kurt Annen, mehr unter www.web-reg.de'
' Wenn Ihnen das Programm gefällt, so schicken Sie mir bitte eine email: annen@web-reg.de'
' This program was written by Kurt Annen, see www.web-reg.de'
' If you like the program, please send me an email: annen@web-reg.de'

Option Explicit
Option Base 1

Function HP(data As Range, lambda As Double)
    Dim nobs As LONG, nseries As LONG
    Dim i As LONG, k As LONG
    Dim a() As Double, b() As Double, c() As Double, HPout() As Double
    Dim H1() As Double, H2() As Double, H3() As Double, H4() As Double, H5() As Double
    Dim HH1() As Double, HH2() As Double, HH3() As Double, HH4() As Double, HH5() As Double
    Dim Z() As Double, HB() As Double, HC() As Double

    nseries = data.Columns.Count
    nobs = data.Rows.Count
    
    ReDim HPout(nobs, nseries)
    For i = 1 To nseries Step 1
        For k = 1 To nobs Step 1
            HPout(k, i) = data(k, i)
        Next k
    Next i
    
    If nobs <= 3 Then
    
    HP = HPout
    
    Else
    'Pentadiagonale Matrix erstellen'
    'creates pentadiagonal Matrix'
    ReDim a(nobs, nseries)
    ReDim b(nobs, nseries)
    ReDim c(nobs, nseries)
    
    
    For k = 1 To nseries Step 1
        a(1, k) = 1 + lambda
        b(1, k) = -2 * lambda
        c(1, k) = lambda
    
        For i = 2 To nobs - 1 Step 1
            a(i, k) = 6 * lambda + 1
            b(i, k) = -4 * lambda
            c(i, k) = lambda
        Next i
    
        a(2, k) = 5 * lambda + 1
        a(nobs, k) = 1 + lambda
        a(nobs - 1, k) = 5 * lambda + 1
        b(1, k) = -2 * lambda
        b(nobs - 1, k) = -2 * lambda
        b(nobs, k) = 0
        c(nobs - 1, k) = 0
        c(nobs, k) = 0
    Next k
    
    'Lösen des linearen Gleichungssystemes'
    'Solving system of linear equations'
    
    ReDim H1(nseries)
    ReDim H2(nseries)
    ReDim H3(nseries)
    ReDim H4(nseries)
    ReDim H5(nseries)
    ReDim HH1(nseries)
    ReDim HH2(nseries)
    ReDim HH3(nseries)
    ReDim HH4(nseries)
    ReDim HH5(nseries)
    ReDim Z(nseries)
    ReDim HB(nseries)
    ReDim HC(nseries)
    'Vorwärts'
    'Forward'
    For k = 1 To nseries Step 1
    
        For i = 1 To nobs Step 1
            Z(k) = a(i, k) - H4(k) * H1(k) - HH5(k) * HH2(k)
            HB(k) = b(i, k)
            HH1(k) = H1(k)
            H1(k) = (HB(k) - H4(k) * H2(k)) / Z(k)
            b(i, k) = H1(k)
            HC(k) = c(i, k)
            HH2(k) = H2(k)
            H2(k) = HC(k) / Z(k)
            c(i, k) = H2(k)
            a(i, k) = (HPout(i, k) - HH3(k) * HH5(k) - H3(k) * H4(k)) / Z(k)
            HH3(k) = H3(k)
            H3(k) = a(i, k)
            H4(k) = HB(k) - H5(k) * HH1(k)
            HH5(k) = H5(k)
            H5(k) = HC(k)
        Next i
    
    H2(k) = 0
    H1(k) = a(nobs, k)
    HPout(nobs, k) = H1(k)
      
    'Rückwärts'
    'Backward'
    
        For i = nobs To 1 Step -1
            HPout(i, k) = a(i, k) - b(i, k) * H1(k) - c(i, k) * H2(k)
    
            H2(k) = H1(k)
            H1(k) = HPout(i, k)
    
        Next i
    Next k
    
    HP = HPout
    End If
    End Function
