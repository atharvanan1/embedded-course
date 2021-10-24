ENTRY(Reset_Handler)

MEMORY
{
	FLASH (rx) : ORIGIN = 0x00000000, LENGTH = 128K
	RAM (rwx) : ORIGIN = 0x40000000, LENGTH = 128M
}

SECTIONS {
	.text : 
	{ 
		_text = .;
		KEEP(*(.text.boot))
		*(.text .text.* .gnu.linkonce.t*)
		*(.rodata*)
		_etext = .;
        } > FLASH

	.data :
	{
		_data = .;
		*(.data*)
		_edata = .;
	} > RAM AT > FLASH

	.bss (NOLOAD) :
	{
		_bss = .;
		*(.bss*)
		*(COMMON)
		_ebss = .;
	} > RAM
	_end = .;
}
_bss_size = (_ebss - _bss)>>3;
