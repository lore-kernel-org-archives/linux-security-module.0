From: keescook@chromium.org (Kees Cook)
Date: Wed, 5 Sep 2018 15:23:08 -0700
Subject: [PATCH] seccomp: remove unnecessary unlikely()
In-Reply-To: <20180905203443.32289-1-igor.stoppa@huawei.com>
References: <20180905203443.32289-1-igor.stoppa@huawei.com>
Message-ID: <CAGXu5j+e2n6pUW+40ZNm5qifd8dVEEryN-Qfqe7ok-KZHP1Hyw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Sep 5, 2018 at 1:34 PM, Igor Stoppa <igor.stoppa@gmail.com> wrote:
> WARN_ON() already contains an unlikely(), so it's not necessary to wrap it
> into another.
>
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> Acked-by: Kees Cook <keescook@chromium.org>

Should I take this, or is it part of your series going somewhere else?

-Kees

> Cc: linux-security-module at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  kernel/seccomp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index fd023ac24e10..5a2a9af4663e 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -195,7 +195,7 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd,
>                         READ_ONCE(current->seccomp.filter);
>
>         /* Ensure unexpected behavior doesn't result in failing open. */
> -       if (unlikely(WARN_ON(f == NULL)))
> +       if (WARN_ON(f == NULL))
>                 return SECCOMP_RET_KILL_PROCESS;
>
>         if (!sd) {
> @@ -297,7 +297,7 @@ static inline pid_t seccomp_can_sync_threads(void)
>                 /* Return the first thread that cannot be synchronized. */
>                 failed = task_pid_vnr(thread);
>                 /* If the pid cannot be resolved, then return -ESRCH */
> -               if (unlikely(WARN_ON(failed == 0)))
> +               if (WARN_ON(failed == 0))
>                         failed = -ESRCH;
>                 return failed;
>         }
> --
> 2.17.1
>



-- 
Kees Cook
Pixel Security
