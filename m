From: keescook@chromium.org (Kees Cook)
Date: Wed, 18 Jul 2018 22:44:52 -0700
Subject: Fwd: [PATCH] security: Add LSM fixup hooks to set*gid syscalls.
In-Reply-To: <CAGXu5jLEs4b3ki8t=bVgrny9JZxDTKgoWdvryC45cj_mO93Y2A@mail.gmail.com>
References: <CAJ-EccNh5B84yowXL4u5-X8m-jYhOtuRwBOmstUnCB5Tc74dBg@mail.gmail.com>
	<CAGXu5j+ha--Hw_o0W9A5VKqXgy3nXuxU9+049akj9=dA0KdMRw@mail.gmail.com>
	<CAJ-EccPgpUg_ytam8HhiELTXJR933RbQcJzgEgc49nKS3uo-qA@mail.gmail.com>
	<CAGXu5jLEs4b3ki8t=bVgrny9JZxDTKgoWdvryC45cj_mO93Y2A@mail.gmail.com>
Message-ID: <CAGXu5jJY1o9PMVxkoRWF_r6mJwBB8KK98AYsArNNCX4uBALD6w@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

[resending... list Cc got accidentally dropped...]


On Tue, Jul 17, 2018 at 2:40 PM, Micah Morton <mortonm@chromium.org> wrote:
>
>
> On Tue, Jul 17, 2018 at 1:19 PM Kees Cook <keescook@chromium.org> wrote:
>> Also, I think this needs a LSM_HOOK_INIT call somewhere too?
>
>
> Isn't that something that goes in the particular LSMs which may or may not
> want to use the hook?
> https://elixir.bootlin.com/linux/v4.18-rc2/ident/LSM_HOOK_INIT

Oops, yes, I got myself confused. I was thinking about a wrapper for
call_int_hook() which you already added. Thanks!

Please send an explicit "[PATCH v2] ..." email with the indentation
fixes (it's hard for maintainers to extract patches from a follow-up
like it was), and feel free to include:

Acked-by: Kees Cook <keescook@chromium.org>

after your Signed-off-by.

Thanks!

-Kees


-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
