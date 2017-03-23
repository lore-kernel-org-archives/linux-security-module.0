From: paul@paul-moore.com (Paul Moore)
Date: Thu, 23 Mar 2017 18:10:37 -0400
Subject: [PATCH 18/46] selinux: One function call less in
	filename_trans_read() after error detection
In-Reply-To: <358b5114-aeb3-d5fa-bcf9-239bd383d3b5@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<358b5114-aeb3-d5fa-bcf9-239bd383d3b5@users.sourceforge.net>
Message-ID: <CAHC9VhR0DM_fC17O8_S85L=38HmOFQgcccfatPNkTiEHmoZ_bA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jan 15, 2017 at 10:18 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 19:19:42 +0100
>
> Adjust a jump target to avoid a function call at the end after a memory
> allocation failed for the local variable "ft".
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

It doesn't seem like this is worth adding another jump label.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 2be5b18eb149..5f122e846332 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1932,7 +1932,7 @@ static int filename_trans_read(struct policydb *p, void *fp)
>                 ft = kzalloc(sizeof(*ft), GFP_KERNEL);
>                 if (!ft) {
>                         rc = -ENOMEM;
> -                       goto out;
> +                       goto free_name;
>                 }
>
>                 otype = kmalloc(sizeof(*otype), GFP_KERNEL);
> @@ -1986,6 +1986,7 @@ static int filename_trans_read(struct policydb *p, void *fp)
>         return 0;
>  out:
>         kfree(ft);
> +free_name:
>         kfree(name);
>         kfree(otype);
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
