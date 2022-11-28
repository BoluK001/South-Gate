tableextension 50021 "Job Legder Ext" extends "Job Ledger Entry"
{
    fields
    {
        field(50000; Operation; Code[50])
        {

        }
        field(50001; "Requisition No."; Code[20])
        {

        }
        field(50002; "Service Item No."; Code[20])
        {

        }
        field(50003; "Qty. Requested"; Decimal)
        {

        }
        field(50004; "Quantity Requested"; Decimal)
        {

        }
        field(50005; "Customer Job Type"; Code[20])
        {

        }
        field(50106; "Job Type Code"; Code[20])
        {

        }
        field(50108; "Responsibility Center"; Code[20])
        {

        }
        field(50109; "Item Type"; Option)
        {
            OptionMembers = ,Spares,Lubricant,Tyres,Battery,Fuel,Others,Labour,Tyres_Accesories,Batt_Accesories;
        }
        field(50110; ItemTypeTemp; Option)
        {
            OptionMembers = ,Spares,Lubricant,Tyres,Battery,Fuel,Others,Labour,Tyres_Accesories,Batt_Accesories;
        }
        field(50111; "SERVITEMTEMP"; Code[20])
        {

        }
        field(50112; "Customer No."; Code[20])
        {

        }
        field(50113; "Posting Group"; Code[20])
        {

        }
        field(50114; "Same part usage period"; Code[20])
        {

        }


    }

}