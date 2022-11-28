page 50026 "Job Material Request Subform"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    PageType = ListPart;
    SourceTable = "Material Request Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //ERROR('YOU CANNOT ADD AN ITEM TO THE MATERIAL ISSUE, ADD FROM JOB PLNNING LINES');
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    Editable = false;
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Quantity in Inventory"; Rec."Quantity in Inventory")
                {
                    ApplicationArea = All;
                }
                field("Qty on Purch. Order"; Rec."Qty on Purch. Order")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Job No."; Rec."Job No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Planning Line GBPG"; Rec."Planning Line GBPG")
                {
                    ApplicationArea = All;
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                }
                field("Service Item"; Rec."Service Item")
                {
                    /// BlankZero = true;
                     ApplicationArea = All;
                }
                field("Approve/Reject"; Rec."Approve/Reject")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Send To"; Rec."Send To")
                {
                    ApplicationArea = All;
                }
                field(Sender; Rec.Sender)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Send For Approval"; Rec."Send For Approval")
                {
                    ApplicationArea = All;
                }
                field("Sent Date"; Rec."Sent Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Approved By"; Rec."Approved By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Reasons for Rejecting Part"; Rec."Reasons for Rejecting Part")
                {
                    ApplicationArea = All;
                }
                field("Quantity CONSM Per Year"; Rec."Quantity CONSM Per Year")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Quotation Approved By"; Rec."Quotation Approved By")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Quotation Approval Date"; Rec."Quotation Approval Date")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Vehicle Registration No."; Rec."Vehicle Registration No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                action(Dimension)
                {
                    Caption = 'Dimension';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions;
                    end;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        //ERROR('YOU CANNOT ADD TO THE MATERIAL REQUEST, ADD FROM JOB PLNNING LINES');
    end;

    var
        ItemNoEnable: Boolean;
        MaterialReqHeader: Record "Material Request Header";

    procedure UpdateSubform()
    begin
        CurrPage.Update(false);
    end;
}

