From: paul@paul-moore.com (Paul Moore)
Date: Wed, 29 Mar 2017 11:21:12 -0400
Subject: [PATCH 29/46] selinux: Return directly after a failed kzalloc()
	in type_read()
In-Reply-To: <3719abdd-0551-c567-31f0-94693a83d683@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<3719abdd-0551-c567-31f0-94693a83d683@users.sourceforge.net>
Message-ID: <CAHC9VhSGZYkLBQV1Ojwt8cfXQfb=M9NLgDwRJUcszc1M5DGz6A@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jan 15, 2017 at 10:29 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 22:15:54 +0100
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
> index 1c046d39e2a7..662139365449 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1467,10 +1467,9 @@ static int type_read(struct policydb *p, struct hashtab *h, void *fp)
>         __le32 buf[4];
>         u32 len;
>
> -       rc = -ENOMEM;
>         typdatum = kzalloc(sizeof(*typdatum), GFP_KERNEL);
>         if (!typdatum)
> -               goto bad;
> +               return -ENOMEM;
>
>         if (p->policyvers >= POLICYDB_VERSION_BOUNDARY)
>                 to_read = 4;
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
