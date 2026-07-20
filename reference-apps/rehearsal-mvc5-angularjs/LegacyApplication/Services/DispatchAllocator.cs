using System;
using System.Linq;
using FieldServe.Data;

namespace FieldServe.Services
{
    // Assignment rules for the dispatch board. The silent re-assign of an already
    // assigned work order is load-bearing legacy behavior (dispatchers "bounce"
    // jobs between techs all day and rely on it never erroring); characterization
    // tests must pin it exactly as-is. Do NOT add a duplicate-assignment error.
    public class DispatchAllocator
    {
        public const int MaxActiveAssignments = 3;

        // Returns the technician's active load AFTER the assignment.
        public int Assign(string workOrderId, int technicianId)
        {
            if (Repo.FindTechnician(technicianId) == null)
                throw new ArgumentException("no such technician");

            // Quirk: assigning the SAME work order again silently re-assigns it —
            // the dictionary write below overwrites the old row, so the old slot
            // is excluded from the capacity count (no error, ever).
            int active = Repo.Assignments.Count(
                pair => pair.Value == technicianId && pair.Key != workOrderId);

            if (active >= MaxActiveAssignments)
                throw new InvalidOperationException("over capacity");

            Repo.Assignments[workOrderId] = technicianId;
            return active + 1;
        }
    }
}
