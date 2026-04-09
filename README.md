# StructQueueCrash

Minimal SPM project that reliably reproduces the Swift crash you get when you try to "make a struct thread-safe" by giving it an internal `DispatchQueue`.

Change structs to final class to fix crashes.
