From: paul@paul-moore.com (Paul Moore)
Date: Thu, 23 Mar 2017 17:54:29 -0400
Subject: [PATCH 14/46] selinux: One function call less in genfs_read()
	after null pointer detection
In-Reply-To: <202d7312-b266-ce9d-8f7a-3e8282c7b0c5@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<202d7312-b266-ce9d-8f7a-3e8282c7b0c5@users.sourceforge.net>
Message-ID: <CAHC9VhQpXW8FezS0f1NNKfLAO790+JXOhS16A6ZL7kVdFOvtoA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jan 15, 2017 at 10:14 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 17:43:47 +0100
>
> Call the function "kfree" at the end only after it was determined
> that the local variable "newgenfs" contained a non-null pointer.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index a12d9166f0e4..5dc31faa601f 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -2096,9 +2096,10 @@ static int genfs_read(struct policydb *p, void *fp)
>         }
>         rc = 0;
>  out:
> -       if (newgenfs)
> +       if (newgenfs) {
>                 kfree(newgenfs->fstype);
> -       kfree(newgenfs);
> +               kfree(newgenfs);
> +       }
>         ocontext_destroy(newc, OCON_FSUSE);
>
>         return rc;
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
