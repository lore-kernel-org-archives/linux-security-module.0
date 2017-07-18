From: keescook@chromium.org (Kees Cook)
Date: Tue, 18 Jul 2017 15:25:22 -0700
Subject: [PATCH v3 01/15] binfmt: Introduce secureexec flag
In-Reply-To: <1500416736-49829-1-git-send-email-keescook@chromium.org>
References: <1500416736-49829-1-git-send-email-keescook@chromium.org>
Message-ID: <1500416736-49829-2-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

The bprm_secureexec hook can be moved earlier. Right now, it is called
during create_elf_tables(), via load_binary(), via search_binary_handler(),
via exec_binprm(). Nearly all (see exception below) state used by
bprm_secureexec is created during the bprm_set_creds hook, called from
prepare_binprm().

For all LSMs (except commoncaps described next), only the first execution
of bprm_set_creds takes any effect (they all check bprm->cred_prepared which
prepare_binprm() sets after the first call to the bprm_set_creds hook).
However, all these LSMs also only do anything with bprm_secureexec when
they detected a secure state during their first run of bprm_set_creds.
Therefore, it is functionally identical to move the detection into
bprm_set_creds, since the results from secureexec here only need to be
based on the first call to the LSM's bprm_set_creds hook.

The single exception is that the commoncaps secureexec hook also examines
euid/uid and egid/gid differences which are controlled by bprm_fill_uid(),
via prepare_binprm(), which can be called multiple times (e.g.
binfmt_script, binfmt_misc), and may clear the euid/egid for the final
load (i.e. the script interpreter). However, while commoncaps specifically
ignores bprm->cred_prepared, and runs its bprm_set_creds hook each time
prepare_binprm() may get called, it needs to base the secureexec decision
on the final call to bprm_set_creds. As a result, it will need special
handling.

To begin this refactoring, this adds the secureexec flag to the bprm
struct, which will eventually be used in place of the LSM hook.

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/binfmt_elf.c         | 3 ++-
 fs/binfmt_elf_fdpic.c   | 3 ++-
 include/linux/binfmts.h | 8 +++++++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 5075fd5c62c8..991e4de3515f 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -254,7 +254,8 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 	NEW_AUX_ENT(AT_EUID, from_kuid_munged(cred->user_ns, cred->euid));
 	NEW_AUX_ENT(AT_GID, from_kgid_munged(cred->user_ns, cred->gid));
 	NEW_AUX_ENT(AT_EGID, from_kgid_munged(cred->user_ns, cred->egid));
- 	NEW_AUX_ENT(AT_SECURE, security_bprm_secureexec(bprm));
+	bprm->secureexec |= security_bprm_secureexec(bprm);
+	NEW_AUX_ENT(AT_SECURE, bprm->secureexec);
 	NEW_AUX_ENT(AT_RANDOM, (elf_addr_t)(unsigned long)u_rand_bytes);
 #ifdef ELF_HWCAP2
 	NEW_AUX_ENT(AT_HWCAP2, ELF_HWCAP2);
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index cf93a4fad012..c88b35d4a6b3 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -650,7 +650,8 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	NEW_AUX_ENT(AT_EUID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cred->euid));
 	NEW_AUX_ENT(AT_GID,	(elf_addr_t) from_kgid_munged(cred->user_ns, cred->gid));
 	NEW_AUX_ENT(AT_EGID,	(elf_addr_t) from_kgid_munged(cred->user_ns, cred->egid));
-	NEW_AUX_ENT(AT_SECURE,	security_bprm_secureexec(bprm));
+	bprm->secureexec |= security_bprm_secureexec(bprm);
+	NEW_AUX_ENT(AT_SECURE,	bprm->secureexec);
 	NEW_AUX_ENT(AT_EXECFN,	bprm->exec);
 
 #ifdef ARCH_DLINFO
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 05488da3aee9..9508b5f83c7e 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -27,9 +27,15 @@ struct linux_binprm {
 	unsigned int
 		cred_prepared:1,/* true if creds already prepared (multiple
 				 * preps happen for interpreters) */
-		cap_effective:1;/* true if has elevated effective capabilities,
+		cap_effective:1,/* true if has elevated effective capabilities,
 				 * false if not; except for init which inherits
 				 * its parent's caps anyway */
+		/*
+		 * Set by bprm_set_creds hook to indicate a privilege-gaining
+		 * exec has happened. Used to sanitize execution environment
+		 * and to set AT_SECURE auxv for glibc.
+		 */
+		secureexec:1;
 #ifdef __alpha__
 	unsigned int taso:1;
 #endif
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
