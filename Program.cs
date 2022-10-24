
// app started
Console.WriteLine("CAPS rage started.");

string line = string.Empty;

while (true)
{
    Console.Write("Write: ");
    line = Console.ReadLine();

    // exit the program
    if (line.ToLower() == "exit")
    {
        break;
    }

    // output
    Console.Write("RAGE: ");
    Console.WriteLine(line.ToUpper());
}

Console.WriteLine("CAPS rage ended.");
Console.ReadKey();