From: paul@paul-moore.com (Paul Moore)
Date: Thu, 23 Mar 2017 18:09:32 -0400
Subject: [PATCH 17/46] selinux: Delete an unnecessary variable assignment
	in filename_trans_read()
In-Reply-To: <71120ef7-6463-6497-f915-fcaf9e54239d@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<71120ef7-6463-6497-f915-fcaf9e54239d@users.sourceforge.net>
Message-ID: <CAHC9VhToUf-sncer+NWwwVUA1yP1D1j03AQ_5rFgpd8VVVs05w@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jan 15, 2017 at 10:17 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 19:02:42 +0100
>
> The local variable "ft" was set to a null pointer despite of an
> immediate reassignment.
> Thus remove this statement from the beginning of a loop.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/policydb.c | 1 -
>  1 file changed, 1 deletion(-)

Merged, thanks.

> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 106a1da1d68a..2be5b18eb149 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1927,7 +1927,6 @@ static int filename_trans_read(struct policydb *p, void *fp)
>         nel = le32_to_cpu(buf[0]);
>
>         for (i = 0; i < nel; i++) {
> -               ft = NULL;
>                 otype = NULL;
>                 name = NULL;
>                 ft = kzalloc(sizeof(*ft), GFP_KERNEL);
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
