From: paul@paul-moore.com (Paul Moore)
Date: Wed, 29 Mar 2017 11:48:29 -0400
Subject: [PATCH 44/46] selinux: Adjust two checks for null pointers
In-Reply-To: <e12da517-36fb-2247-e9b4-488708d6cda7@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<e12da517-36fb-2247-e9b4-488708d6cda7@users.sourceforge.net>
Message-ID: <CAHC9VhSgWhY-CwU3zcaEqDYmmusT22c=Uvq=Yc2KvVcKG+YYnA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jan 15, 2017 at 10:44 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 15 Jan 2017 13:30:20 +0100
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
>
> The script "checkpatch.pl" pointed information out like the following.
>
> Comparison to NULL could be written !?
>
> Thus fix affected source code places.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/sidtab.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Merged.

Definitely code churn, but arguably there is some minor value in
making checkpatch.pl happy.  In the future changes like this should be
bundled with more significant changes to make them more appealing.

> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index c9533b21942b..f6915f257486 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -54,7 +54,7 @@ int sidtab_insert(struct sidtab *s, u32 sid, struct context *context)
>         }
>
>         newnode = kmalloc(sizeof(*newnode), GFP_ATOMIC);
> -       if (newnode == NULL) {
> +       if (!newnode) {
>                 rc = -ENOMEM;
>                 goto out;
>         }
> @@ -98,7 +98,7 @@ static struct context *sidtab_search_core(struct sidtab *s, u32 sid, int force)
>         if (force && cur && sid == cur->sid && cur->context.len)
>                 return &cur->context;
>
> -       if (cur == NULL || sid != cur->sid || cur->context.len) {
> +       if (!cur || sid != cur->sid || cur->context.len) {
>                 /* Remap invalid SIDs to the unlabeled SID. */
>                 sid = SECINITSID_UNLABELED;
>                 hvalue = SIDTAB_HASH(sid);
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
