From: paul@paul-moore.com (Paul Moore)
Date: Wed, 29 Mar 2017 11:45:05 -0400
Subject: [PATCH 43/46] selinux: Use kmalloc_array() in sidtab_init()
In-Reply-To: <9ce64f74-f424-b9c5-605b-a54982888e1a@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
	<9ce64f74-f424-b9c5-605b-a54982888e1a@users.sourceforge.net>
Message-ID: <CAHC9VhS4Wx95NH97o-2JnEaxpWtw31HW9LU7=5z1sqyzQKpHOQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jan 15, 2017 at 10:43 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 15 Jan 2017 13:13:19 +0100
>
> A multiplication for the size determination of a memory allocation
> indicated that an array data structure should be processed.
> Thus use the corresponding function "kmalloc_array".
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/sidtab.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged, thanks.

> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index 5840a35155fc..c9533b21942b 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -18,7 +18,7 @@ int sidtab_init(struct sidtab *s)
>  {
>         int i;
>
> -       s->htable = kmalloc(sizeof(*(s->htable)) * SIDTAB_SIZE, GFP_ATOMIC);
> +       s->htable = kmalloc_array(SIDTAB_SIZE, sizeof(*s->htable), GFP_ATOMIC);
>         if (!s->htable)
>                 return -ENOMEM;
>         for (i = 0; i < SIDTAB_SIZE; i++)
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
