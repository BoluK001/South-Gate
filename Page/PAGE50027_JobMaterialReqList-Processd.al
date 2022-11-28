page 50027 "Job Material Req List-Processd"
{
    CardPageID = "Job Material Request";
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    AdditionalSearchTerms = 'Job Material Req List-Processd';
    SourceTable = "Material Request Header";
    SourceTableView = WHERE("Request Type" = CONST(Job),
                            Status = filter(Released));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Request Type"; Rec."Request Type")
                {
                    ApplicationArea = All;
                }
                field("Request Date"; Rec."Request Date")
                {
                    ApplicationArea = All;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

