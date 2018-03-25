From: casey@schaufler-ca.com (Casey Schaufler)
Date: Sun, 25 Mar 2018 10:12:26 -0700
Subject: [PATCH] security: convert security hooks to use hlist
In-Reply-To: <6f9d93bdf8122230ea53823a07a9d79f0c3fdafe.1521972503.git.sargun@sargun.me>
References: <6f9d93bdf8122230ea53823a07a9d79f0c3fdafe.1521972503.git.sargun@sargun.me>
Message-ID: <39e2dfa9-8063-1aa5-cd69-5a57d4b8a231@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 3/25/2018 3:08 AM, Sargun Dhillon wrote:
> This changes security_hook_heads to use hlist_heads instead of
> the circular doubly-linked list heads. This should cut down
> the size of the struct by about half.

My only concern is with the possibility of making
security modules dynamically loadable and unloadable.
I know that Tetsuo is still hoping to have that, and
I have worked to make sure that we don't do anything
to preclude it. If he has no objection, I don't either.

>
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> ---
>  include/linux/lsm_hooks.h | 428 +++++++++++++++++++++++-----------------------
>  security/security.c       |  22 +--
>  2 files changed, 225 insertions(+), 225 deletions(-)


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
