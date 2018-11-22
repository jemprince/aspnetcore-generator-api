using api.Controllers;
using System.Linq;
using Xunit;


namespace tests
{

    public class RangeTests
    {
        [Fact]
        public void CountShouldControlNumberOfResults()
        {
            var range = new Range{ Count = 3 };
            var generated = range.Of(() => "");
            Assert.Equal(3, generated.Count());
        }
        [Fact]
        public void SortShouldOrderResults()
        {
            var range = new Range { Count = 3 };
            var values = new[] { "a", "b", "c" };
            var counter = 0;
            var generated = range.Of(() => values[counter++]);
            Assert.Equal(new[] { "a", "c", "c" }, generated.ToArray());
        }
    }
}
