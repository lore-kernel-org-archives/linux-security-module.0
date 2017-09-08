From: keescook@chromium.org (Kees Cook)
Date: Fri, 8 Sep 2017 11:34:27 -0700
Subject: [PATCH V4 09/10] capabilities: fix logic for effective root or
	real root
In-Reply-To: <fcc7f8815666df526110b59d76707d52bd1ca9c9.1504591358.git.rgb@redhat.com>
References: <cover.1504591358.git.rgb@redhat.com>
	<fcc7f8815666df526110b59d76707d52bd1ca9c9.1504591358.git.rgb@redhat.com>
Message-ID: <CAGXu5jL8k9Jje9gT2wf7apRRsHxK22TOgBtMpvrv75WUpdVCkg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Sep 4, 2017 at 11:46 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Now that the logic is inverted, it is much easier to see that both real
> root and effective root conditions had to be met to avoid printing the
> BPRM_FCAPS record with audit syscalls.  This meant that any setuid root
> applications would print a full BPRM_FCAPS record when it wasn't
> necessary, cluttering the event output, since the SYSCALL and PATH
> records indicated the presence of the setuid bit and effective root user
> id.
>
> Require only one of effective root or real root to avoid printing the
> unnecessary record.
>
> Ref: commit 3fc689e96c0c ("Add audit_log_bprm_fcaps/AUDIT_BPRM_FCAPS")
> See: https://github.com/linux-audit/audit-kernel/issues/16
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> Acked-by: James Morris <james.l.morris@oracle.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  security/commoncap.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/security/commoncap.c b/security/commoncap.c
> index 7e8041d..759f3fa 100644
> --- a/security/commoncap.c
> +++ b/security/commoncap.c
> @@ -532,7 +532,7 @@ static inline bool __is_setgid(struct cred *new, const struct cred *old)
>   *
>   * We do not bother to audit if 3 things are true:
>   *   1) cap_effective has all caps
> - *   2) we are root
> + *   2) we became root *OR* are were already root
>   *   3) root is supposed to have all caps (SECURE_NOROOT)
>   * Since this is just a normal root execing a process.
>   *
> @@ -545,8 +545,7 @@ static inline bool nonroot_raised_pE(struct cred *cred, kuid_t root)
>
>         if (__cap_grew(effective, ambient, cred) &&
>             !(__cap_full(effective, cred) &&
> -             __is_eff(root, cred) &&
> -             __is_real(root, cred) &&
> +             (__is_eff(root, cred) || __is_real(root, cred)) &&
>               root_privileged()))
>                 ret = true;
>         return ret;
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
