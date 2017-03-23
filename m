From: paul@paul-moore.com (Paul Moore)
Date: Thu, 23 Mar 2017 17:22:24 -0400
Subject: [PATCH 08/46] selinux: Delete an unnecessary return statement in
	policydb_destroy()
In-Reply-To: <1370e095-265d-9ca5-8184-b975fc75ead7@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<1370e095-265d-9ca5-8184-b975fc75ead7@users.sourceforge.net>
Message-ID: <CAHC9VhSaT39d9SXKQVa7fd5Ld52RUcYwkbnN6pmZ11JaNATC9Q@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jan 15, 2017 at 10:06 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 14:00:02 +0100
>
> The script "checkpatch.pl" pointed information out like the following.
>
> WARNING: void function return statements are not generally useful
>
> Thus remove such a statement in the affected function.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 2 --
>  1 file changed, 2 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 4d4ba1ad910d..fe8992382a71 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -878,8 +878,6 @@ void policydb_destroy(struct policydb *p)
>         ebitmap_destroy(&p->filename_trans_ttypes);
>         ebitmap_destroy(&p->policycaps);
>         ebitmap_destroy(&p->permissive_map);
> -
> -       return;
>  }
>
>  /*
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
