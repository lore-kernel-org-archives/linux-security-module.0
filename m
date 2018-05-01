From: keescook@chromium.org (Kees Cook)
Date: Tue, 1 May 2018 12:19:48 -0700
Subject: [PATCH v7 1/6] security: Move LSM registration arguments to
	struct lsm_info
In-Reply-To: <4184e7f3f244968a4fa411b8b91842665f317202.1524645853.git.sargun@sargun.me>
References: <cover.1524645853.git.sargun@sargun.me>
	<4184e7f3f244968a4fa411b8b91842665f317202.1524645853.git.sargun@sargun.me>
Message-ID: <CAGXu5jJ7FTTvJ0SgFF9kshWaiqbpx4ESmD1_S3-wiUYL6+4ufw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Apr 25, 2018 at 1:58 AM, Sargun Dhillon <sargun@sargun.me> wrote:
> Previously, when LSMs registered, they independently passed their name
> and hook count. This had two implications:
>
> 1) Is required us to clone the name, so we could present it in
>    security FS. This required memory allocation at start time.
> 2) Every time we wanted to tie more information back from
>    the security hooks, to the LSM, we would have to add
>    duplicated fields in struct security_hook_list.
>
> It also introduces a new file -- security/security.h, which is meant
> to be private headers to be shared only between pieces of security
> "infrastructure".
>
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> ---
>  include/linux/lsm_hooks.h  | 44 ++++++++++-------------
>  security/apparmor/lsm.c    |  6 ++--
>  security/commoncap.c       |  8 +++--
>  security/inode.c           | 56 +++++++++++++++++++++++++----
>  security/loadpin/loadpin.c |  4 ++-
>  security/security.c        | 89 +++++++++++++++++++++++-----------------------
>  security/security.h        | 10 ++++++
>  security/selinux/hooks.c   |  6 ++--
>  security/smack/smack_lsm.c |  3 +-
>  security/tomoyo/tomoyo.c   |  4 ++-
>  security/yama/yama_lsm.c   |  4 ++-
>  11 files changed, 147 insertions(+), 87 deletions(-)
>  create mode 100644 security/security.h
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 9d0b286f3dba..65f346cb6639 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2004,11 +2004,20 @@ struct security_hook_heads {
>   * Security module hook list structure.
>   * For use with generic list macros for common operations.
>   */
> +struct security_hook_list;
> +struct lsm_info {
> +       struct hlist_node               list;
> +       const char                      *name;
> +       const unsigned int              count;
> +       struct security_hook_list       *hooks;
> +} __randomize_layout;
> +
>  struct security_hook_list {
>         struct hlist_node               list;
>         struct hlist_head               *head;
>         union security_list_options     hook;
> -       char                            *lsm;
> +       /* This field is not currently in use */
> +       struct lsm_info                 *info;

const?

>  } __randomize_layout;
>
>  /*
> @@ -2020,33 +2029,18 @@ struct security_hook_list {
>  #define LSM_HOOK_INIT(HEAD, HOOK) \
>         { .head = &security_hook_heads.HEAD, .hook = { .HEAD = HOOK } }
>
> -extern struct security_hook_heads security_hook_heads;
> -extern char *lsm_names;
> +#define LSM_MODULE_INIT(NAME, HOOKS)           \
> +       {                                       \
> +               .name   = NAME,                 \
> +               .hooks  = HOOKS,                \
> +               .count  = ARRAY_SIZE(HOOKS),    \
> +       }

Instead of leaving this so every LSM has to do all the declarations, how about:

#define LSM_MODULE(NAME) \
    static const struct lsm_info NAME ## _info = { \
        .name = #NAME, \
        .hooks = NAME ## _hooks, \
        .count = ARRAY_SIZE(NAME ## _hooks), \
    }

> +static struct lsm_info apparmor_info =
> +       LSM_MODULE_INIT("apparmor", apparmor_hooks);

This becomes just:

LSM_MODULE(apparmor);

> +static struct lsm_info capability_info =
> +       LSM_MODULE_INIT("capability", capability_hooks);

LSM_MODULE(capability);

etc...

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
