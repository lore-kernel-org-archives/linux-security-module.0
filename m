From: paul@paul-moore.com (Paul Moore)
Date: Tue, 19 Jun 2018 13:44:10 -0400
Subject: [PATCH 10/13] selinux: Cleanup printk logging in netport
In-Reply-To: <20180612080912.7827-11-peter.enderborg@sony.com>
References: <20180612080912.7827-1-peter.enderborg@sony.com>
	<20180612080912.7827-11-peter.enderborg@sony.com>
Message-ID: <CAHC9VhQXk4tMZ_fp=rbygEs2ZyT2O07PJB4jdKKY7+eO3wSC5g@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jun 12, 2018 at 4:09 AM Peter Enderborg
<peter.enderborg@sony.com> wrote:
>
> Replace printk with pr_* to avoid checkpatch warnings.
>
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> ---
>  security/selinux/netport.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/netport.c b/security/selinux/netport.c
> index 9ed4c5064a5e..7a141cadbffc 100644
> --- a/security/selinux/netport.c
> +++ b/security/selinux/netport.c
> @@ -173,9 +173,8 @@ static int sel_netport_sid_slow(u8 protocol, u16 pnum, u32 *sid)
>  out:
>         spin_unlock_bh(&sel_netport_lock);
>         if (unlikely(ret)) {
> -               printk(KERN_WARNING
> -                      "SELinux: failure in sel_netport_sid_slow(),"
> -                      " unable to determine network port label\n");
> +               pr_warn("SELinux: failure in %s(), unable to determine network port label\n",
> +                       __func__);
>                 kfree(new);
>         }
>         return ret;
> --
> 2.15.1

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
