using System.Text.Json.Nodes;

namespace MrJB.Debezium.Domain.Models.CDC;

public class CdcEvent
{
    public CdcSchema? Schema { get; set; }

    public CdcPayload? Payload { get; set; }

    public IEnumerable<CdcField>? Fields { get; set; }

    public class CdcSchema
    {
        public string? Type { get; set; }

        public bool Optional { get; set; }

        public string? Name { get; set; }
    }

    public class CdcPayload
    {
        public JsonObject? Before { get; set; }

        public JsonObject? After { get; set; }

        public CdcSource? Source { get; set; }

        public class CdcSource
        {
            public string? Name { get; set; }

            public string? Version { get; set; }

            public string? Connector { get; set; }

            public string? Snapshot { get; set; }

            public string? Schema { get; set; }

            public string? Table { get; set; }
        }
    }

    public class CdcField
    {
        public string? Type { get; set; }

        public string? Name { get; set; }

        public bool Optional { get; set; }

        public string? Version { get; set; }
    }
}
