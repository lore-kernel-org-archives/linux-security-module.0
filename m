From: paul@paul-moore.com (Paul Moore)
Date: Thu, 23 Mar 2017 17:46:07 -0400
Subject: [PATCH 11/46] selinux: Return directly after a failed
	next_entry() in genfs_read()
In-Reply-To: <767b0ef6-2693-2de3-897f-c1989870676f@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<767b0ef6-2693-2de3-897f-c1989870676f@users.sourceforge.net>
Message-ID: <CAHC9VhToRUzavoAOTRJQNDmZAAxtptwt6L1T4a9Og70o6uo3Xw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jan 15, 2017 at 10:11 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 16:34:25 +0100
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
> index 506b0228d1f1..754f829d2027 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -2004,7 +2004,7 @@ static int genfs_read(struct policydb *p, void *fp)
>
>         rc = next_entry(buf, fp, sizeof(u32));
>         if (rc)
> -               goto out;
> +               return rc;
>         nel = le32_to_cpu(buf[0]);
>
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
