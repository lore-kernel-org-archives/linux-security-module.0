From: mkayaalp@linux.vnet.ibm.com (Mehmet Kayaalp)
Date: Thu, 20 Apr 2017 18:28:38 -0400
Subject: [PATCH v4 2/4] KEYS: Add ELF class-independent certificate insertion
	support
In-Reply-To: <1492727320-26194-1-git-send-email-mkayaalp@linux.vnet.ibm.com>
References: <1492727320-26194-1-git-send-email-mkayaalp@linux.vnet.ibm.com>
Message-ID: <1492727320-26194-3-git-send-email-mkayaalp@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Use ELF class-independent GElf API for processing the kernel binary. This
patch adds support for compiling the script for 64-bit and the kernel for
32-bit (e.g. make ARCH=i386 on x86-64).

Signed-off-by: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
---
 scripts/Makefile          |   1 +
 scripts/insert-sys-cert.c | 215 +++++++++++++++++++++++-----------------------
 2 files changed, 109 insertions(+), 107 deletions(-)

diff --git a/scripts/Makefile b/scripts/Makefile
index 1d80897..5633f2c 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -25,6 +25,7 @@ HOSTCFLAGS_sortextable.o = -I$(srctree)/tools/include
 HOSTCFLAGS_asn1_compiler.o = -I$(srctree)/include
 HOSTLOADLIBES_sign-file = -lcrypto
 HOSTLOADLIBES_extract-cert = -lcrypto
+HOSTLOADLIBES_insert-sys-cert = -lelf
 
 always		:= $(hostprogs-y) $(hostprogs-m)
 
diff --git a/scripts/insert-sys-cert.c b/scripts/insert-sys-cert.c
index 8902836..86a3d41 100644
--- a/scripts/insert-sys-cert.c
+++ b/scripts/insert-sys-cert.c
@@ -24,7 +24,8 @@
 #include <sys/mman.h>
 #include <fcntl.h>
 #include <unistd.h>
-#include <elf.h>
+#include <gelf.h>
+#include <linux/types.h>
 
 #define CERT_SYM  "system_extra_cert"
 #define USED_SYM  "system_extra_cert_used"
@@ -34,18 +35,6 @@
 #define warn(format, args...) fprintf(stdout, "WARNING: " format, ## args)
 #define  err(format, args...) fprintf(stderr, "ERROR:   " format, ## args)
 
-#if UINTPTR_MAX == 0xffffffff
-#define CURRENT_ELFCLASS ELFCLASS32
-#define Elf_Ehdr	Elf32_Ehdr
-#define Elf_Shdr	Elf32_Shdr
-#define Elf_Sym		Elf32_Sym
-#else
-#define CURRENT_ELFCLASS ELFCLASS64
-#define Elf_Ehdr	Elf64_Ehdr
-#define Elf_Shdr	Elf64_Shdr
-#define Elf_Sym		Elf64_Sym
-#endif
-
 static unsigned char endianness(void)
 {
 	uint16_t two_byte = 0x00FF;
@@ -65,22 +54,17 @@ struct sym {
 	int size;
 };
 
-static unsigned long get_offset_from_address(Elf_Ehdr *hdr, unsigned long addr)
+static unsigned long get_offset_from_address(Elf *elf, unsigned long addr)
 {
-	Elf_Shdr *x;
-	unsigned int i, num_sections;
-
-	x = (void *)hdr + hdr->e_shoff;
-	if (hdr->e_shnum == SHN_UNDEF)
-		num_sections = x[0].sh_size;
-	else
-		num_sections = hdr->e_shnum;
-
-	for (i = 1; i < num_sections; i++) {
-		unsigned long start = x[i].sh_addr;
-		unsigned long end = start + x[i].sh_size;
-		unsigned long offset = x[i].sh_offset;
-
+	Elf_Scn *scn = NULL;
+	GElf_Shdr shdr;
+	unsigned long start, end, offset;
+
+	while ((scn = elf_nextscn(elf, scn)) != NULL) {
+		gelf_getshdr(scn, &shdr);
+		start = shdr.sh_addr;
+		end = start + shdr.sh_size;
+		offset = shdr.sh_offset;
 		if (addr >= start && addr <= end)
 			return addr - start + offset;
 	}
@@ -90,7 +74,7 @@ static unsigned long get_offset_from_address(Elf_Ehdr *hdr, unsigned long addr)
 
 #define LINE_SIZE 100
 
-static void get_symbol_from_map(Elf_Ehdr *hdr, FILE *f, char *name,
+static void get_symbol_from_map(Elf *elf, void *base, FILE *f, char *name,
 				struct sym *s)
 {
 	char l[LINE_SIZE];
@@ -125,76 +109,65 @@ static void get_symbol_from_map(Elf_Ehdr *hdr, FILE *f, char *name,
 	s->address = strtoul(l, NULL, 16);
 	if (s->address == 0)
 		return;
-	s->offset = get_offset_from_address(hdr, s->address);
+	s->offset = get_offset_from_address(elf, s->address);
 	s->name = name;
-	s->content = (void *)hdr + s->offset;
-}
-
-static Elf_Sym *find_elf_symbol(Elf_Ehdr *hdr, Elf_Shdr *symtab, char *name)
-{
-	Elf_Sym *sym, *symtab_start;
-	char *strtab, *symname;
-	unsigned int link;
-	Elf_Shdr *x;
-	int i, n;
-
-	x = (void *)hdr + hdr->e_shoff;
-	link = symtab->sh_link;
-	symtab_start = (void *)hdr + symtab->sh_offset;
-	n = symtab->sh_size / symtab->sh_entsize;
-	strtab = (void *)hdr + x[link].sh_offset;
-
-	for (i = 0; i < n; i++) {
-		sym = &symtab_start[i];
-		symname = strtab + sym->st_name;
-		if (strcmp(symname, name) == 0)
-			return sym;
-	}
-	err("Unable to find symbol: %s\n", name);
-	return NULL;
+	s->content = (void *)base + s->offset;
 }
 
-static void get_symbol_from_table(Elf_Ehdr *hdr, Elf_Shdr *symtab,
+static void get_symbol_from_table(Elf *elf, Elf_Scn *symtab, void *base,
 				  char *name, struct sym *s)
 {
-	Elf_Shdr *sec;
-	int secndx;
-	Elf_Sym *elf_sym;
-	Elf_Shdr *x;
+	GElf_Shdr shdr;
+	Elf_Data *data;
+	int count;
+	int i;
+	GElf_Sym sym;
+	char *symname;
+	int found = 0;
+	size_t secndx;
+	Elf_Scn *sec;
+
+	gelf_getshdr(symtab, &shdr);
+	data = elf_getdata(symtab, NULL);
+	count = shdr.sh_size / shdr.sh_entsize;
+
+	for (i = 0; i < count; i++) {
+		gelf_getsym(data, i, &sym);
+		symname = elf_strptr(elf, shdr.sh_link, sym.st_name);
+		if (strcmp(symname, name) == 0) {
+			found = 1;
+			break;
+		}
+	}
 
-	x = (void *)hdr + hdr->e_shoff;
 	s->size = 0;
 	s->address = 0;
 	s->offset = 0;
-	elf_sym = find_elf_symbol(hdr, symtab, name);
-	if (!elf_sym)
+	if (!found)
 		return;
-	secndx = elf_sym->st_shndx;
+	secndx = sym.st_shndx;
 	if (!secndx)
 		return;
-	sec = &x[secndx];
-	s->size = elf_sym->st_size;
-	s->address = elf_sym->st_value;
-	s->offset = s->address - sec->sh_addr
-			       + sec->sh_offset;
+	sec = elf_getscn(elf, secndx);
+	gelf_getshdr(sec, &shdr);
+	s->size = sym.st_size;
+	s->address = sym.st_value;
+	s->offset = s->address - shdr.sh_addr
+			       + shdr.sh_offset;
 	s->name = name;
-	s->content = (void *)hdr + s->offset;
+	s->content = base + s->offset;
 }
 
-static Elf_Shdr *get_symbol_table(Elf_Ehdr *hdr)
+static Elf_Scn *get_symbol_table(Elf *elf)
 {
-	Elf_Shdr *x;
-	unsigned int i, num_sections;
-
-	x = (void *)hdr + hdr->e_shoff;
-	if (hdr->e_shnum == SHN_UNDEF)
-		num_sections = x[0].sh_size;
-	else
-		num_sections = hdr->e_shnum;
+	Elf_Scn *scn = NULL;
+	GElf_Shdr shdr;
 
-	for (i = 1; i < num_sections; i++)
-		if (x[i].sh_type == SHT_SYMTAB)
-			return &x[i];
+	while ((scn = elf_nextscn(elf, scn)) != NULL) {
+		gelf_getshdr(scn, &shdr);
+		if (shdr.sh_type == SHT_SYMTAB)
+			return scn;
+	}
 	return NULL;
 }
 
@@ -257,7 +230,7 @@ static char *read_file(char *file_name, int *size)
 	return buf;
 }
 
-static void print_sym(Elf_Ehdr *hdr, struct sym *s)
+static void print_sym(struct sym *s)
 {
 	info("sym:    %s\n", s->name);
 	info("addr:   0x%lx\n", s->address);
@@ -277,14 +250,15 @@ int main(int argc, char **argv)
 	char *cert_file = NULL;
 	int vmlinux_size;
 	int cert_size;
-	Elf_Ehdr *hdr;
+	char *vmlinux;
 	char *cert;
 	FILE *system_map;
-	unsigned long *lsize;
 	int *used;
 	int opt;
-	Elf_Shdr *symtab = NULL;
 	struct sym cert_sym, lsize_sym, used_sym;
+	Elf *elf;
+	GElf_Ehdr hdr_s, *hdr;
+	Elf_Scn *symtab = NULL;
 
 	while ((opt = getopt(argc, argv, "b:c:s:")) != -1) {
 		switch (opt) {
@@ -311,12 +285,24 @@ int main(int argc, char **argv)
 	if (!cert)
 		exit(EXIT_FAILURE);
 
-	hdr = map_file(vmlinux_file, &vmlinux_size);
-	if (!hdr)
+	vmlinux = map_file(vmlinux_file, &vmlinux_size);
+	if (!vmlinux)
 		exit(EXIT_FAILURE);
 
-	if (vmlinux_size < sizeof(*hdr)) {
-		err("Invalid ELF file.\n");
+	if (elf_version(EV_CURRENT) == EV_NONE) {
+		err("Init libelf failed.\n");
+		exit(EXIT_FAILURE);
+	}
+
+	elf = elf_memory(vmlinux, vmlinux_size);
+	if (!elf) {
+		err("Unable to read Elf: %s\n", elf_errmsg(elf_errno()));
+		exit(EXIT_FAILURE);
+	}
+
+	hdr = gelf_getehdr(elf, &hdr_s);
+	if (!hdr) {
+		err("Unable to read Elf_hdr: %s\n", elf_errmsg(elf_errno()));
 		exit(EXIT_FAILURE);
 	}
 
@@ -328,11 +314,6 @@ int main(int argc, char **argv)
 		exit(EXIT_FAILURE);
 	}
 
-	if (hdr->e_ident[EI_CLASS] != CURRENT_ELFCLASS) {
-		err("ELF class mismatch.\n");
-		exit(EXIT_FAILURE);
-	}
-
 	if (hdr->e_ident[EI_DATA] != endianness()) {
 		err("ELF endian mismatch.\n");
 		exit(EXIT_FAILURE);
@@ -343,7 +324,7 @@ int main(int argc, char **argv)
 		exit(EXIT_FAILURE);
 	}
 
-	symtab = get_symbol_table(hdr);
+	symtab = get_symbol_table(elf);
 	if (!symtab) {
 		warn("Could not find the symbol table.\n");
 		if (!system_map_file) {
@@ -357,27 +338,32 @@ int main(int argc, char **argv)
 			perror(system_map_file);
 			exit(EXIT_FAILURE);
 		}
-		get_symbol_from_map(hdr, system_map, CERT_SYM, &cert_sym);
-		get_symbol_from_map(hdr, system_map, USED_SYM, &used_sym);
-		get_symbol_from_map(hdr, system_map, LSIZE_SYM, &lsize_sym);
+		get_symbol_from_map(elf, vmlinux, system_map,
+				    CERT_SYM, &cert_sym);
+		get_symbol_from_map(elf, vmlinux, system_map,
+				    USED_SYM, &used_sym);
+		get_symbol_from_map(elf, vmlinux, system_map,
+				    LSIZE_SYM, &lsize_sym);
 		cert_sym.size = used_sym.address - cert_sym.address;
 	} else {
 		info("Symbol table found.\n");
 		if (system_map_file)
 			warn("System.map is ignored.\n");
-		get_symbol_from_table(hdr, symtab, CERT_SYM, &cert_sym);
-		get_symbol_from_table(hdr, symtab, USED_SYM, &used_sym);
-		get_symbol_from_table(hdr, symtab, LSIZE_SYM, &lsize_sym);
+		get_symbol_from_table(elf, symtab, vmlinux,
+				      CERT_SYM, &cert_sym);
+		get_symbol_from_table(elf, symtab, vmlinux,
+				      USED_SYM, &used_sym);
+		get_symbol_from_table(elf, symtab, vmlinux,
+				      LSIZE_SYM, &lsize_sym);
 	}
 
 	if (!cert_sym.offset || !lsize_sym.offset || !used_sym.offset)
 		exit(EXIT_FAILURE);
 
-	print_sym(hdr, &cert_sym);
-	print_sym(hdr, &used_sym);
-	print_sym(hdr, &lsize_sym);
+	print_sym(&cert_sym);
+	print_sym(&used_sym);
+	print_sym(&lsize_sym);
 
-	lsize = (unsigned long *)lsize_sym.content;
 	used = (int *)used_sym.content;
 
 	if (cert_sym.size < cert_size) {
@@ -400,11 +386,26 @@ int main(int argc, char **argv)
 		memset(cert_sym.content + cert_size,
 			0, cert_sym.size - cert_size);
 
-	*lsize = *lsize + cert_size - *used;
+	if (hdr->e_ident[EI_CLASS] == ELFCLASS64) {
+		u64 *lsize;
+
+		lsize = (u64 *)lsize_sym.content;
+		*lsize = *lsize + cert_size - *used;
+	} else {
+		u32 *lsize;
+
+		lsize = (u32 *)lsize_sym.content;
+		*lsize = *lsize + cert_size - *used;
+	}
 	*used = cert_size;
 	info("Inserted the contents of %s into %lx.\n", cert_file,
 						cert_sym.address);
 	info("Used %d bytes out of %d bytes reserved.\n", *used,
 						 cert_sym.size);
+	if (munmap(vmlinux, vmlinux_size) == -1) {
+		perror(vmlinux_file);
+		exit(EXIT_FAILURE);
+	}
+
 	exit(EXIT_SUCCESS);
 }
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
