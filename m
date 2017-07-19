From: john.johansen@canonical.com (John Johansen)
Date: Tue, 18 Jul 2017 17:02:37 -0700
Subject: [PATCH v3 08/15] LSM: drop bprm_secureexec hook
In-Reply-To: <1500416736-49829-9-git-send-email-keescook@chromium.org>
References: <1500416736-49829-1-git-send-email-keescook@chromium.org>
	<1500416736-49829-9-git-send-email-keescook@chromium.org>
Message-ID: <15255f64-e728-07c3-68de-4558850dd2eb@canonical.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 07/18/2017 03:25 PM, Kees Cook wrote:
> This removes the bprm_secureexec hook since the logic has been folded into
> the bprm_set_creds hook for all LSMs now.
> 
> Cc: James Morris <james.l.morris@oracle.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

looks good
Reviewed-by: John Johansen <john.johansen@canonical.com>

> ---
>  fs/binfmt_elf.c           |  1 -
>  fs/binfmt_elf_fdpic.c     |  1 -
>  include/linux/lsm_hooks.h | 14 +++++---------
>  include/linux/security.h  |  7 -------
>  security/security.c       |  5 -----
>  5 files changed, 5 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 991e4de3515f..7f6ec4dac13d 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -254,7 +254,6 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
>  	NEW_AUX_ENT(AT_EUID, from_kuid_munged(cred->user_ns, cred->euid));
>  	NEW_AUX_ENT(AT_GID, from_kgid_munged(cred->user_ns, cred->gid));
>  	NEW_AUX_ENT(AT_EGID, from_kgid_munged(cred->user_ns, cred->egid));
> -	bprm->secureexec |= security_bprm_secureexec(bprm);
>  	NEW_AUX_ENT(AT_SECURE, bprm->secureexec);
>  	NEW_AUX_ENT(AT_RANDOM, (elf_addr_t)(unsigned long)u_rand_bytes);
>  #ifdef ELF_HWCAP2
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index c88b35d4a6b3..5aa9199dfb13 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -650,7 +650,6 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
>  	NEW_AUX_ENT(AT_EUID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cred->euid));
>  	NEW_AUX_ENT(AT_GID,	(elf_addr_t) from_kgid_munged(cred->user_ns, cred->gid));
>  	NEW_AUX_ENT(AT_EGID,	(elf_addr_t) from_kgid_munged(cred->user_ns, cred->egid));
> -	bprm->secureexec |= security_bprm_secureexec(bprm);
>  	NEW_AUX_ENT(AT_SECURE,	bprm->secureexec);
>  	NEW_AUX_ENT(AT_EXECFN,	bprm->exec);
>  
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 080f34e66017..2ddc1c7e8923 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -40,7 +40,11 @@
>   *	interpreters.  The hook can tell whether it has already been called by
>   *	checking to see if @bprm->security is non-NULL.  If so, then the hook
>   *	may decide either to retain the security information saved earlier or
> - *	to replace it.
> + *	to replace it.  The hook must set @bprm->secureexec to 1 if a "secure
> + *	exec" has happened as a result of this hook call.  The flag is used to
> + *	indicate the need for a sanitized execution environment, and is also
> + *	passed in the ELF auxiliary table on the initial stack to indicate
> + *	whether libc should enable secure mode.
>   *	@bprm contains the linux_binprm structure.
>   *	Return 0 if the hook is successful and permission is granted.
>   * @bprm_check_security:
> @@ -68,12 +72,6 @@
>   *	linux_binprm structure.  This hook is a good place to perform state
>   *	changes on the process such as clearing out non-inheritable signal
>   *	state.  This is called immediately after commit_creds().
> - * @bprm_secureexec:
> - *	Return a boolean value (0 or 1) indicating whether a "secure exec"
> - *	is required.  The flag is passed in the auxiliary table
> - *	on the initial stack to the ELF interpreter to indicate whether libc
> - *	should enable secure mode.
> - *	@bprm contains the linux_binprm structure.
>   *
>   * Security hooks for filesystem operations.
>   *
> @@ -1368,7 +1366,6 @@ union security_list_options {
>  
>  	int (*bprm_set_creds)(struct linux_binprm *bprm);
>  	int (*bprm_check_security)(struct linux_binprm *bprm);
> -	int (*bprm_secureexec)(struct linux_binprm *bprm);
>  	void (*bprm_committing_creds)(struct linux_binprm *bprm);
>  	void (*bprm_committed_creds)(struct linux_binprm *bprm);
>  
> @@ -1680,7 +1677,6 @@ struct security_hook_heads {
>  	struct list_head vm_enough_memory;
>  	struct list_head bprm_set_creds;
>  	struct list_head bprm_check_security;
> -	struct list_head bprm_secureexec;
>  	struct list_head bprm_committing_creds;
>  	struct list_head bprm_committed_creds;
>  	struct list_head sb_alloc_security;
> diff --git a/include/linux/security.h b/include/linux/security.h
> index af675b576645..133c41bb666d 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -80,7 +80,6 @@ extern int cap_capset(struct cred *new, const struct cred *old,
>  		      const kernel_cap_t *inheritable,
>  		      const kernel_cap_t *permitted);
>  extern int cap_bprm_set_creds(struct linux_binprm *bprm);
> -extern int cap_bprm_secureexec(struct linux_binprm *bprm);
>  extern int cap_inode_setxattr(struct dentry *dentry, const char *name,
>  			      const void *value, size_t size, int flags);
>  extern int cap_inode_removexattr(struct dentry *dentry, const char *name);
> @@ -223,7 +222,6 @@ int security_bprm_set_creds(struct linux_binprm *bprm);
>  int security_bprm_check(struct linux_binprm *bprm);
>  void security_bprm_committing_creds(struct linux_binprm *bprm);
>  void security_bprm_committed_creds(struct linux_binprm *bprm);
> -int security_bprm_secureexec(struct linux_binprm *bprm);
>  int security_sb_alloc(struct super_block *sb);
>  void security_sb_free(struct super_block *sb);
>  int security_sb_copy_data(char *orig, char *copy);
> @@ -515,11 +513,6 @@ static inline void security_bprm_committed_creds(struct linux_binprm *bprm)
>  {
>  }
>  
> -static inline int security_bprm_secureexec(struct linux_binprm *bprm)
> -{
> -	return cap_bprm_secureexec(bprm);
> -}
> -
>  static inline int security_sb_alloc(struct super_block *sb)
>  {
>  	return 0;
> diff --git a/security/security.c b/security/security.c
> index b9fea3999cf8..750b83186869 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -311,11 +311,6 @@ void security_bprm_committed_creds(struct linux_binprm *bprm)
>  	call_void_hook(bprm_committed_creds, bprm);
>  }
>  
> -int security_bprm_secureexec(struct linux_binprm *bprm)
> -{
> -	return call_int_hook(bprm_secureexec, 0, bprm);
> -}
> -
>  int security_sb_alloc(struct super_block *sb)
>  {
>  	return call_int_hook(sb_alloc_security, 0, sb);
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
