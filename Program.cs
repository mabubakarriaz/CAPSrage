

Console.WriteLine("CAPS rage started.");

string line = string.Empty;

while (true)
{
    Console.Write("Write: ");
    line = Console.ReadLine();

    if (line.ToLower() == "exit")
    {
        break;
    }

    Console.Write("RAGE: ");
    Console.WriteLine(line.ToUpper());
}

Console.WriteLine("CAPS rage ended.");
Console.ReadKey();