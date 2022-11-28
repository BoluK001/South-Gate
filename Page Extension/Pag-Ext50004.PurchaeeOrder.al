pageextension 50004 PurchaeeOrder extends "Purchase Order"
{
    layout
    {
        addafter("Vendor Cr. Memo No.")
        {

            field("Prepayment No."; Rec."Prepayment No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Prepayment No. field.';
            }
            field("Prepayment No. Series"; Rec."Prepayment No. Series")
            {
                ApplicationArea = all;
            }
        }
    }
}
