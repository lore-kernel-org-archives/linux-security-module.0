From: paul@paul-moore.com (Paul Moore)
Date: Wed, 29 Mar 2017 11:30:17 -0400
Subject: [PATCH 34/46] selinux: Return directly after a failed kzalloc()
	in common_read()
In-Reply-To: <caec05bb-b2ae-eda6-f052-32ed1d7c8c47@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<caec05bb-b2ae-eda6-f052-32ed1d7c8c47@users.sourceforge.net>
Message-ID: <CAHC9VhS-Cr2-AUxw5MSA93yBe0Hxpus+NZoM-x_YizVnVLnK0Q@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jan 15, 2017 at 10:34 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 15 Jan 2017 11:15:19 +0100
>
> Return directly after a call of the function "kzalloc" failed
> at the beginning.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 9035e5329ceb..551685283399 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1150,10 +1150,9 @@ static int common_read(struct policydb *p, struct hashtab *h, void *fp)
>         u32 len, nel;
>         int i, rc;
>
> -       rc = -ENOMEM;
>         comdatum = kzalloc(sizeof(*comdatum), GFP_KERNEL);
>         if (!comdatum)
> -               goto bad;
> +               return -ENOMEM;
>
>         rc = next_entry(buf, fp, sizeof buf);
>         if (rc)
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
