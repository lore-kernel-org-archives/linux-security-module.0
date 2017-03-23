From: paul@paul-moore.com (Paul Moore)
Date: Thu, 23 Mar 2017 18:12:24 -0400
Subject: [PATCH 19/46] selinux: Return directly after a failed
	next_entry() in range_read()
In-Reply-To: <9e75f8b7-1275-b2e6-a01c-d0c5ebac1a44@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<9e75f8b7-1275-b2e6-a01c-d0c5ebac1a44@users.sourceforge.net>
Message-ID: <CAHC9VhRvyZq_dMdvu3LoXO-rs87Xsm49vdKN75TrwRHH-awBrw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jan 15, 2017 at 10:19 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 19:35:59 +0100
>
> Return directly after a call of the function "next_entry" failed
> at the beginning.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged, thanks.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 5f122e846332..a696876fc327 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1850,7 +1850,7 @@ static int range_read(struct policydb *p, void *fp)
>
>         rc = next_entry(buf, fp, sizeof(u32));
>         if (rc)
> -               goto out;
> +               return rc;
>
>         nel = le32_to_cpu(buf[0]);
>         for (i = 0; i < nel; i++) {
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
