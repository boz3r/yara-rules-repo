rule AsyncRAT_Backdoor_PE {
        meta:
                description = "Use to detect AsyncRAT implant."
                author = "Phatcharadol Thangplub"
                date = "12-11-2023"
                update = "21-02-2024"

        strings:
                $s1 = "Pac_ket"
                $s2 = "Po_ng"
                $s3 = "plu_gin"
                $s4 = "save_Plugin"

                $bytecode1 = { 72 ?? ?? ?? 70 80 05 00 00 04 } //Install folder varible initialize.
                $bytecode2 = { 28 35 00 00 06 } //Registry Persistence function call.
                $bytecode3 = { 28 45 00 00 06 } //Anti Analysis function call.
                $bytecode4 = { 09 72 ?? ?? ?? 70 28 3C 00 00 06 39 06 00 00 00 } //Check for anti process.
                $bytecode5 = { 28 3D 00 00 06 } //Process Killer function call.
                $bytecode6 = { 28 28 00 00 06 } //AMSI Bypass function call.
                $bytecode7 = { 28 67 00 00 0A 72 ?? 13 00 70 28 1C 00 00 0A 6F 1D 00 00 0A 0? 12 0? 28 2C 00 00 06 } //Load amsi.dll, and get AmsiScanBuffer function process.

        condition:
                uint16(0) == 0x5A4D and any of ($s*) or 5 of ($bytecode*)
}
