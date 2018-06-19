From: paul@paul-moore.com (Paul Moore)
Date: Tue, 19 Jun 2018 13:50:36 -0400
Subject: [PATCH 13/13] selinux: Cleanup printk logging in netnode
In-Reply-To: <20180612080912.7827-14-peter.enderborg@sony.com>
References: <20180612080912.7827-1-peter.enderborg@sony.com>
	<20180612080912.7827-14-peter.enderborg@sony.com>
Message-ID: <CAHC9VhROjW4r7Ls35aX8M+j1BMn13OuUsN8prg9JnKWyHS1wzg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jun 12, 2018 at 4:09 AM Peter Enderborg
<peter.enderborg@sony.com> wrote:
>
> Replace printk with pr_* to avoid checkpatch warnings.
>
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> ---
>  security/selinux/netnode.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
> index 6dd89b89bc1f..afa0d432436b 100644
> --- a/security/selinux/netnode.c
> +++ b/security/selinux/netnode.c
> @@ -238,9 +238,8 @@ static int sel_netnode_sid_slow(void *addr, u16 family, u32 *sid)
>  out:
>         spin_unlock_bh(&sel_netnode_lock);
>         if (unlikely(ret)) {
> -               printk(KERN_WARNING
> -                      "SELinux: failure in sel_netnode_sid_slow(),"
> -                      " unable to determine network node label\n");
> +               pr_warn("SELinux: failure in %s(), unable to determine network node label\n",
> +                       __func__);
>                 kfree(new);
>         }
>         return ret;
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
