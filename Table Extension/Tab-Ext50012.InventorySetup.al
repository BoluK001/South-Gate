tableextension 50012 InventorySetup extends "Inventory Setup"
{
    fields
    {
        field(50000; "Material Requisition Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50001; "Issues Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50002; "Material Return Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50003; "Material Receipt Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50004; "Transfer Requisition No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50005; "Internal Requsition No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50006; "Estimate No."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50050; "Material Request Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50051; "Material Return Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50052; "Posted Material Issue"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50053; "NonStock Transfer Order No.s"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50054; "Aggregate Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50055; "Posted Aggregate Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50056; "Transfer Order Nos. (VOR)"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(60000; "Item Jnl Template"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(60001; "Item Jnl Batch"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(60002; "Store Issue Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(60003; "Store Return Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(60004; "Effective VOR Time"; Time)
        {
            TableRelation = "No. Series";
        }
        field(60005; "OpLeasing Approval Email"; Text[70])
        {
            TableRelation = "No. Series";
        }
        field(60006; "Hermes Activated"; Boolean)
        {
            TableRelation = "No. Series";
        }
        field(60007; "Engine Transfer Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(60008; "Swap Card Nos"; code[20])
        {
            TableRelation = "No. Series";
        }
        field(60009; "Item Journal Nos"; code[20])
        {
            TableRelation = "No. Series";
        }
        field(60010; "Item Batch Nos"; code[20])
        {
            TableRelation = "No. Series";
        }
    }
}
