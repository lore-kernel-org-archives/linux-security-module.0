From: keescook@google.com (Kees Cook)
Date: Wed, 24 May 2017 12:32:41 -0700
Subject: [PATCH 2/3] apparmor: move to per loaddata files, instead of
	replicating in profiles
In-Reply-To: <20170511024625.13887-3-john.johansen@canonical.com>
References: <20170511024625.13887-1-john.johansen@canonical.com>
	<20170511024625.13887-3-john.johansen@canonical.com>
Message-ID: <CAGXu5jLmuODiaibmyGVyMPezZZ1v2OQNunNiSgvyATe5exs8UA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, May 10, 2017 at 7:46 PM, John Johansen
<john.johansen@canonical.com> wrote:
> The loaddata sets cover more than just a single profile and should
> be tracked at the ns level. Move the load data files under the namespace
> and reference the files from the profiles via a symlink.
>
> Signed-off-by: John Johansen <john.johansen@canonical.com>
> Reviewed-by: Seth Arnold <seth.arnold@canonical.com>
> ---
>  security/apparmor/apparmorfs.c            | 288 ++++++++++++++++++++++++------
>  security/apparmor/include/apparmorfs.h    |   5 +
>  security/apparmor/include/policy_ns.h     |   4 +
>  security/apparmor/include/policy_unpack.h |  67 ++++++-
>  security/apparmor/policy.c                |  42 ++++-
>  security/apparmor/policy_ns.c             |   2 +
>  security/apparmor/policy_unpack.c         |  49 ++++-
>  7 files changed, 393 insertions(+), 64 deletions(-)
>
> diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
> index 6d1a4a67abce..5a6010007046 100644
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -101,10 +101,10 @@ static struct aa_loaddata *aa_simple_write_to_buffer(const char __user *userbuf,
>         data = kvmalloc(sizeof(*data) + alloc_size);
>         if (data == NULL)
>                 return ERR_PTR(-ENOMEM);
> +       memset(data, 0, sizeof(*data));

kvzalloc instead of explicit memset...

Other than that, looks fine to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
