report 50002 "posted Store Issue"
{
    DefaultLayout = RDLC;
    RDLCLayout = './postedStoreIssue.rdlc';

    dataset
    {
        dataitem(DataItem1000000000; 50007)
        {
            RequestFilterFields = "No.", "Job No.";
            column(No_PostedStoreIssueHeader; "No.")
            {
            }
            column(RequestDate_PostedStoreIssueHeader; "Request Date")
            {
            }
            column(Location_PostedStoreIssueHeader; Location)
            {
            }
            column(RequestedBy_PostedStoreIssueHeader; "Requested By")
            {
            }
            column(RequestedByName_PostedStoreIssueHeader; "Requested By Name")
            {
            }
            column(JobNo_PostedStoreIssueHeader; "Job No.")
            {
            }
            column(MaterialRequestNo_PostedStoreIssueHeader; "Material Request No.")
            {
            }
            dataitem(DataItem1000000001; 50008)
            {
                DataItemLink = "Document No." = FIELD("No."),
                               "Job No." = FIELD("Job No.");
                column(UnitofMeasureCode_PostedStoreIssueLine; "Unit of Measure Code")
                {
                }
                column(UnitCost_PostedStoreIssueLine; "Unit Cost")
                {
                }
                column(QuantityInvoiced_PostedStoreIssueLine; "Quantity Invoiced")
                {
                }
                column(QuantityRequested_PostedStoreIssueLine; "Quantity Requested")
                {
                }
                column(DocumentNo_PostedStoreIssueLine; "Document No.")
                {
                }
                column(ItemNo_PostedStoreIssueLine; "Item No.")
                {
                }
                column(Description_PostedStoreIssueLine; Description)
                {
                }
                column(Quantity_PostedStoreIssueLine; Quantity)
                {
                }
                column(OutstandingQuantity_PostedStoreIssueLine; "Outstanding Quantity")
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
                /* VehicleReg.RESET;
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
        //VehicleReg: Record 50050;
        MaterialReq: Record 50001;
        ReqNo: Code[30];
        ReqDate: Date;
}

