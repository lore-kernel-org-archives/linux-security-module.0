From: paul@paul-moore.com (Paul Moore)
Date: Tue, 19 Jun 2018 13:48:38 -0400
Subject: [PATCH 12/13] selinux: Cleanup printk logging in avc
In-Reply-To: <20180612080912.7827-13-peter.enderborg@sony.com>
References: <20180612080912.7827-1-peter.enderborg@sony.com>
	<20180612080912.7827-13-peter.enderborg@sony.com>
Message-ID: <CAHC9VhQ3xrVfGo0T-HdHbdM3p1k38NwfEP7qmNZDO_b_8a++UA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jun 12, 2018 at 4:09 AM Peter Enderborg
<peter.enderborg@sony.com> wrote:
>
> Replace printk with pr_* to avoid checkpatch warnings.
>
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> ---
>  security/selinux/avc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged, thanks.

> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index f3aedf077509..635e5c1e3e48 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -650,7 +650,7 @@ static int avc_latest_notif_update(struct selinux_avc *avc,
>         spin_lock_irqsave(&notif_lock, flag);
>         if (is_insert) {
>                 if (seqno < avc->avc_cache.latest_notif) {
> -                       printk(KERN_WARNING "SELinux: avc:  seqno %d < latest_notif %d\n",
> +                       pr_warn("SELinux: avc:  seqno %d < latest_notif %d\n",
>                                seqno, avc->avc_cache.latest_notif);
>                         ret = -EAGAIN;
>                 }
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
