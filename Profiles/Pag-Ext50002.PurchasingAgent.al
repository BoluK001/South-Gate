pageextension 50002 PurchasingAgent extends "Purchasing Agent Role Center"
{
    actions
    {
        addafter("Posted Documents")
        {
            group("Material Requisitions")
            {
                action("Job Material Requests")
                {
                    RunObject = page "Job Material Request List";
                    ApplicationArea = All;
                }
                action("Job Material Returns")
                {
                    RunObject = page "Job Material Return List";
                    ApplicationArea = All;
                }
                action("Store Material Issue List")
                {
                    RunObject = page "Store Material Issue List";
                    ApplicationArea = All;
                }
                action("Store Material Returns List")
                {
                    RunObject = page "Store Material Return List";
                    ApplicationArea = All;
                }
                
            }

        }
    }
}
