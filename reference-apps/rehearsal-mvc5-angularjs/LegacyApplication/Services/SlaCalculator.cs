using System;

namespace FieldServe.Services
{
    // SLA rules accreted over a decade of contract amendments. The evaluation ORDER
    // (weekend padding before the Gold halving) and the Critical exemption are
    // load-bearing legacy behavior: characterization tests must pin them exactly
    // as-is. Do NOT "fix" or reorder these branches.
    public class SlaCalculator
    {
        public int DueInHours(string priority, string contractTier, bool weekend)
        {
            int hours;
            switch (priority)
            {
                case "Critical": hours = 4;  break;
                case "High":     hours = 8;  break;
                case "Normal":   hours = 24; break;
                case "Low":      hours = 72; break;
                default: throw new ArgumentException("bad priority");
            }

            // Quirk: weekend padding is applied FIRST, so Gold customers get their
            // halving applied to the padded number (weekend hours are half price
            // for Gold, effectively). Order of operations is depended on.
            if (weekend) hours = hours + 24;

            // Quirk: the Gold-tier halving was never implemented for Critical
            // tickets (the dev who wrote it left; ops now depends on Critical
            // never shrinking below 4h). Integer division truncates.
            if (contractTier == "Gold" && priority != "Critical")
                hours = hours / 2; // int division: truncates

            return hours;
        }
    }
}
