rule NjRAT_Backdoor_PE {
        meta:
                description = "Use to detect NjRAT implant."
                author = "Phatcharadol Thangplub"
                date = "14-11-2023"
                update = "21-02-2024"

        strings:
                $s1 = "<requestedExecutionLevel level=\"asInvoker\" uiAccess=\"false\"/>" nocase
                $s2 = "GetKeyboardState" nocase
                $s3 = "capGetDriverDescriptionA" nocase
                $s4 = "CompDir" nocase
                $s5 = /\/*\/& del/ nocase
                $s6 = "[ENTER]" nocase
                $s7 = "[TAB]" nocase
                $s8 = "https://dl.dropbox.com/s/p84aaz28t0hepul/Pass.exe?dl=0"

                $bytecode1 = { 72 ?? 0? 00 70 80 ?? 00 00 04 } //Primary varible initialize.
                $bytecode2 = { 6F E5 00 00 0A 6F 31 00 00 0A 72 ?? 0D 00 70 16 28 32 00 00 0A } //Compare the process name.
                $bytecode3 = { 72 ?? ?? 00 70 7E 1? 00 00 04 28 ?? 00 00 0A 17 6F 4? 00 00 0A 02 6F 4? 00 00 0A } //Delete Registry Value.

        condition:
                uint16(0) == 0x5A4D and any of ($s*) and all of ($bytecode*)
}