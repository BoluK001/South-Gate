table 50003 "Posted Material Request Header"
{

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Request Type"; Option)
        {
            Editable = false;
            OptionCaption = 'Project,Internal';
            OptionMembers = Job,Internal;
        }
        field(3; "Request Date"; Date)
        {
        }
        field(4; Status; Option)
        {
            OptionCaption = 'Open,Released,Pending Approval';
            OptionMembers = Open,Released,"Pending Approval";
        }
        field(5; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(6; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Job No."));
        }
        field(7; Comment; Boolean)
        {
        }
        field(8; "Location Code"; Code[20])
        {
            /// TableRelation = Location.Code WHERE (Use As In-Transit=FILTER(No));
        }
        field(9; "No. Series"; Code[20])
        {
        }
        field(10; "Created By"; Code[50])
        {
        }
        field(11; "Created Date"; Date)
        {
            Editable = false;
        }
        field(12; "Created Time"; Time)
        {
            Editable = false;
        }
        field(13; "Modified By"; Code[50])
        {
            Editable = false;
        }
        field(14; "Modified Date"; Date)
        {
            Editable = false;
        }
        field(15; "Modified Time"; Time)
        {
            Editable = false;
        }
        field(16; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(18; "Released Date"; Date)
        {
        }
        field(19; "Released By"; Code[50])
        {
        }
        field(20; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(21; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(22; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
        }
        field(23; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));
        }
        field(24; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));
        }
        field(25; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));
        }
        field(26; "Requested By"; Code[50])
        {
        }
        field(27; "Requested Name"; Text[50])
        {
        }
        field(28; "Customer Job Type"; Code[20])
        {
            //TableRelation = "Customer Job Type";
        }
        field(29; "Job Type Code"; Code[20])
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
}

