From: paul@paul-moore.com (Paul Moore)
Date: Wed, 30 May 2018 11:19:42 -0400
Subject: [PATCH] selinux: KASAN: slab-out-of-bounds in xattr_getsecurity
In-Reply-To: <1527237099-9728-1-git-send-email-sgrover@codeaurora.org>
References: <1527237099-9728-1-git-send-email-sgrover@codeaurora.org>
Message-ID: <CAHC9VhQui+U1wzms2=XSW7MeRZg-faAzZyG8XU8wc+bWAoVzJg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, May 25, 2018 at 4:31 AM, Sachin Grover <sgrover@codeaurora.org> wrote:
> Call trace:
>  [<ffffff9203a8d7a8>] dump_backtrace+0x0/0x428
>  [<ffffff9203a8dbf8>] show_stack+0x28/0x38
>  [<ffffff920409bfb8>] dump_stack+0xd4/0x124
>  [<ffffff9203d187e8>] print_address_description+0x68/0x258
>  [<ffffff9203d18c00>] kasan_report.part.2+0x228/0x2f0
>  [<ffffff9203d1927c>] kasan_report+0x5c/0x70
>  [<ffffff9203d1776c>] check_memory_region+0x12c/0x1c0
>  [<ffffff9203d17cdc>] memcpy+0x34/0x68
>  [<ffffff9203d75348>] xattr_getsecurity+0xe0/0x160
>  [<ffffff9203d75490>] vfs_getxattr+0xc8/0x120
>  [<ffffff9203d75d68>] getxattr+0x100/0x2c8
>  [<ffffff9203d76fb4>] SyS_fgetxattr+0x64/0xa0
>  [<ffffff9203a83f70>] el0_svc_naked+0x24/0x28
>
> If user get root access and calls security.selinux setxattr() with an
> embedded NUL on a file and then if some process performs a getxattr()
> on that file with a length greater than the actual length of the string,
> it would result in a panic.
>
> To fix this, add the actual length of the string to the security context
> instead of the length passed by the userspace process.
>
> Signed-off-by: Sachin Grover <sgrover@codeaurora.org>
> ---
>  security/selinux/ss/services.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for reporting this and providing a patch.  It's small enough,
and passes all the regular tests, so I've merged it into
selinux/stable-4.17 (adding the stable metadata) and I'm going to send
it up to Linus today.

If Linus doesn't pull the fix in time for v4.17 I'll send it up during
the upcoming merge window.

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 66ea81c..d17f5b4 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1434,7 +1434,7 @@ static int security_context_to_sid_core(const char *scontext, u32 scontext_len,
>                                       scontext_len, &context, def_sid);
>         if (rc == -EINVAL && force) {
>                 context.str = str;
> -               context.len = scontext_len;
> +               context.len = strlen(str) + 1;
>                 str = NULL;
>         } else if (rc)
>                 goto out_unlock;
> --
> 1.9.1

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
