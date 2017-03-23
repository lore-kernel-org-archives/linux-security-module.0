From: paul@paul-moore.com (Paul Moore)
Date: Thu, 23 Mar 2017 18:13:05 -0400
Subject: [PATCH 20/46] selinux: Move four assignments for the variable
	"rc" in range_read()
In-Reply-To: <196aacb8-6aab-841b-3301-71da75628954@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<196aacb8-6aab-841b-3301-71da75628954@users.sourceforge.net>
Message-ID: <CAHC9VhTzp2ccYOGBCysOfm3ibvQrLoj6d5=-w7uT7_0R2xTb4A@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jan 15, 2017 at 10:20 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 19:55:00 +0100
>
> One local variable was set to an error code in four cases before
> a concrete error situation was detected. Thus move the corresponding
> assignments into if branches to indicate a software failure there.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)

See previous comments.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index a696876fc327..4cd96ce51322 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1854,10 +1854,11 @@ static int range_read(struct policydb *p, void *fp)
>
>         nel = le32_to_cpu(buf[0]);
>         for (i = 0; i < nel; i++) {
> -               rc = -ENOMEM;
>                 rt = kzalloc(sizeof(*rt), GFP_KERNEL);
> -               if (!rt)
> +               if (!rt) {
> +                       rc = -ENOMEM;
>                         goto out;
> +               }
>
>                 rc = next_entry(buf, fp, (sizeof(u32) * 2));
>                 if (rc)
> @@ -1873,24 +1874,26 @@ static int range_read(struct policydb *p, void *fp)
>                 } else
>                         rt->target_class = p->process_class;
>
> -               rc = -EINVAL;
>                 if (!policydb_type_isvalid(p, rt->source_type) ||
>                     !policydb_type_isvalid(p, rt->target_type) ||
> -                   !policydb_class_isvalid(p, rt->target_class))
> +                   !policydb_class_isvalid(p, rt->target_class)) {
> +                       rc = -EINVAL;
>                         goto out;
> +               }
>
> -               rc = -ENOMEM;
>                 r = kzalloc(sizeof(*r), GFP_KERNEL);
> -               if (!r)
> +               if (!r) {
> +                       rc = -ENOMEM;
>                         goto out;
> +               }
>
>                 rc = mls_read_range_helper(r, fp);
>                 if (rc)
>                         goto out;
>
> -               rc = -EINVAL;
>                 if (!mls_range_isvalid(p, r)) {
>                         printk(KERN_WARNING "SELinux:  rangetrans:  invalid range\n");
> +                       rc = -EINVAL;
>                         goto out;
>                 }
>
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
