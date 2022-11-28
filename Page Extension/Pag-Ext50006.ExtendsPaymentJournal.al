pageextension 50006 "Extends Payment Journal" extends "Payment Journal"
{
    layout
    {
        addafter("Currency Code")
        {

            field("Job No."; Rec."Job No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the number of the related job.';
            }
            field("Job Quantity"; Rec."Job Quantity")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the quantity for the job ledger entry that is derived from posting the journal line. If the Job Quantity is 0, the total amount on the job ledger entry will also be 0.';
            }
            field("Job Task No."; Rec."Job Task No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the number of the related job task.';
            }
        }
    }
}
