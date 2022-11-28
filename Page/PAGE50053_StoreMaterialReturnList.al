page 50053 "Store Material Return List"
{
    Caption = 'Store Material Return List';
    CardPageID = "Store Material Return";
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Store Issue Header";
    SourceTableView = WHERE("Entry Type" = FILTER(Return));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
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
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Description 2"; "Description 2")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Location; Location)
                {
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; "Expected Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Requested Receipt Date"; "Requested Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Requested By"; "Requested By")
                {
                    ApplicationArea = All;
                }
                field("Requested By Name"; "Requested By Name")
                {
                    ApplicationArea = All;
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
                field("Shortcut Dimension 4 Code"; "Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control19; Notes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    var
    ///   UserMgt: Codeunit "User Setup Management";
}

