From: keescook@chromium.org (Kees Cook)
Date: Tue, 28 Nov 2017 12:11:34 -0800
Subject: [PATCH v5 next 1/5] modules:capabilities: add request_module_cap()
In-Reply-To: <20171128191405.GO729@wotan.suse.de>
References: <1511803118-2552-1-git-send-email-tixxdz@gmail.com>
	<1511803118-2552-2-git-send-email-tixxdz@gmail.com>
	<20171128191405.GO729@wotan.suse.de>
Message-ID: <CAGXu5jKgHWNE4NH_xqcM084-BNBPy+HmEVPbTA+w_=K3S6gC=w@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Nov 28, 2017 at 11:14 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> kmod is just a helper to poke userpsace to load a module, that's it.
>
> The old init_module() and newer finit_module() do the real handy work or
> module loading, and both currently only use may_init_module():
>
> static int may_init_module(void)
> {
>         if (!capable(CAP_SYS_MODULE) || modules_disabled)
>                 return -EPERM;
>
>         return 0;
> }
>
> This begs the question:
>
>   o If userspace just tries to just use raw finit_module() do we want similar
>     checks?
>
> Otherwise, correct me if I'm wrong this all seems pointless.

Hm? That's direct-loading, not auto-loading. This series is only about
auto-loading.

We already have a global sysctl for blocking direct-loading (modules_disabled).

> If we want something similar I think we might need to be processing aliases and
> check for the aliases for their desired restrictions on finit_module(),

We don't need to handle aliases.

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
