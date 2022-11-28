/* report 50556 "Store issue JOBJ"
{
    DefaultLayout = RDLC;
    RDLCLayout = './StoreissueJOBJ.rdlc';

    dataset
    {
        dataitem(DataItem1000000000; Table50039)
        {
            RequestFilterFields = "Job No.", "No.";
            column(RequestDate_StoreIssueHeader; "Store Issue Header"."Posting Date")
            {
            }
            column(Location_StoreIssueHeader; "Store Issue Header".Location)
            {
            }
            dataitem(DataItem1000000021; Table210)
            {
                DataItemLink = Document No.=FIELD(No.);
                column(JobNo_JobJournalLine; "Job Journal Line"."Job No.")
                {
                }
                column(DocumentNo_JobJournalLine; "Job Journal Line"."Document No.")
                {
                }
                column(No_JobJournalLine; "Job Journal Line"."No.")
                {
                }
                column(Description_JobJournalLine; "Job Journal Line".Description)
                {
                }
                column(Quantity_JobJournalLine; "Job Journal Line".Quantity)
                {
                }
                column(UnitCostLCY_JobJournalLine; "Job Journal Line"."Unit Cost (LCY)")
                {
                }
                column(UnitPriceLCY_JobJournalLine; "Job Journal Line"."Unit Price (LCY)")
                {
                }
                column(UnitofMeasureCode_JobJournalLine; "Job Journal Line"."Unit of Measure Code")
                {
                }
                column(LocationCode_JobJournalLine; "Job Journal Line"."Location Code")
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
                VehicleReg.RESET;
                VehicleReg.SETRANGE(VehicleReg."Job Card No", "Job No.");
                IF VehicleReg.FINDFIRST THEN BEGIN
                    Engine := VehicleReg."Engine Serial Number";
                    Make := VehicleReg."Vehicle/Equipment Make";
                    Chassis := VehicleReg."Chassis No.";
                    VehRegNo := VehicleReg."Service Item";
                    Vehmodel := VehicleReg."Vehicle/Equipment Model";
                END;

                MaterialReq.RESET;
                MaterialReq.SETRANGE(MaterialReq."Job No.", "Store Issue Header"."Job No.");
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
        VehicleReg: Record "50050";
        MaterialReq: Record "50030";
        ReqNo: Code[30];
        ReqDate: Date;
}

 */