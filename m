From: keescook@chromium.org (Kees Cook)
Date: Thu, 20 Sep 2018 10:39:26 -0700
Subject: [PATCH v3 14/16] LSM: Infrastructure management of the task
	security blob
In-Reply-To: <6456aa25-6890-6d54-51c5-03c5daf0c6fb@schaufler-ca.com>
References: <748c61cb-b6fa-c36d-a7b3-2315ff6292af@schaufler-ca.com>
	<6456aa25-6890-6d54-51c5-03c5daf0c6fb@schaufler-ca.com>
Message-ID: <CAGXu5jJ6xF0zvDThL+z9VxH2Y2WZg+0vKw4RUa=c8+dUQOGKpg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Sep 19, 2018 at 5:21 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:

> diff --git a/security/security.c b/security/security.c
> index 2501cdcbebff..7e11de7eec21 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -116,7 +116,8 @@ int __init security_init(void)
>  #ifdef CONFIG_SECURITY_LSM_DEBUG
>         pr_info("LSM: cred blob size       = %d\n", blob_sizes.lbs_cred);
>         pr_info("LSM: file blob size       = %d\n", blob_sizes.lbs_file);
> -       pr_info("LSM: inode blob size       = %d\n", blob_sizes.lbs_inode);
> +       pr_info("LSM: inode blob size      = %d\n", blob_sizes.lbs_inode);
> +       pr_info("LSM: task blob size       = %d\n", blob_sizes.lbs_task);
>  #endif

This alignment adjustment should be moved to the patch that adds the inode line.

(And this patch might want to mention it is changing the only task
blob user, AppArmor, or split that out into a separate patch.)

-Kees

-- 
Kees Cook
Pixel Security
