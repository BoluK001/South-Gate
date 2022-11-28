report 50003 "Store issue 22"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Storeissue22.rdlc';

    dataset
    {
        dataitem(DataItem1000000000; "Store Issue Header")
        {
            RequestFilterFields = "Job No.", "No.";
            column(RequestDate_StoreIssueHeader; "Posting Date")
            {
            }
            column(Location_StoreIssueHeader; Location)
            {
            }
            dataitem(DataItem1000000001; "Store Issue Line")
            {
                DataItemLink = "Document No." = FIELD("No.");
                column(UnitofMeasureCode_StoreIssueLine; "Unit of Measure Code")
                {
                }
                column(DocumentNo_StoreIssueLine; "Document No.")
                {
                }
                column(ItemNo_StoreIssueLine; "Item No.")
                {
                }
                column(LocationCode_StoreIssueLine; "Location Code")
                {
                }
                column(Description_StoreIssueLine; Description)
                {
                }
                column(Quantity_StoreIssueLine; Quantity)
                {
                }
                column(OutstandingQuantity_StoreIssueLine; "Outstanding Quantity")
                {
                }
                column(UnitCost_StoreIssueLine; "Unit Cost")
                {
                }
                column(JobNo_StoreIssueLine; "Job No.")
                {
                }
                column(Engine; Engine)
                {
                }
                column(Chassis; Chassis)
                {
                }
                column(Make; Make)
                {
                }
                column(Model; Model)
                {
                }
                column(VehRegNo; VehRegNo)
                {
                }
                column(Vehmodel; Vehmodel)
                {
                }
                column(ReqNo; ReqNo)
                {
                }
                column(ReqDate; ReqDate)
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
               /*  VehicleReg.RESET;
                VehicleReg.SETRANGE(VehicleReg."Job Card No", "Job No.");
                IF VehicleReg.FINDFIRST THEN BEGIN
                    Engine := VehicleReg."Engine Serial Number";
                    Make := VehicleReg."Vehicle/Equipment Make";
                    Chassis := VehicleReg."Chassis No.";
                    VehRegNo := VehicleReg."Service Item";
                    Vehmodel := VehicleReg."Vehicle/Equipment Model";
                END; */

                MaterialReq.RESET;
                MaterialReq.SETRANGE(MaterialReq."Job No.", "Job No.");
                IF MaterialReq.FINDFIRST THEN BEGIN
                    ReqNo := MaterialReq."No.";
                    ReqDate := MaterialReq."Request Date";
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Engine: Code[20];
        Chassis: Code[20];
        Make: Code[20];
        Model: Code[20];
        VehRegNo: Code[30];
        Vehmodel: Code[30];
        //VehicleReg: Record "50050";
        MaterialReq: Record 50001;
        ReqNo: Code[30];
        ReqDate: Date;
}

