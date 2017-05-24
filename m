From: keescook@google.com (Kees Cook)
Date: Wed, 24 May 2017 12:38:25 -0700
Subject: [PATCH 3/3] apparmor: virtualize the policy/ directory
In-Reply-To: <20170511024625.13887-4-john.johansen@canonical.com>
References: <20170511024625.13887-1-john.johansen@canonical.com>
	<20170511024625.13887-4-john.johansen@canonical.com>
Message-ID: <CAGXu5j+zjx5WKC62eEj1zDpQ4Lpq4g8GnqAA5MNP+B6DZL0UHg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, May 10, 2017 at 7:46 PM, John Johansen
<john.johansen@canonical.com> wrote:
> virtualize the apparmor policy/ directory so that the current namespace
> affects what part of policy is seen. This is done by
>
>  * creating a new apparmorfs filesystem
>  * creating a magic symlink from securityfs to the correct apparmorfs
>    file in the tree (similar to nsfs use).
>
> apparmor fs data and fns also get renamed some to help indicate where
> they are used
>
>   aafs - special magic apparmorfs
>   aa_sfs - for fns/data that go into securityfs
>   aa_fs - for fns/data that may be used in the either of aafs or securityfs
>
> Signed-off-by: John Johansen <john.johansen@canonical.com>
> Reviewed-by: Seth Arnold <seth.arnold@canonical.com>

This all looks fine to me. If you do a v2 of these patches, it might
make sense to split up some of the logical changes here. For example,
have one patch that does the renamings but no code changes. Then add
the new fs, and finally integrate the new fs. That might make it
easier to review. Regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
