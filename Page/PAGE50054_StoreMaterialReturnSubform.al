page 50054 "Store Material Return Subform"
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
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; "Description 2")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = All;
                }
                /*  field("Inventory Qty.";"Inventory Qty.")
                 {
                     Style = Subordinate;
                     StyleExpr = TRUE;
                 } */
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field("Job No."; "Job No.")
                {
                    ApplicationArea = All;
                }
                field("Job Task No."; "Job Task No.")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; "Item Category Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Product Group Code"; "Product Group Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Inventory Posting Group"; "Inventory Posting Group")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code"; "Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; "Unit Cost")
                {
                    ApplicationArea = All;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                /* field("Gen. Bus. Posting Group";"Gen. Bus. Posting Group")
                {
                } */
                /*   field("Applies from Item Entry";"Applies from Item Entry")
                  {
                  } */
                field("Request Date"; "Request Date")
                {
                    ApplicationArea = All;
                }
                /* field("Appl.-to Item Entry";"Appl.-to Item Entry")
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

