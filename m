From: paul@paul-moore.com (Paul Moore)
Date: Mon, 28 Aug 2017 17:54:27 -0400
Subject: [PATCH] lsm_audit: use get_task_comm
In-Reply-To: <304ab87b276f87462fbeaccacb9dc1e02300df75.1502451616.git.geliangtang@gmail.com>
References: <304ab87b276f87462fbeaccacb9dc1e02300df75.1502451616.git.geliangtang@gmail.com>
Message-ID: <CAHC9VhTjpUShdbNpw0SaG0LS44UyLxcbCz+6aPaamA26wA-ywQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Aug 28, 2017 at 9:58 AM, Geliang Tang <geliangtang@gmail.com> wrote:
> get_task_comm() copys the task's comm under the task_lock, it's safer
> than directly using memcpy().
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  security/lsm_audit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index 28d4c3a..555b1c4 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -221,7 +221,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
>         BUILD_BUG_ON(sizeof(a->u) > sizeof(void *)*2);
>
>         audit_log_format(ab, " pid=%d comm=", task_tgid_nr(current));
> -       audit_log_untrustedstring(ab, memcpy(comm, current->comm, sizeof(comm)));
> +       audit_log_untrustedstring(ab, get_task_comm(comm, current));
>
>         switch (a->type) {
>         case LSM_AUDIT_DATA_NONE:
> @@ -312,7 +312,7 @@ static void dump_common_audit_data(struct audit_buffer *ab,
>                                 char comm[sizeof(tsk->comm)];
>                                 audit_log_format(ab, " opid=%d ocomm=", pid);
>                                 audit_log_untrustedstring(ab,
> -                                   memcpy(comm, tsk->comm, sizeof(comm)));
> +                                   get_task_comm(comm, tsk));

[NOTE: adding the linux-audit mailing list to this thread]

This isn't strictly a problem with this patch, but I think we should
be able to get rid of the 'comm' variable in this if-block as simply
reuse the 'comm' from the top of the function.  It would be nice to
include that in this patch.

Other than that minor nit, this patch looks good to me; if you make
that small change I'll merge it into the audit/next branch for the
upcoming merge window.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
