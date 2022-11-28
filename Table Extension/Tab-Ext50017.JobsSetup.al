tableextension 50017 JobsSetup extends "Jobs Setup"
{
    fields
    {
        field(50000; "Registaration ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50001; "Same part usage period"; DateFormula) { DataClassification = ToBeClassified; }
        field(50002; "Same part usage period@"; Boolean) { DataClassification = ToBeClassified; }
        field(50003; "Jobs PO Activated"; Boolean) { DataClassification = ToBeClassified; }
        field(50004; "Job Preventive Maint. Activate"; Boolean) { DataClassification = ToBeClassified; }
        field(50005; "Fuel Cost per KM Cons. Ratio"; Decimal) { DataClassification = ToBeClassified; }
        field(50006; "Fuel Cost"; Decimal) { DataClassification = ToBeClassified; }
        field(50007; "JobTime Sheet"; Code[15]) { DataClassification = ToBeClassified; }
        field(50008; "Email to copy For Spares"; Text[250]) { DataClassification = ToBeClassified; }
        field(50009; "Period Start for Items"; Date) { DataClassification = ToBeClassified; }
        field(50010; "Period End for Items"; Date) { DataClassification = ToBeClassified; }
        field(50011; "Email to copy 4 Tyres/Battery"; Text[250]) { DataClassification = ToBeClassified; }
        field(50012; "Email to copy For Spares(STR)"; Text[250]) { DataClassification = ToBeClassified; }
        field(50013; "Email to copy 4 Tyres/Batt(STR"; Text[250]) { DataClassification = ToBeClassified; }
        field(50014; "Items Planning Lines Benchmark"; Decimal) { DataClassification = ToBeClassified; }
        field(50015; "Period End for Items 3M"; Date) { DataClassification = ToBeClassified; }

    }
}
