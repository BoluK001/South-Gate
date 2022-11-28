tableextension 50004 PurchRcptLine extends "Purch. Rcpt. Line"
{
    fields
    {
        field(50000; "Purch. Request No."; Code[20])
        {
            Caption = 'Purch. Request No.';
            DataClassification = ToBeClassified;
        }
    }
}
