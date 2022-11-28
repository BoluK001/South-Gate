tableextension 50003 PurchaseLineExt extends "Purchase Line"
{
    fields
    {

        field(50010; "Import File No."; Code[20])
        {
            Description = 'UNLIP 2.0';
        }
        field(50011; "Type - Charge Invoice"; Option)
        {
            Description = 'UNLIP 2.0';
            OptionCaption = ' ,Charge (Item)';
            OptionMembers = " ","Charge (Item)";

            trigger OnValidate()
            var
                PurchHeader: Record "Purchase Header";
            begin
                GetPurchHeader;
                PurchHeader.TESTFIELD("Import File No.");
                IF "Type - Charge Invoice" = "Type - Charge Invoice"::" " THEN
                    VALIDATE(Type, Type::" ")
                ELSE BEGIN
                    VALIDATE(Type, Type::"Charge (Item)");
                    VALIDATE(Quantity, 1);
                END;
            end;
        }
        field(50048; "WHTax%"; Decimal)
        {

            trigger OnValidate()
            begin
                WHTaxAmt := "WHTax%" * Quantity * "Direct Unit Cost" * 0.01;
            end;
        }
        field(50049; WHTaxAmt; Decimal)
        {

            trigger OnValidate()

            var
                Currency: record Currency;

            begin
                "WHTax%" := ROUND(WHTaxAmt / (Quantity * "Direct Unit Cost"), Currency."Amount Rounding Precision") * 100;
            end;
        }
        field(50050; "Purch. Request No."; Code[20])
        {
        }
        field(61002; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(61003; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
        field(61004; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(5, "Shortcut Dimension 5 Code");
            end;
        }
        field(61005; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(6, "Shortcut Dimension 6 Code");
            end;
        }
        field(61006; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(7, "Shortcut Dimension 7 Code");
            end;
        }
        field(61007; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(8, "Shortcut Dimension 8 Code");
            end;
        }
        field(90001; "Job Task2"; Code[10])
        {
            // CalcFormula = Lookup("PO Line Jan"."Task No." WHERE("Job No."=FIELD("Job No."),
            //                                                      Decsription=FIELD(Description)));
            // FieldClass = FlowField;
        }
    }
}
