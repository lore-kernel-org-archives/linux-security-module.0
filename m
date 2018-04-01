From: sargun@sargun.me (Sargun Dhillon)
Date: Sat, 31 Mar 2018 22:15:39 -0700
Subject: [PATCH] security: Split out hook definitions into lsm_hook_types.h
In-Reply-To: <20180401024015.GA13870@ircssh-2.c.rugged-nimbus-611.internal>
References: <20180401024015.GA13870@ircssh-2.c.rugged-nimbus-611.internal>
Message-ID: <CAMp4zn8EkqQZDc1UW9ux0za+99DHpKAXVx72CMzuwApVFZ_=SQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Mar 31, 2018 at 7:40 PM, Sargun Dhillon <sargun@sargun.me> wrote:
> This moves all of the LSM hooks type information into a separate file,
> lsm_hook_types.h. This enables us to use this file, along with macros
> to generate the security_hook_heads struct, as well as the security
> hooks union without having to duplicate definitions.
>
> Since the fall-back hooks still require some logic (dispatching
> to commoncap, nulling out some buffer, etc..), they still must
> be created manually.
>
> This will be useful for further datastructures which want to use
> the set of security hooks in a completely unrolled way, along
> with the type information there within.
>
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> ---
>  include/linux/lsm_hook_types.h | 1695 ++++++++++++++++++++++++++++++++++
>  include/linux/lsm_hooks.h      | 1946 +---------------------------------------
>  include/linux/security.h       |  416 ++-------
>  kernel/time/time.c             |    6 +-
>  security/security.c            |    2 +-
>  5 files changed, 1783 insertions(+), 2282 deletions(-)
>  create mode 100644 include/linux/lsm_hook_types.h
>
>
Upon further thought, this patch is somewhat unwieldy. I intent to
split it up. I plan to split it into the following:
1. Fixing the settimeofday64 weirdness
2. 1:1 move from lsm_hooks.h to lsm_hook_types.h of the hook
definitions (union + comments)
3. Rewiring lsm_hooks.h to use macros only
4. Rewiring security.h to use macros only

Does that sound reasonable?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
