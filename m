From: jannh@google.com (Jann Horn)
Date: Sun, 16 Sep 2018 03:27:42 +0200
Subject: [PATCH 07/18] LSM: Add minor LSM initialization loop
In-Reply-To: <20180916003059.1046-8-keescook@chromium.org>
References: <20180916003059.1046-1-keescook@chromium.org>
	<20180916003059.1046-8-keescook@chromium.org>
Message-ID: <CAG48ez3aU5XtQxUzWE3N3f4JyCz0jFchC=CAnHTZkGZaryWFxQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Sep 16, 2018 at 3:11 AM Kees Cook <keescook@chromium.org> wrote:
> Split initialization loop into two phases: "exclusive" LSMs and "minor"
> LSMs.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/lsm_hooks.h | 6 ++++++
>  security/security.c       | 8 +++++---
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index f8e618e2bdd2..ec3419b9b16f 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -2039,7 +2039,13 @@ extern char *lsm_names;
>  extern void security_add_hooks(struct security_hook_list *hooks, int count,
>                                 char *lsm);
>
> +enum lsm_type {
> +       LSM_TYPE_EXCLUSIVE = 0,
> +       LSM_TYPE_MINOR,
> +};

Is the intent of this explicit zero assignment that LSM_TYPE_EXCLUSIVE
should be the default? If so, perhaps a comment "/* default */", or
something like that, might be helpful.
