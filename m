From: luto@kernel.org (Andy Lutomirski)
Date: Tue, 18 Jul 2017 18:01:22 -0700
Subject: [PATCH v3 01/15] binfmt: Introduce secureexec flag
In-Reply-To: <1500416736-49829-2-git-send-email-keescook@chromium.org>
References: <1500416736-49829-1-git-send-email-keescook@chromium.org>
	<1500416736-49829-2-git-send-email-keescook@chromium.org>
Message-ID: <CALCETrXRzNZU2uR4S7h=d0G-Rcr9rSMVkNOK7ymcovLP4waV=Q@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jul 18, 2017 at 3:25 PM, Kees Cook <keescook@chromium.org> wrote:
> To begin this refactoring, this adds the secureexec flag to the bprm
> struct, which will eventually be used in place of the LSM hook.

I'm very confused.  See below.  Maybe a later patch will unconfuse me.

>
> Cc: David Howells <dhowells@redhat.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/binfmt_elf.c         | 3 ++-
>  fs/binfmt_elf_fdpic.c   | 3 ++-
>  include/linux/binfmts.h | 8 +++++++-
>  3 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 5075fd5c62c8..991e4de3515f 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -254,7 +254,8 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
>         NEW_AUX_ENT(AT_EUID, from_kuid_munged(cred->user_ns, cred->euid));
>         NEW_AUX_ENT(AT_GID, from_kgid_munged(cred->user_ns, cred->gid));
>         NEW_AUX_ENT(AT_EGID, from_kgid_munged(cred->user_ns, cred->egid));
> -       NEW_AUX_ENT(AT_SECURE, security_bprm_secureexec(bprm));
> +       bprm->secureexec |= security_bprm_secureexec(bprm);
> +       NEW_AUX_ENT(AT_SECURE, bprm->secureexec);

This is ->load_binary ...

> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index 05488da3aee9..9508b5f83c7e 100644
> --- a/include/linux/binfmts.h
> +++ b/include/linux/binfmts.h
> @@ -27,9 +27,15 @@ struct linux_binprm {
>         unsigned int
>                 cred_prepared:1,/* true if creds already prepared (multiple
>                                  * preps happen for interpreters) */
> -               cap_effective:1;/* true if has elevated effective capabilities,
> +               cap_effective:1,/* true if has elevated effective capabilities,
>                                  * false if not; except for init which inherits
>                                  * its parent's caps anyway */
> +               /*
> +                * Set by bprm_set_creds hook to indicate a privilege-gaining
> +                * exec has happened. Used to sanitize execution environment
> +                * and to set AT_SECURE auxv for glibc.
> +                */

... which is not bprm_set_creds().

What am I missing here?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
