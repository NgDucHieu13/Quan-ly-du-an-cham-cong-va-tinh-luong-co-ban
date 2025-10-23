using Microsoft.AspNetCore.Mvc;

namespace API_PM.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class DuanControllers : ControllerBase
    {
        private static readonly string[] Summaries = new[]
        {
            "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
        };

        private readonly ILogger<DuanControllers> _logger;

        public DuanControllers(ILogger<DuanControllers> logger)
        {
            _logger = logger;
        }

        [HttpGet(Name = "GetWeatherForecast")]
        public IEnumerable<DuAnControllers> Get()
        {
            return Enumerable.Range(1, 5).Select(index => new DuAnControllers
            {
                Date = DateOnly.FromDateTime(DateTime.Now.AddDays(index)),
                TemperatureC = Random.Shared.Next(-20, 55),
                Summary = Summaries[Random.Shared.Next(Summaries.Length)]
            })
            .ToArray();
        }
    }
}
