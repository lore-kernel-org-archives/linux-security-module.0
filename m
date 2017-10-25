From: paul@paul-moore.com (Paul Moore)
Date: Wed, 25 Oct 2017 17:19:29 -0400
Subject: [PATCH] Audit: remove unused audit_log_secctx function
In-Reply-To: <7138b693-9f67-05b1-926a-f0b8ca4035d2@schaufler-ca.com>
References: <7138b693-9f67-05b1-926a-f0b8ca4035d2@schaufler-ca.com>
Message-ID: <CAHC9VhRNP1dp2_E2KM=RrYLonHZxdRTkLPBk0j7_g13HEOr_0A@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Oct 24, 2017 at 9:52 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> The function audit_log_secctx() is unused in the upstream kernel.
> All it does is wrap another function that doesn't need wrapping.
> It claims to give you the SELinux context, but that is not true if
> you are using a different security module.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/audit.h |  8 --------
>  kernel/audit.c        | 26 --------------------------
>  2 files changed, 34 deletions(-)

Merged into audit/next, thanks!

> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index cb708eb..9b275b6 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -149,12 +149,6 @@ extern void                    audit_log_key(struct audit_buffer *ab,
>  extern void                audit_log_link_denied(const char *operation,
>                                                   const struct path *link);
>  extern void                audit_log_lost(const char *message);
> -#ifdef CONFIG_SECURITY
> -extern void                audit_log_secctx(struct audit_buffer *ab, u32 secid);
> -#else
> -static inline void         audit_log_secctx(struct audit_buffer *ab, u32 secid)
> -{ }
> -#endif
>
>  extern int audit_log_task_context(struct audit_buffer *ab);
>  extern void audit_log_task_info(struct audit_buffer *ab,
> @@ -203,8 +197,6 @@ static inline void audit_log_key(struct audit_buffer *ab, char *key)
>  static inline void audit_log_link_denied(const char *string,
>                                          const struct path *link)
>  { }
> -static inline void audit_log_secctx(struct audit_buffer *ab, u32 secid)
> -{ }
>  static inline int audit_log_task_context(struct audit_buffer *ab)
>  {
>         return 0;
> diff --git a/kernel/audit.c b/kernel/audit.c
> index be1c28f..4254fde 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2337,32 +2337,6 @@ void audit_log(struct audit_context *ctx, gfp_t gfp_mask, int type,
>         }
>  }
>
> -#ifdef CONFIG_SECURITY
> -/**
> - * audit_log_secctx - Converts and logs SELinux context
> - * @ab: audit_buffer
> - * @secid: security number
> - *
> - * This is a helper function that calls security_secid_to_secctx to convert
> - * secid to secctx and then adds the (converted) SELinux context to the audit
> - * log by calling audit_log_format, thus also preventing leak of internal secid
> - * to userspace. If secid cannot be converted audit_panic is called.
> - */
> -void audit_log_secctx(struct audit_buffer *ab, u32 secid)
> -{
> -       u32 len;
> -       char *secctx;
> -
> -       if (security_secid_to_secctx(secid, &secctx, &len)) {
> -               audit_panic("Cannot convert secid to context");
> -       } else {
> -               audit_log_format(ab, " obj=%s", secctx);
> -               security_release_secctx(secctx, len);
> -       }
> -}
> -EXPORT_SYMBOL(audit_log_secctx);
> -#endif
> -
>  EXPORT_SYMBOL(audit_log_start);
>  EXPORT_SYMBOL(audit_log_end);
>  EXPORT_SYMBOL(audit_log_format);
>



-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
