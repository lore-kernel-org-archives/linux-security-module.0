From: sargun@sargun.me (Sargun Dhillon)
Date: Mon, 26 Mar 2018 12:33:43 -0700
Subject: [PATCH] security: convert security hooks to use hlist
In-Reply-To: <201803262007.BDF21886.OJOFLVMHFQSFOt@I-love.SAKURA.ne.jp>
References: <6f9d93bdf8122230ea53823a07a9d79f0c3fdafe.1521972503.git.sargun@sargun.me>
	<39e2dfa9-8063-1aa5-cd69-5a57d4b8a231@schaufler-ca.com>
	<201803262007.BDF21886.OJOFLVMHFQSFOt@I-love.SAKURA.ne.jp>
Message-ID: <CAMp4zn8690cvF4c_Saf2K8fefbCWQDj1oveof7cDeG6D8N=4NA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Mar 26, 2018 at 4:07 AM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> Casey Schaufler wrote:
>> On 3/25/2018 3:08 AM, Sargun Dhillon wrote:
>> > This changes security_hook_heads to use hlist_heads instead of
>> > the circular doubly-linked list heads. This should cut down
>> > the size of the struct by about half.
>>
>> My only concern is with the possibility of making
>> security modules dynamically loadable and unloadable.
>> I know that Tetsuo is still hoping to have that, and
>> I have worked to make sure that we don't do anything
>> to preclude it. If he has no objection, I don't either.
>>
>
> Changing from "struct list_head" to "struct hlist_head" does not affect LKM-based LSMs.
> If Sargun makes that change, please fold below changes because
>
>   for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head); i++) INIT_HLIST_HEAD(&list[i]);
>
> is equivalent to
>
>   memset(&security_hook_heads, 0, sizeof(security_hook_heads));
>
> which is not required because security_hook_heads is automatically initialized with 0,
> and we can also revert commit fd466e068e5adef5 ("randstruct: Whitelist struct
> security_hook_heads cast").
If you see my RFC patch, it still needs to do this in order to add the
mutable hooks. If we commit this change without the mutable hooks bit,
we can just remove the initialization component.

> ---
>  scripts/gcc-plugins/randomize_layout_plugin.c | 2 --
>  security/security.c                           | 6 ------
>  2 files changed, 8 deletions(-)
>
> diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
> index c4a345c..d941389 100644
> --- a/scripts/gcc-plugins/randomize_layout_plugin.c
> +++ b/scripts/gcc-plugins/randomize_layout_plugin.c
> @@ -52,8 +52,6 @@ struct whitelist_entry {
>         { "net/unix/af_unix.c", "unix_skb_parms", "char" },
>         /* big_key payload.data struct splashing */
>         { "security/keys/big_key.c", "path", "void *" },
> -       /* walk struct security_hook_heads as an array of struct list_head */
> -       { "security/security.c", "list_head", "security_hook_heads" },
>         { }
>  };
>
> diff --git a/security/security.c b/security/security.c
> index 3cafff6..90d53c5 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -60,12 +60,6 @@ static void __init do_security_initcalls(void)
>   */
>  int __init security_init(void)
>  {
> -       int i;
> -       struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
> -
> -       for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head);
> -            i++)
> -               INIT_HLIST_HEAD(&list[i]);
>         pr_info("Security Framework initialized\n");
>
>         /*
> --
> 1.8.3.1
>
>> >
>> > Signed-off-by: Sargun Dhillon <sargun@sargun.me>
>> > ---
>> >  include/linux/lsm_hooks.h | 428 +++++++++++++++++++++++-----------------------
>> >  security/security.c       |  22 +--
>> >  2 files changed, 225 insertions(+), 225 deletions(-)
>>
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
