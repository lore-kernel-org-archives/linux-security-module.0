From: paul@paul-moore.com (Paul Moore)
Date: Wed, 29 Mar 2017 11:25:50 -0400
Subject: [PATCH 32/46] selinux: Return directly after a failed kzalloc()
	in class_read()
In-Reply-To: <6ceee0fa-a0ab-fe42-4213-f7985031ddfa@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<6ceee0fa-a0ab-fe42-4213-f7985031ddfa@users.sourceforge.net>
Message-ID: <CAHC9VhSKbHq=2Btj3Z1boNjPvugRARGmf0pOYwn_vBCgP_W5pw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jan 15, 2017 at 10:32 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 22:30:51 +0100
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
> index 49fc5d8990e9..3af2b0849495 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1316,10 +1316,9 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
>         u32 len, len2, ncons, nel;
>         int i, rc;
>
> -       rc = -ENOMEM;
>         cladatum = kzalloc(sizeof(*cladatum), GFP_KERNEL);
>         if (!cladatum)
> -               goto bad;
> +               return -ENOMEM;
>
>         rc = next_entry(buf, fp, sizeof(u32)*6);
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
