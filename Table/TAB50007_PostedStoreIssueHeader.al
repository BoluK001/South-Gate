table 50007 "Posted Store Issue Header"
{
    Caption = 'Posted Store Issue Header';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Description 2"; Text[50])
        {
        }
        field(4; "Request Date"; Date)
        {
        }
        field(5; Location; Code[20])
        {
            /// TableRelation = Location WHERE (Use As In-Transit=CONST(No));
        }
        field(6; "Expected Receipt Date"; Date)
        {
            Caption = 'Expected Receipt Date';
        }
        field(7; "Requested Receipt Date"; Date)
        {
            Caption = 'Requested Receipt Date';
        }
        field(8; "Requested By"; Code[50])
        {
            Editable = false;
        }
        field(9; "Requested By Name"; Text[50])
        {
            Editable = false;
        }
        field(10; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(11; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(12; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(13; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(14; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(15; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
        }
        field(16; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));
        }
        field(17; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));
        }
        field(18; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));
        }
        field(19; "Job No."; Code[20])
        {
            TableRelation = Job;
        }
        field(20; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Job No."));
        }
        field(21; "Created By"; Code[50])
        {
        }
        field(22; "Created Date"; Date)
        {
            Editable = false;
        }
        field(23; "Created Time"; Time)
        {
            Editable = false;
        }
        field(24; "Modified By"; Code[50])
        {
            Editable = false;
        }
        field(25; "Modified Date"; Date)
        {
            Editable = false;
        }
        field(26; "Modified Time"; Time)
        {
            Editable = false;
        }
        field(27; "Released Date"; Date)
        {
        }
        field(28; "Released By"; Code[50])
        {
        }
        field(29; "Material Request No."; Code[20])
        {
            TableRelation = IF ("Request Type" = CONST(Job)) "Material Request Header" WHERE("Request Type" = CONST(Job)) ELSE
            IF ("Request Type" = CONST(Inventory)) "Material Request Header" WHERE("Request Type" = CONST(Internal));
        }
        field(30; "Responsibility Center"; Code[20])
        {
            /// TableRelation = "Responsibility Center BR";

            trigger OnValidate()
            begin
                /*TESTFIELD(Status,Status::Open);
                IF NOT UserMgt.CheckRespCenter(1,"Responsibility Center") THEN
                  ERROR(
                    Text001,
                        RespCenter.TABLECAPTION,UserMgt.GetPurchasesFilter);
                */

            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(481; "Request Type"; Option)
        {
            OptionCaption = 'Job,Inventory';
            OptionMembers = Job,Inventory;
        }
        field(482; Status; Option)
        {
            OptionCaption = 'Open,Released,Pending Approval';
            OptionMembers = Open,Released,"Pending Approval";
        }
        field(483; Amount; Decimal)
        {
            ///  CalcFormula = Sum("Posted Store Issue Line".Amount WHERE (Document No.=FIELD(No.)));
            FieldClass = FlowField;
        }
        field(484; "Entry Type"; Option)
        {
            OptionCaption = 'Issue,Return';
            OptionMembers = Issue,Return;
        }
        field(485; "Pre Assigned No."; Code[20])
        {
        }
        field(486; "Posted By"; Code[50])
        {
        }
        field(487; "Posted Date"; Date)
        {
        }
        field(488; "Posted Time"; Time)
        {
        }
        field(489; "Customer Job Type"; Code[20])
        {
            //TableRelation = "Customer Job Type";
        }
        field(490; "Job Type Code"; Code[20])
        {
            //TableRelation = "Job Type Code"."Job Type Code" WHERE("Customer Job Type" = FIELD("Customer Job Type"));
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        UserMgt: Codeunit "User Setup Management";
        RespCenter: Record "Responsibility Center";
}

