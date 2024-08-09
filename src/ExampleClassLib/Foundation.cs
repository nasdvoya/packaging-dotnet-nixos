namespace ExampleClassLib;

public class Foundation
{
    public int FoundationSize { get; set; }
    public string FoundationName { get; set; }

    public Foundation(int foundationSize, string foundationName)
    {
        this.FoundationSize = foundationSize;
        this.FoundationName = foundationName;
    }
}