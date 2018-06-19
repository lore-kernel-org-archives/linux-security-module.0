From: paul@paul-moore.com (Paul Moore)
Date: Tue, 19 Jun 2018 13:39:52 -0400
Subject: [PATCH 09/13] selinux: Cleanup printk logging in sidtab
In-Reply-To: <20180612080912.7827-10-peter.enderborg@sony.com>
References: <20180612080912.7827-1-peter.enderborg@sony.com>
	<20180612080912.7827-10-peter.enderborg@sony.com>
Message-ID: <CAHC9VhRoWbhTERzcwtEX2GkXQRfPG8itYV+yxkz74qugrotZUw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jun 12, 2018 at 4:09 AM Peter Enderborg
<peter.enderborg@sony.com> wrote:
>
> Replace printk with pr_* to avoid checkpatch warnings.
>
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> ---
>  security/selinux/ss/sidtab.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index 5be31b7af225..fd75a12fa8fc 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -214,8 +214,7 @@ int sidtab_context_to_sid(struct sidtab *s,
>                 }
>                 sid = s->next_sid++;
>                 if (context->len)
> -                       printk(KERN_INFO
> -                      "SELinux:  Context %s is not valid (left unmapped).\n",
> +                       pr_info("SELinux:  Context %s is not valid (left unmapped).\n",
>                                context->str);
>                 ret = sidtab_insert(s, sid, context);
>                 if (ret)
> @@ -253,7 +252,7 @@ void sidtab_hash_eval(struct sidtab *h, char *tag)
>                 }
>         }
>
> -       printk(KERN_DEBUG "%s:  %d entries and %d/%d buckets used, longest "
> +       pr_debug("%s:  %d entries and %d/%d buckets used, longest "
>                "chain length %d\n", tag, h->nel, slots_used, SIDTAB_SIZE,
>                max_chain_len);
>  }
> --
> 2.15.1
>


-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
