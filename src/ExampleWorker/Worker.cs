using ExampleClassLib;
using Newtonsoft.Json;

namespace ExampleWorker;

public class Worker : BackgroundService
{
    private readonly ILogger<Worker> _logger;

    public Worker(ILogger<Worker> logger)
    {
        _logger = logger;
    }

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        // NOTE: Example of using a class library
        var foundation = new Foundation(10, "Oak");
        var json = JsonConvert.SerializeObject(foundation);

        _logger.LogInformation("Foundation: {Json}", json);

        while (!stoppingToken.IsCancellationRequested)
        {
            if (_logger.IsEnabled(LogLevel.Information))
            {
                _logger.LogInformation("Worker running at: {time}", DateTimeOffset.Now);
            }
            await Task.Delay(1000, stoppingToken);
        }
    }
}