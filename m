From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 17 Aug 2017 02:12:29 +0800
Subject: [integrity:next-log-iversion 10/11]
	arch/x86/include/asm/linkage.h:10:35: error: expected declaration
	specifiers before '__attribute__'
Message-ID: <201708170221.GxAMAv7U%fengguang.wu@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-log-iversion
head:   5873cd8f629e0306acdc40d3a9142eb50ae70c2d
commit: 581c481c0a0de85be1d65a80ea37756757d710d3 [10/11] security: define a new LSM sb_post_remount hook
config: i386-randconfig-x000-201733 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 581c481c0a0de85be1d65a80ea37756757d710d3
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

    {
    ^
   include/linux/sched/task_stack.h:109:13: error: storage class specified for parameter 'set_task_stack_end_magic'
    extern void set_task_stack_end_magic(struct task_struct *tsk);
                ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/sched/task_stack.h:113:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   In file included from include/linux/elfcore.h:8:0,
                    from include/linux/crash_core.h:5,
                    from include/linux/kexec.h:17,
                    from include/linux/ima.h:14,
                    from fs//attr.c:18:
   arch/x86/include/asm/elf.h:13:23: error: storage class specified for parameter 'elf_greg_t'
    typedef unsigned long elf_greg_t;
                          ^~~~~~~~~~
   arch/x86/include/asm/elf.h:16:20: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'elf_gregset_t'
    typedef elf_greg_t elf_gregset_t[ELF_NGREG];
                       ^~~~~~~~~~~~~
   arch/x86/include/asm/elf.h:18:33: error: storage class specified for parameter 'elf_fpregset_t'
    typedef struct user_i387_struct elf_fpregset_t;
                                    ^~~~~~~~~~~~~~
   arch/x86/include/asm/elf.h:22:33: error: storage class specified for parameter 'elf_fpxregset_t'
    typedef struct user_fxsr_struct elf_fpxregset_t;
                                    ^~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/elf.h:76:0,
                    from include/linux/elfcore.h:8,
                    from include/linux/crash_core.h:5,
                    from include/linux/kexec.h:17,
                    from include/linux/ima.h:14,
                    from fs//attr.c:18:
   arch/x86/include/asm/vdso.h:12:1: warning: empty declaration
    struct vdso_image {
    ^~~~~~
   arch/x86/include/asm/vdso.h:40:32: error: storage class specified for parameter 'vdso_image_32'
    extern const struct vdso_image vdso_image_32;
                                   ^~~~~~~~~~~~~
   arch/x86/include/asm/vdso.h:43:20: error: storage class specified for parameter 'init_vdso_image'
    extern void __init init_vdso_image(const struct vdso_image *image);
                       ^~~~~~~~~~~~~~~
   arch/x86/include/asm/vdso.h:43:20: error: section attribute not allowed for 'init_vdso_image'
   arch/x86/include/asm/vdso.h:43:49: warning: '__cold__' attribute ignored [-Wattributes]
    extern void __init init_vdso_image(const struct vdso_image *image);
                                                    ^~~~~~~~~~
   arch/x86/include/asm/vdso.h:45:12: error: storage class specified for parameter 'map_vdso_once'
    extern int map_vdso_once(const struct vdso_image *image, unsigned long addr);
               ^~~~~~~~~~~~~
   In file included from include/linux/elfcore.h:8:0,
                    from include/linux/crash_core.h:5,
                    from include/linux/kexec.h:17,
                    from include/linux/ima.h:14,
                    from fs//attr.c:18:
   arch/x86/include/asm/elf.h:82:21: error: storage class specified for parameter 'vdso32_enabled'
    extern unsigned int vdso32_enabled;
                        ^~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/desc.h:5:0,
                    from arch/x86/include/asm/elf.h:94,
                    from include/linux/elfcore.h:8,
                    from include/linux/crash_core.h:5,
                    from include/linux/kexec.h:17,
                    from include/linux/ima.h:14,
                    from fs//attr.c:18:
   arch/x86/include/uapi/asm/ldt.h:20:1: warning: empty declaration
    struct user_desc {
    ^~~~~~
   In file included from arch/x86/include/asm/elf.h:94:0,
                    from include/linux/elfcore.h:8,
                    from include/linux/crash_core.h:5,
                    from include/linux/kexec.h:17,
                    from include/linux/ima.h:14,
                    from fs//attr.c:18:
   arch/x86/include/asm/desc.h:13:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   arch/x86/include/asm/desc.h:38:24: error: storage class specified for parameter 'idt_descr'
    extern struct desc_ptr idt_descr;
                           ^~~~~~~~~
   arch/x86/include/asm/desc.h:39:18: error: storage class specified for parameter 'idt_table'
    extern gate_desc idt_table[];
                     ^~~~~~~~~
   arch/x86/include/asm/desc.h:40:30: error: storage class specified for parameter 'debug_idt_descr'
    extern const struct desc_ptr debug_idt_descr;
                                 ^~~~~~~~~~~~~~~
   arch/x86/include/asm/desc.h:41:18: error: storage class specified for parameter 'debug_idt_table'
    extern gate_desc debug_idt_table[];
                     ^~~~~~~~~~~~~~~
   arch/x86/include/asm/desc.h:43:1: warning: empty declaration
    struct gdt_page {
    ^~~~~~
   In file included from include/asm-generic/percpu.h:6:0,
                    from arch/x86/include/asm/percpu.h:542,
                    from arch/x86/include/asm/preempt.h:5,
                    from include/linux/preempt.h:80,
                    from include/linux/spinlock.h:50,
                    from include/linux/seqlock.h:35,
                    from include/linux/time.h:5,
                    from fs//attr.c:9:
   include/linux/percpu-defs.h:86:33: error: storage class specified for parameter '__pcpu_scope_gdt_page'
     extern __PCPU_DUMMY_ATTRS char __pcpu_scope_##name;  \
                                    ^
>> include/linux/percpu-defs.h:159:2: note: in expansion of macro 'DECLARE_PER_CPU_SECTION'
     DECLARE_PER_CPU_SECTION(type, name, "..page_aligned")  \
     ^~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/desc.h:47:1: note: in expansion of macro 'DECLARE_PER_CPU_PAGE_ALIGNED'
    DECLARE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:86:33: error: section attribute not allowed for '__pcpu_scope_gdt_page'
     extern __PCPU_DUMMY_ATTRS char __pcpu_scope_##name;  \
                                    ^
>> include/linux/percpu-defs.h:159:2: note: in expansion of macro 'DECLARE_PER_CPU_SECTION'
     DECLARE_PER_CPU_SECTION(type, name, "..page_aligned")  \
     ^~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/desc.h:47:1: note: in expansion of macro 'DECLARE_PER_CPU_PAGE_ALIGNED'
    DECLARE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/desc.h:47:47: error: storage class specified for parameter 'gdt_page'
    DECLARE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page);
                                                  ^
   include/linux/percpu-defs.h:87:44: note: in definition of macro 'DECLARE_PER_CPU_SECTION'
     extern __PCPU_ATTRS(sec) __typeof__(type) name
                                               ^~~~
   arch/x86/include/asm/desc.h:47:1: note: in expansion of macro 'DECLARE_PER_CPU_PAGE_ALIGNED'
    DECLARE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/desc.h:47:47: error: alignment may not be specified for 'gdt_page'
    DECLARE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page);
                                                  ^
   include/linux/percpu-defs.h:87:44: note: in definition of macro 'DECLARE_PER_CPU_SECTION'
     extern __PCPU_ATTRS(sec) __typeof__(type) name
                                               ^~~~
   arch/x86/include/asm/desc.h:47:1: note: in expansion of macro 'DECLARE_PER_CPU_PAGE_ALIGNED'
    DECLARE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/include/asm/desc.h:47:47: error: section attribute not allowed for 'gdt_page'
    DECLARE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page);
                                                  ^
   include/linux/percpu-defs.h:87:44: note: in definition of macro 'DECLARE_PER_CPU_SECTION'
     extern __PCPU_ATTRS(sec) __typeof__(type) name
                                               ^~~~
   arch/x86/include/asm/desc.h:47:1: note: in expansion of macro 'DECLARE_PER_CPU_PAGE_ALIGNED'
    DECLARE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/elf.h:94:0,
                    from include/linux/elfcore.h:8,
                    from include/linux/crash_core.h:5,
                    from include/linux/kexec.h:17,
                    from include/linux/ima.h:14,
                    from fs//attr.c:18:
   arch/x86/include/asm/desc.h:51:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   arch/x86/include/asm/desc.h:57:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   arch/x86/include/asm/desc.h:63:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   arch/x86/include/asm/desc.h:69:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   arch/x86/include/asm/desc.h:76:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   arch/x86/include/asm/desc.h:82:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   arch/x86/include/asm/desc.h:107:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   arch/x86/include/asm/desc.h:115:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   arch/x86/include/asm/desc.h:153:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   arch/x86/include/asm/desc.h:158:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   arch/x86/include/asm/desc.h:164:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   arch/x86/include/asm/desc.h:179:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   arch/x86/include/asm/desc.h:189:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   arch/x86/include/asm/desc.h:209:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   arch/x86/include/asm/desc.h:221:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   arch/x86/include/asm/desc.h:237:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   arch/x86/include/asm/desc.h:242:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   arch/x86/include/asm/desc.h:247:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   arch/x86/include/asm/desc.h:252:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   arch/x86/include/asm/desc.h:286:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   arch/x86/include/asm/desc.h:292:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
--
   include/linux/module.h:680:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/module.h:684:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/module.h:689:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/module.h:700:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/module.h:705:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   In file included from include/linux/kexec.h:26:0,
                    from include/linux/ima.h:14,
                    from fs//attr.c:18:
   include/linux/module.h:710:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/module.h:717:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/module.h:722:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/module.h:730:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/module.h:735:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/module.h:741:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/module.h:748:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/module.h:752:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   include/linux/module.h:759:21: error: storage class specified for parameter 'module_kset'
    extern struct kset *module_kset;
                        ^~~~~~~~~~~
   include/linux/module.h:760:25: error: storage class specified for parameter 'module_ktype'
    extern struct kobj_type module_ktype;
                            ^~~~~~~~~~~~
   include/linux/module.h:761:12: error: storage class specified for parameter 'module_sysfs_initialized'
    extern int module_sysfs_initialized;
               ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:776:50: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    static inline void set_all_modules_text_rw(void) { }
                                                     ^
   include/linux/module.h:777:50: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    static inline void set_all_modules_text_ro(void) { }
                                                     ^
   include/linux/module.h:778:80: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    static inline void module_enable_ro(const struct module *mod, bool after_init) { }
                                                                                   ^
   include/linux/module.h:779:64: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    static inline void module_disable_ro(const struct module *mod) { }
                                                                   ^
   In file included from arch/x86/include/asm/module.h:4:0,
                    from include/linux/module.h:24,
                    from include/linux/kexec.h:26,
                    from include/linux/ima.h:14,
                    from fs//attr.c:18:
   include/asm-generic/module.h:36:18: error: type defaults to 'int' in declaration of 'Elf32_Ehdr' [-Werror=implicit-int]
    #define Elf_Ehdr Elf32_Ehdr
                     ^
   include/linux/module.h:783:32: note: in expansion of macro 'Elf_Ehdr'
    void module_bug_finalize(const Elf_Ehdr *, const Elf_Shdr *,
                                   ^~~~~~~~
   In file included from include/linux/kexec.h:26:0,
                    from include/linux/ima.h:14,
                    from fs//attr.c:18:
   include/linux/module.h:783:41: error: expected ';', ',' or ')' before '*' token
    void module_bug_finalize(const Elf_Ehdr *, const Elf_Shdr *,
                                            ^
   include/linux/module.h:804:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   In file included from include/linux/kexec.h:27:0,
                    from include/linux/ima.h:14,
                    from fs//attr.c:18:
   arch/x86/include/asm/kexec.h:28:1: warning: empty declaration
    struct kimage;
    ^~~~~~
   arch/x86/include/asm/kexec.h:78:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   arch/x86/include/asm/kexec.h:94:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    {
    ^
   In file included from include/linux/linkage.h:7:0,
                    from arch/x86/include/asm/cache.h:4,
                    from include/linux/cache.h:5,
                    from include/linux/time.h:4,
                    from fs//attr.c:9:
>> arch/x86/include/asm/linkage.h:10:35: error: expected declaration specifiers before '__attribute__'
    #define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(0)))
                                      ^
   arch/x86/include/asm/kexec.h:139:1: note: in expansion of macro 'asmlinkage'
    asmlinkage unsigned long
    ^~~~~~~~~~
   In file included from include/linux/kexec.h:27:0,
                    from include/linux/ima.h:14,
                    from fs//attr.c:18:
   arch/x86/include/asm/kexec.h:156:1: warning: empty declaration
    struct kimage_arch {
    ^~~~~~
   arch/x86/include/asm/kexec.h:212:14: error: storage class specified for parameter 'crash_vmclear_fn'
    typedef void crash_vmclear_fn(void);
                 ^~~~~~~~~~~~~~~~
   arch/x86/include/asm/kexec.h:213:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '*' token
    extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
                                  ^
   arch/x86/include/asm/kexec.h:214:13: error: storage class specified for parameter 'kdump_nmi_shootdown_cpus'
    extern void kdump_nmi_shootdown_cpus(void);
                ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/ima.h:14:0,
                    from fs//attr.c:18:
   include/linux/kexec.h:70:23: error: storage class specified for parameter 'kimage_entry_t'
    typedef unsigned long kimage_entry_t;
                          ^~~~~~~~~~~~~~
   include/linux/kexec.h:72:1: warning: empty declaration
    struct kexec_segment {
    ^~~~~~
   include/linux/kexec.h:168:2: error: expected specifier-qualifier-list before 'kimage_entry_t'
     kimage_entry_t head;
     ^~~~~~~~~~~~~~
   include/linux/kexec.h:167:1: warning: empty declaration
    struct kimage {
    ^~~~~~
   include/linux/kexec.h:222:13: error: storage class specified for parameter 'machine_kexec'
    extern void machine_kexec(struct kimage *image);
                ^~~~~~~~~~~~~
   include/linux/kexec.h:223:12: error: storage class specified for parameter 'machine_kexec_prepare'
    extern int machine_kexec_prepare(struct kimage *image);
               ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kexec.h:224:13: error: storage class specified for parameter 'machine_kexec_cleanup'
    extern void machine_kexec_cleanup(struct kimage *image);
                ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kexec.h:225:24: error: storage class specified for parameter 'sys_kexec_load'
    extern asmlinkage long sys_kexec_load(unsigned long entry,
                           ^~~~~~~~~~~~~~
   include/linux/kexec.h:229:12: error: storage class specified for parameter 'kernel_kexec'
    extern int kernel_kexec(void);
               ^~~~~~~~~~~~
   include/linux/kexec.h:230:21: error: storage class specified for parameter 'kimage_alloc_control_pages'
    extern struct page *kimage_alloc_control_pages(struct kimage *image,
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kexec.h:232:12: error: storage class specified for parameter 'kexec_load_purgatory'
    extern int kexec_load_purgatory(struct kimage *image, unsigned long min,
               ^~~~~~~~~~~~~~~~~~~~
   include/linux/kexec.h:235:12: error: storage class specified for parameter 'kexec_purgatory_get_set_symbol'
    extern int kexec_purgatory_get_set_symbol(struct kimage *image,
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kexec.h:238:14: error: storage class specified for parameter 'kexec_purgatory_get_symbol_addr'
    extern void *kexec_purgatory_get_symbol_addr(struct kimage *image,
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kexec.h:240:13: error: storage class specified for parameter '__crash_kexec'
    extern void __crash_kexec(struct pt_regs *);
                ^~~~~~~~~~~~~
   include/linux/kexec.h:241:13: error: storage class specified for parameter 'crash_kexec'
    extern void crash_kexec(struct pt_regs *);
                ^~~~~~~~~~~
   include/linux/kexec.h:245:12: error: storage class specified for parameter 'kimage_crash_copy_vmcoreinfo'
    extern int kimage_crash_copy_vmcoreinfo(struct kimage *image);
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kexec.h:247:23: error: storage class specified for parameter 'kexec_image'
    extern struct kimage *kexec_image;
                          ^~~~~~~~~~~
   include/linux/kexec.h:248:23: error: storage class specified for parameter 'kexec_crash_image'
    extern struct kimage *kexec_crash_image;
                          ^~~~~~~~~~~~~~~~~
   include/linux/kexec.h:249:12: error: storage class specified for parameter 'kexec_load_disabled'
    extern int kexec_load_disabled;
               ^~~~~~~~~~~~~~~~~~~
   include/linux/kexec.h:268:24: error: storage class specified for parameter 'crashk_res'
    extern struct resource crashk_res;
                           ^~~~~~~~~~
   include/linux/kexec.h:269:24: error: storage class specified for parameter 'crashk_low_res'
    extern struct resource crashk_low_res;
                           ^~~~~~~~~~~~~~
   include/linux/kexec.h:270:28: error: expected '=', ',', ';', 'asm' or '__attribute__' before '*' token
    extern note_buf_t __percpu *crash_notes;
                               ^
   include/linux/kexec.h:273:13: error: storage class specified for parameter 'kexec_in_progress'
    extern bool kexec_in_progress;
                ^~~~~~~~~~~~~~~~~
   include/linux/kexec.h:280:7: warning: 'weak' attribute ignored [-Wattributes]
          unsigned long buf_len);
          ^~~~~~~~
   include/linux/kexec.h:281:51: warning: 'weak' attribute ignored [-Wattributes]
    void * __weak arch_kexec_kernel_image_load(struct kimage *image);
                                                      ^~~~~~
   include/linux/kexec.h:282:54: warning: 'weak' attribute ignored [-Wattributes]
    int __weak arch_kimage_file_post_load_cleanup(struct kimage *image);
                                                         ^~~~~~
..

vim +/__attribute__ +10 arch/x86/include/asm/linkage.h

78a9909a include/asm-x86/linkage.h      Ingo Molnar     2008-04-17   8  
96a388de include/asm-x86/linkage.h      Thomas Gleixner 2007-10-11   9  #ifdef CONFIG_X86_32
82f74e71 include/asm-x86/linkage.h      Harvey Harrison 2008-01-30 @10  #define asmlinkage CPP_ASMLINKAGE __attribute__((regparm(0)))
7ab15247 arch/x86/include/asm/linkage.h Cyrill Gorcunov 2009-03-06  11  #endif /* CONFIG_X86_32 */
7ab15247 arch/x86/include/asm/linkage.h Cyrill Gorcunov 2009-03-06  12  

:::::: The code at line 10 was first introduced by commit
:::::: 82f74e7159749cc511ebf5954a7b9ea6ad634949 x86: unify include/asm-x86/linkage_[32|64].h

:::::: TO: Harvey Harrison <harvey.harrison@gmail.com>
:::::: CC: Ingo Molnar <mingo@elte.hu>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
