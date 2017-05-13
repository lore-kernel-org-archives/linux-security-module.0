From: keescook@chromium.org (Kees Cook)
Date: Sat, 13 May 2017 04:51:41 -0700
Subject: [PATCH 05/17] doc: ReSTify self-protection.txt
In-Reply-To: <1494676313-144890-1-git-send-email-keescook@chromium.org>
References: <1494676313-144890-1-git-send-email-keescook@chromium.org>
Message-ID: <1494676313-144890-6-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This updates the credentials API documentation to ReST markup and moves
it under the security subsection of kernel API documentation.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/security/index.rst                   |  1 +
 .../{self-protection.txt => self-protection.rst}   | 99 ++++++++++++++--------
 2 files changed, 64 insertions(+), 36 deletions(-)
 rename Documentation/security/{self-protection.txt => self-protection.rst} (83%)

diff --git a/Documentation/security/index.rst b/Documentation/security/index.rst
index 415be8e0b013..4212d7ac58b6 100644
--- a/Documentation/security/index.rst
+++ b/Documentation/security/index.rst
@@ -7,4 +7,5 @@ Security Documentation
 
    credentials
    IMA-templates
+   self-protection
    tpm/index
diff --git a/Documentation/security/self-protection.txt b/Documentation/security/self-protection.rst
similarity index 83%
rename from Documentation/security/self-protection.txt
rename to Documentation/security/self-protection.rst
index 141acfebe6ef..60c8bd8b77bf 100644
--- a/Documentation/security/self-protection.txt
+++ b/Documentation/security/self-protection.rst
@@ -1,4 +1,6 @@
-# Kernel Self-Protection
+======================
+Kernel Self-Protection
+======================
 
 Kernel self-protection is the design and implementation of systems and
 structures within the Linux kernel to protect against security flaws in
@@ -26,7 +28,8 @@ mentioning them, since these aspects need to be explored, dealt with,
 and/or accepted.
 
 
-## Attack Surface Reduction
+Attack Surface Reduction
+========================
 
 The most fundamental defense against security exploits is to reduce the
 areas of the kernel that can be used to redirect execution. This ranges
@@ -34,13 +37,15 @@ from limiting the exposed APIs available to userspace, making in-kernel
 APIs hard to use incorrectly, minimizing the areas of writable kernel
 memory, etc.
 
-### Strict kernel memory permissions
+Strict kernel memory permissions
+--------------------------------
 
 When all of kernel memory is writable, it becomes trivial for attacks
 to redirect execution flow. To reduce the availability of these targets
 the kernel needs to protect its memory with a tight set of permissions.
 
-#### Executable code and read-only data must not be writable
+Executable code and read-only data must not be writable
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Any areas of the kernel with executable memory must not be writable.
 While this obviously includes the kernel text itself, we must consider
@@ -51,18 +56,19 @@ kernel, they are implemented in a way where the memory is temporarily
 made writable during the update, and then returned to the original
 permissions.)
 
-In support of this are CONFIG_STRICT_KERNEL_RWX and
-CONFIG_STRICT_MODULE_RWX, which seek to make sure that code is not
+In support of this are ``CONFIG_STRICT_KERNEL_RWX`` and
+``CONFIG_STRICT_MODULE_RWX``, which seek to make sure that code is not
 writable, data is not executable, and read-only data is neither writable
 nor executable.
 
 Most architectures have these options on by default and not user selectable.
 For some architectures like arm that wish to have these be selectable,
 the architecture Kconfig can select ARCH_OPTIONAL_KERNEL_RWX to enable
-a Kconfig prompt. CONFIG_ARCH_OPTIONAL_KERNEL_RWX_DEFAULT determines
+a Kconfig prompt. ``CONFIG_ARCH_OPTIONAL_KERNEL_RWX_DEFAULT`` determines
 the default setting when ARCH_OPTIONAL_KERNEL_RWX is enabled.
 
-#### Function pointers and sensitive variables must not be writable
+Function pointers and sensitive variables must not be writable
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Vast areas of kernel memory contain function pointers that are looked
 up by the kernel and used to continue execution (e.g. descriptor/vector
@@ -74,8 +80,8 @@ so that they live in the .rodata section instead of the .data section
 of the kernel, gaining the protection of the kernel's strict memory
 permissions as described above.
 
-For variables that are initialized once at __init time, these can
-be marked with the (new and under development) __ro_after_init
+For variables that are initialized once at ``__init`` time, these can
+be marked with the (new and under development) ``__ro_after_init``
 attribute.
 
 What remains are variables that are updated rarely (e.g. GDT). These
@@ -85,7 +91,8 @@ of their lifetime read-only. (For example, when being updated, only the
 CPU thread performing the update would be given uninterruptible write
 access to the memory.)
 
-#### Segregation of kernel memory from userspace memory
+Segregation of kernel memory from userspace memory
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 The kernel must never execute userspace memory. The kernel must also never
 access userspace memory without explicit expectation to do so. These
@@ -95,10 +102,11 @@ By blocking userspace memory in this way, execution and data parsing
 cannot be passed to trivially-controlled userspace memory, forcing
 attacks to operate entirely in kernel memory.
 
-### Reduced access to syscalls
+Reduced access to syscalls
+--------------------------
 
 One trivial way to eliminate many syscalls for 64-bit systems is building
-without CONFIG_COMPAT. However, this is rarely a feasible scenario.
+without ``CONFIG_COMPAT``. However, this is rarely a feasible scenario.
 
 The "seccomp" system provides an opt-in feature made available to
 userspace, which provides a way to reduce the number of kernel entry
@@ -112,7 +120,8 @@ to trusted processes. This would keep the scope of kernel entry points
 restricted to the more regular set of normally available to unprivileged
 userspace.
 
-### Restricting access to kernel modules
+Restricting access to kernel modules
+------------------------------------
 
 The kernel should never allow an unprivileged user the ability to
 load specific kernel modules, since that would provide a facility to
@@ -127,11 +136,12 @@ for debate in some scenarios.)
 To protect against even privileged users, systems may need to either
 disable module loading entirely (e.g. monolithic kernel builds or
 modules_disabled sysctl), or provide signed modules (e.g.
-CONFIG_MODULE_SIG_FORCE, or dm-crypt with LoadPin), to keep from having
+``CONFIG_MODULE_SIG_FORCE``, or dm-crypt with LoadPin), to keep from having
 root load arbitrary kernel code via the module loader interface.
 
 
-## Memory integrity
+Memory integrity
+================
 
 There are many memory structures in the kernel that are regularly abused
 to gain execution control during an attack, By far the most commonly
@@ -139,16 +149,18 @@ understood is that of the stack buffer overflow in which the return
 address stored on the stack is overwritten. Many other examples of this
 kind of attack exist, and protections exist to defend against them.
 
-### Stack buffer overflow
+Stack buffer overflow
+---------------------
 
 The classic stack buffer overflow involves writing past the expected end
 of a variable stored on the stack, ultimately writing a controlled value
 to the stack frame's stored return address. The most widely used defense
 is the presence of a stack canary between the stack variables and the
-return address (CONFIG_CC_STACKPROTECTOR), which is verified just before
+return address (``CONFIG_CC_STACKPROTECTOR``), which is verified just before
 the function returns. Other defenses include things like shadow stacks.
 
-### Stack depth overflow
+Stack depth overflow
+--------------------
 
 A less well understood attack is using a bug that triggers the
 kernel to consume stack memory with deep function calls or large stack
@@ -158,27 +170,31 @@ important changes need to be made for better protections: moving the
 sensitive thread_info structure elsewhere, and adding a faulting memory
 hole at the bottom of the stack to catch these overflows.
 
-### Heap memory integrity
+Heap memory integrity
+---------------------
 
 The structures used to track heap free lists can be sanity-checked during
 allocation and freeing to make sure they aren't being used to manipulate
 other memory areas.
 
-### Counter integrity
+Counter integrity
+-----------------
 
 Many places in the kernel use atomic counters to track object references
 or perform similar lifetime management. When these counters can be made
 to wrap (over or under) this traditionally exposes a use-after-free
 flaw. By trapping atomic wrapping, this class of bug vanishes.
 
-### Size calculation overflow detection
+Size calculation overflow detection
+-----------------------------------
 
 Similar to counter overflow, integer overflows (usually size calculations)
 need to be detected at runtime to kill this class of bug, which
 traditionally leads to being able to write past the end of kernel buffers.
 
 
-## Statistical defenses
+Probabilistic defenses
+======================
 
 While many protections can be considered deterministic (e.g. read-only
 memory cannot be written to), some protections provide only statistical
@@ -186,7 +202,8 @@ defense, in that an attack must gather enough information about a
 running system to overcome the defense. While not perfect, these do
 provide meaningful defenses.
 
-### Canaries, blinding, and other secrets
+Canaries, blinding, and other secrets
+-------------------------------------
 
 It should be noted that things like the stack canary discussed earlier
 are technically statistical defenses, since they rely on a secret value,
@@ -201,7 +218,8 @@ It is critical that the secret values used must be separate (e.g.
 different canary per stack) and high entropy (e.g. is the RNG actually
 working?) in order to maximize their success.
 
-### Kernel Address Space Layout Randomization (KASLR)
+Kernel Address Space Layout Randomization (KASLR)
+-------------------------------------------------
 
 Since the location of kernel memory is almost always instrumental in
 mounting a successful attack, making the location non-deterministic
@@ -209,22 +227,25 @@ raises the difficulty of an exploit. (Note that this in turn makes
 the value of information exposures higher, since they may be used to
 discover desired memory locations.)
 
-#### Text and module base
+Text and module base
+~~~~~~~~~~~~~~~~~~~~
 
 By relocating the physical and virtual base address of the kernel at
-boot-time (CONFIG_RANDOMIZE_BASE), attacks needing kernel code will be
+boot-time (``CONFIG_RANDOMIZE_BASE``), attacks needing kernel code will be
 frustrated. Additionally, offsetting the module loading base address
 means that even systems that load the same set of modules in the same
 order every boot will not share a common base address with the rest of
 the kernel text.
 
-#### Stack base
+Stack base
+~~~~~~~~~~
 
 If the base address of the kernel stack is not the same between processes,
 or even not the same between syscalls, targets on or beyond the stack
 become more difficult to locate.
 
-#### Dynamic memory base
+Dynamic memory base
+~~~~~~~~~~~~~~~~~~~
 
 Much of the kernel's dynamic memory (e.g. kmalloc, vmalloc, etc) ends up
 being relatively deterministic in layout due to the order of early-boot
@@ -232,7 +253,8 @@ initializations. If the base address of these areas is not the same
 between boots, targeting them is frustrated, requiring an information
 exposure specific to the region.
 
-#### Structure layout
+Structure layout
+~~~~~~~~~~~~~~~~
 
 By performing a per-build randomization of the layout of sensitive
 structures, attacks must either be tuned to known kernel builds or expose
@@ -240,26 +262,30 @@ enough kernel memory to determine structure layouts before manipulating
 them.
 
 
-## Preventing Information Exposures
+Preventing Information Exposures
+================================
 
 Since the locations of sensitive structures are the primary target for
 attacks, it is important to defend against exposure of both kernel memory
 addresses and kernel memory contents (since they may contain kernel
 addresses or other sensitive things like canary values).
 
-### Unique identifiers
+Unique identifiers
+------------------
 
 Kernel memory addresses must never be used as identifiers exposed to
 userspace. Instead, use an atomic counter, an idr, or similar unique
 identifier.
 
-### Memory initialization
+Memory initialization
+---------------------
 
 Memory copied to userspace must always be fully initialized. If not
 explicitly memset(), this will require changes to the compiler to make
 sure structure holes are cleared.
 
-### Memory poisoning
+Memory poisoning
+----------------
 
 When releasing memory, it is best to poison the contents (clear stack on
 syscall return, wipe heap memory on a free), to avoid reuse attacks that
@@ -267,9 +293,10 @@ rely on the old contents of memory. This frustrates many uninitialized
 variable attacks, stack content exposures, heap content exposures, and
 use-after-free attacks.
 
-### Destination tracking
+Destination tracking
+--------------------
 
 To help kill classes of bugs that result in kernel addresses being
 written to userspace, the destination of writes needs to be tracked. If
-the buffer is destined for userspace (e.g. seq_file backed /proc files),
+the buffer is destined for userspace (e.g. seq_file backed ``/proc`` files),
 it should automatically censor sensitive values.
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
