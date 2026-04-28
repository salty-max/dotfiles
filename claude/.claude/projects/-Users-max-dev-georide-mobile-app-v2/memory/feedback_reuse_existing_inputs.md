---
name: Reuse existing input components for data display/editing
description: Use PhoneField, DatePicker, etc. instead of plain text when displaying editable data
type: feedback
originSessionId: a72f2b4a-d55c-4af0-95e6-14873a4232f0
---
When displaying data that has a dedicated input component (PhoneField, DatePickerSheet, country picker), always use that component — even in read-only contexts where it could switch to edit mode. Don't downgrade to plain `<Text>` display.

**Why:** The SOS personal info section displayed the phone number as plain text instead of using PhoneField with the country code picker and OTP verification. The user expects consistent editing UX across the app.

**How to apply:** Check what input components exist for a data type before rendering it. Phone → PhoneField. Date → DatePickerSheet via InfoRow onPress. If the same data is editable in the profile, the SOS/theft-assistance sheets should use the same components.
