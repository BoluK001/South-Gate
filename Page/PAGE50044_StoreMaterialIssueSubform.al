page 50044 "Store Material Issue Subform"
{
    AutoSplitKey = true;
    Caption = 'Lines';
    PageType = ListPart;
    SourceTable = "Store Issue Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                /* field("Inventory Qty.";"Inventory Qty.")
                {
                    Style = Subordinate;
                    StyleExpr = TRUE;
                } */
                /* field("Quantity Requested";"Quantity Requested")
                {
                } */
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        //CheckPartUsageDD();
                    end;
                }
                /* field("Quantity CONSM Per Year";"Quantity CONSM Per Year")
                {
                    BlankZero = true;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = TRUE;
                } */
                field("Job No."; Rec."Job No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                /* field("Gen. Bus. Posting Group";"Gen. Bus. Posting Group")
                {
                    Editable = true;
                }
                field("Reason For Approval";"Reason For Approval")
                {
                    BlankZero = true;
                }
                field("Send To";"Send To")
                {
                }
                field("Send For Approval";"Send For Approval")
                {

                    trigger OnValidate()
                    begin
                        TESTFIELD("Send To");
                    end;
                }
                field("Approve/Reject";"Approve/Reject")
                {
                    Editable = false;
                }
                field("Approved By";"Approved By")
                {
                }
                field("Approval Date";"Approval Date")
                {
                }
                field("Reasons for Rejecting Part";"Reasons for Rejecting Part")
                {
                }
                field("Quotation Approved By";"Quotation Approved By")
                {
                    Editable = false;
                }
                field("Quotation Approval Date";"Quotation Approval Date")
                {
                    Editable = false;
                }
                field("BLocking Notification";"BLocking Notification")
                {
                    Editable = false;
                } */
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
                }
                /*  field("Vehicle Registration No.";"Vehicle Registration No.")
                 {
                 } */
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("F&unction")
            {
                Caption = 'F&unction';
                action("Get Material Req. Line")
                {
                    ApplicationArea = All;
                    Caption = 'Get Material Req. Line';
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';

                    trigger OnAction()
                    begin
                        /// ShowDimensions;
                    end;
                }
                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    action("Event")
                    {
                        ApplicationArea = All;
                        Caption = 'Event';

                        trigger OnAction()
                        begin
                            //ItemAvailFormsMgt.ShowItemAvailFromMatReqLine(Rec,ItemAvailFormsMgt.ByEvent)
                        end;
                    }
                    action(Period)
                    {
                        ApplicationArea = All;
                        Caption = 'Period';

                        trigger OnAction()
                        begin
                            //ItemAvailFormsMgt.ShowItemAvailFromMatReqLine(Rec,ItemAvailFormsMgt.ByPeriod);
                        end;
                    }
                    action(Variant)
                    {
                        ApplicationArea = All;
                        Caption = 'Variant';

                        trigger OnAction()
                        begin
                            //ItemAvailFormsMgt.ShowItemAvailFromMatReqLine(Rec,ItemAvailFormsMgt.ByVariant);
                        end;
                    }
                    action(Location)
                    {
                        ApplicationArea = All;
                        Caption = 'Location';

                        trigger OnAction()
                        begin
                            //ItemAvailFormsMgt.ShowItemAvailFromMatReqLine(Rec,ItemAvailFormsMgt.ByLocation);
                        end;
                    }
                }
            }
        }
    }

    var
        ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";

    procedure UpdateSubform()
    begin
        CurrPage.UPDATE(FALSE);
    end;
}

