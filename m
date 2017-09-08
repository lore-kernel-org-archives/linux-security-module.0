From: keescook@chromium.org (Kees Cook)
Date: Fri, 8 Sep 2017 11:15:45 -0700
Subject: [PATCH V4 03/10] capabilities: rename has_cap to has_fcap
In-Reply-To: <3eaf0505da29d9626b9c511d6ba1f7349e41c3cf.1504591358.git.rgb@redhat.com>
References: <cover.1504591358.git.rgb@redhat.com>
	<3eaf0505da29d9626b9c511d6ba1f7349e41c3cf.1504591358.git.rgb@redhat.com>
Message-ID: <CAGXu5j+pOC7GmJKfTbieksD99_tsZ6svO8VMYPaMaSwwu8_q=Q@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Sep 4, 2017 at 11:46 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Rename has_cap to has_fcap to clarify it applies to file capabilities
> since the entire source file is about capabilities.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> Acked-by: James Morris <james.l.morris@oracle.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  security/commoncap.c |   20 ++++++++++----------
>  1 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/security/commoncap.c b/security/commoncap.c
> index cf6e2b0..623f251 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -330,7 +330,7 @@ int cap_inode_killpriv(struct dentry *dentry)
>  static inline int bprm_caps_from_vfs_caps(struct cpu_vfs_cap_data *caps,
>                                           struct linux_binprm *bprm,
>                                           bool *effective,
> -                                         bool *has_cap)
> +                                         bool *has_fcap)
>  {
>         struct cred *new = bprm->cred;
>         unsigned i;
> @@ -340,7 +340,7 @@ static inline int bprm_caps_from_vfs_caps(struct cpu_vfs_cap_data *caps,
>                 *effective = true;
>
>         if (caps->magic_etc & VFS_CAP_REVISION_MASK)
> -               *has_cap = true;
> +               *has_fcap = true;
>
>         CAP_FOR_EACH_U32(i) {
>                 __u32 permitted = caps->permitted.cap[i];
> @@ -429,7 +429,7 @@ int get_vfs_caps_from_disk(const struct dentry *dentry, struct cpu_vfs_cap_data
>   * its xattrs and, if present, apply them to the proposed credentials being
>   * constructed by execve().
>   */
> -static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_cap)
> +static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_fcap)
>  {
>         int rc = 0;
>         struct cpu_vfs_cap_data vcaps;
> @@ -460,7 +460,7 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_c
>                 goto out;
>         }
>
> -       rc = bprm_caps_from_vfs_caps(&vcaps, bprm, effective, has_cap);
> +       rc = bprm_caps_from_vfs_caps(&vcaps, bprm, effective, has_fcap);
>         if (rc == -EINVAL)
>                 printk(KERN_NOTICE "%s: cap_from_disk returned %d for %s\n",
>                        __func__, rc, bprm->filename);
> @@ -472,7 +472,7 @@ static int get_file_caps(struct linux_binprm *bprm, bool *effective, bool *has_c
>         return rc;
>  }
>
> -static void handle_privileged_root(struct linux_binprm *bprm, bool has_cap,
> +static void handle_privileged_root(struct linux_binprm *bprm, bool has_fcap,
>                                    bool *effective, kuid_t root_uid)
>  {
>         const struct cred *old = current_cred();
> @@ -485,7 +485,7 @@ static void handle_privileged_root(struct linux_binprm *bprm, bool has_cap,
>          * for a setuid root binary run by a non-root user.  Do set it
>          * for a root user just to cause least surprise to an admin.
>          */
> -       if (has_cap && !uid_eq(new->uid, root_uid) && uid_eq(new->euid, root_uid)) {
> +       if (has_fcap && !uid_eq(new->uid, root_uid) && uid_eq(new->euid, root_uid)) {
>                 warn_setuid_and_fcaps_mixed(bprm->filename);
>                 return;
>         }
> @@ -523,20 +523,20 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
>  {
>         const struct cred *old = current_cred();
>         struct cred *new = bprm->cred;
> -       bool effective = false, has_cap = false, is_setid;
> +       bool effective = false, has_fcap = false, is_setid;
>         int ret;
>         kuid_t root_uid;
>
>         if (WARN_ON(!cap_ambient_invariant_ok(old)))
>                 return -EPERM;
>
> -       ret = get_file_caps(bprm, &effective, &has_cap);
> +       ret = get_file_caps(bprm, &effective, &has_fcap);
>         if (ret < 0)
>                 return ret;
>
>         root_uid = make_kuid(new->user_ns, 0);
>
> -       handle_privileged_root(bprm, has_cap, &effective, root_uid);
> +       handle_privileged_root(bprm, has_fcap, &effective, root_uid);
>
>         /* if we have fs caps, clear dangerous personality flags */
>         if (__cap_gained(permitted, new, old))
> @@ -566,7 +566,7 @@ int cap_bprm_set_creds(struct linux_binprm *bprm)
>         new->sgid = new->fsgid = new->egid;
>
>         /* File caps or setid cancels ambient. */
> -       if (has_cap || is_setid)
> +       if (has_fcap || is_setid)
>                 cap_clear(new->cap_ambient);
>
>         /*
> --
> 1.7.1
>



-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
