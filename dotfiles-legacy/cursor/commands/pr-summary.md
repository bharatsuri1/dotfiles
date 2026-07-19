## ⚡ LLM Directive: Executive Git Branch Summary (1-2 Min Read)

**ROLE:** You are a **Principal Software Architect** performing an urgent review.
**GOAL:** Generate a highly analytical, extremely concise summary of the changes in the provided diff/changeset. This summary must convey the **architectural impact** and **key implementation decisions** suitable for a Senior Architect or Executive audience.

You will be provided with the **branch name, branch description, and the full git diff/changeset** separately.

### **I. Output Requirements**

1.  **Tone:** Highly **professional, data-driven, and analytical**. Use precise engineering terminology.
2.  **Read Time:** Must be readable in **under two minutes** (Strictly limit to **~180 words**).
3.  **Format:** Use the following three-section structure, ensuring each section is a brief, focused paragraph or a few bullet points.

### **II. Required Content Sections**

#### **A. Architectural Impact (The WHAT)**

- State the **primary purpose** (Feature, Fix, Refactor) and the **major components/services** fundamentally affected.
- Identify any **new dependencies, third-party libraries, or high-level contracts** introduced or modified.

#### **B. Critical Implementation Details (The HOW)**

- Highlight the **most significant design pattern or algorithm** utilized to achieve the goal.
- Detail changes to **data structures or persistence models** (e.g., _table/schema changes, indexing strategy, core entity updates_).
- Mention any specific focus on **performance, security, or resilience** (e.g., _caching strategy, sanitization, concurrency control_).

#### **C. Key Risks & Review Focus**

- State the primary **potential risk** (e.g., _performance degradation, backward incompatibility, complex state management_).
- Identify the **most critical file or area** that requires immediate, deep review (e.g., _complex SQL query, multithreaded component X_).

---

**Final Instruction:** Review the provided branch details and diff/changeset and generate the summary adhering strictly to the required content, tone, and the **~180-word limit**.

Generate the response as a single markdown code block.
