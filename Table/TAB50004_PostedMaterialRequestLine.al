table 50004 "Posted Material Request Line"
{

    fields
    {
        field(1; "Document No."; Code[20])
        {
        }
        field(2; "Request Type"; Option)
        {
            OptionCaption = 'Project,Internal';
            OptionMembers = Job,Internal;
        }
        field(3; "Line No."; Integer)
        {
        }
        field(4; "Item No."; Code[20])
        {
            TableRelation = Item;
        }
        field(5; "Item Category Code"; Code[20])
        {
            TableRelation = "Item Category";
        }
        field(6; "Product Group Code"; Code[20])
        {
            TableRelation = "Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
        }
        field(7; "Variant Code"; Code[20])
        {
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(8; Description; Text[100])
        {
        }
        field(9; "Unit of Measure Code"; Code[20])
        {
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(10; Quantity; Decimal)
        {

            trigger OnValidate()
            begin
                TESTFIELD("Item No.");
            end;
        }
        field(11; "Unit Cost"; Decimal)
        {
        }
        field(12; "Inventory Posting Group"; Code[20])
        {
            TableRelation = "Inventory Posting Group";
        }
        field(13; "Gen. Prod. Posting Group"; Code[20])
        {
            TableRelation = "Gen. Product Posting Group";
        }
        field(16; "Request Date"; Date)
        {
        }
        field(17; "Location Code"; Code[20])
        {
            /// TableRelation = Location.Code WHERE (Use As In-Transit=FILTER(No));
        }
        field(18; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(19; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
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
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
        }
        field(23; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));
        }
        field(24; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));
        }
        field(25; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));
        }
        field(26; Status; Option)
        {
            OptionCaption = 'Open,Released';
            OptionMembers = Open,Released;
        }
        field(27; "Applies-to Entry"; Integer)
        {
        }
        field(28; "Available Quantity"; Decimal)
        {
            /// CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE (Item No.=FIELD(Item No.), Location Code=FIELD(Location Code)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(29; "Line Amount"; Decimal)
        {
        }
        field(30; Type; Option)
        {
            OptionCaption = ' ,Item';
            OptionMembers = " ",Item;
        }
        field(31; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job;
        }
        field(32; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Job No."));
        }
        field(33; "Customer Job Type"; Code[20])
        {
            //TableRelation = "Customer Job Type";
        }
        field(34; "Job Type Code"; Code[20])
        {
            //TableRelation = "Job Type Code"."Job Type Code" WHERE("Customer Job Type" = FIELD("Customer Job Type"));
        }
        field(491; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(50008; "Unblock Usage"; Boolean)
        {
        }
        field(50017; "Allow Approved Usage"; Boolean)
        {
            Description = 'BLOCKING';
        }
        field(50018; "User ID- BLocked Item Removed"; Code[50])
        {
            Description = 'BLOCKING';
        }
        field(50019; "BLocking Notification"; Boolean)
        {
            Description = 'BLOCKING';
        }
        field(50020; "Last Inv Doc"; Code[30])
        {
            Description = 'BLOCKING';
            TableRelation = Job;
        }
        field(50021; "Last Inv Date"; Date)
        {
            Description = 'BLOCKING';
        }
        field(50022; "Unblock-Approver"; Code[50])
        {
            Description = 'BLOCKING';
            TableRelation = "User Setup";
        }
        field(50082; "Cost Amount"; Decimal)
        {
        }
        field(50083; "Send To"; Code[50])
        {
            Description = 'BLOCKING';
            ///  TableRelation = "User Setup"."User ID" WHERE (Expired Items UnBlock Mgr=CONST(Yes));
        }
        field(50084; Sender; Code[50])
        {
            Description = 'BLOCKING';
        }
        field(50085; "Send For Approval"; Option)
        {
            Description = 'BLOCKING';
            OptionCaption = ' ,Send,Re-Send';
            OptionMembers = " ",Send,"Re-Send";
        }
        field(50086; "Sent Date"; DateTime)
        {
            Description = 'BLOCKING';
        }
        field(50087; "Approve/Reject"; Option)
        {
            Description = 'BLOCKING';
            OptionMembers = " ",Approved,Reject;
        }
        field(50088; "Approved By"; Code[50])
        {
            Description = 'BLOCKING';
        }
        field(50089; "Approval Date"; DateTime)
        {
            Description = 'BLOCKING';
        }
        field(50090; "Reasons for Rejecting Part"; Text[250])
        {
        }
        field(50091; "Quantity CONSM Per Year"; Decimal)
        {
            BlankZero = true;
        }
        field(50092; "Reason For Approval"; Option)
        {
            OptionCaption = '  ,SparePart Requesting is More Than Yearly Def. Qty,SparePart Issued + Qty Requesting is More than Yearly Def. Qty,SparePart Requested has already Exceeded the Yearly Def. Qty,SparePart Requesting has been Collected within the Last 6M/1Yr';
            OptionMembers = "  ","SparePart Requesting is More Than Yearly Def. Qty","SparePart Issued + Qty Requesting is More than Yearly Def. Qty","SparePart Requested has already Exceeded the Yearly Def. Qty","SparePart Requesting has been Collected within the Last 6M/1Yr";
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text001: Label 'You cannot request more than %1 quantity of %2  in Job No.%3 , Task No. %4';
}

