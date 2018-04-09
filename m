From: sargun@sargun.me (Sargun Dhillon)
Date: Sun, 8 Apr 2018 21:21:41 -0700
Subject: [PATCH v5 1/1] security: Add mechanism to safely (un)load LSMs
	after boot time
In-Reply-To: <201804090338.w393crfv005435@www262.sakura.ne.jp>
References: <20180408065916.GA2832@ircssh-2.c.rugged-nimbus-611.internal>
	<201804090338.w393crfv005435@www262.sakura.ne.jp>
Message-ID: <CAMp4zn8GOFk9EKCS9JaEsKayDZ+pLFORWBRHPaCCsN--EyvFVg@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Apr 8, 2018 at 8:38 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> Suggested changes on top of your patch:
>
>   Replace "struct hlist_head *head" in "struct security_hook_list" with
>   "const unsigned int offset" because there is no need to initialize with
>   address of the immutable/mutable chains.
>
>   Remove LSM_HOOK_INIT_MUTABLE() by embedding just offset (in bytes) from
>   head of "struct security_hook_heads" into "struct security_hook_list"->offset.
>
>   Make "struct security_hook_heads security_hook_heads" and
>   "struct security_hook_heads security_hook_heads_mutable" local variables.
>
>   Rename "struct security_hook_heads security_hook_heads" to
>   "struct security_hook_heads security_mutable_hook_heads" and mark it as
>   __ro_after_init.
>
>   Add the fourth argument to security_add_hooks() which specifies to which
>   chain (security_{mutable|immutable}_hook_heads) to connect.
>
>   Make all built-in LSM modules (except SELinux if
>   CONFIG_SECURITY_SELINUX_DISABLE=y) be connected to
>   security_immutable_hook_heads.
>
>   Rename __lsm_ro_after_init to __selinux_ro_after_init which is local to
>   SELinux.
>
>   Mark "struct security_hook_list"->hook const because it won't change.
>
>   Mark "struct security_hook_list"->lsm const because none of
>   security_add_hooks() callers are ready to modify the third argument.
>
>   Remove SECURITY_HOOK_COUNT and "struct security_hook_list"->owner and
>   the exception in randomize_layout_plugin.c because preventing module
>   unloading won't work as expected.
>

Rather than completely removing the unloading code, might it make
sense to add a BUG_ON or WARN_ON, in security_delete_hooks if
allow_unload_module is false, and owner is not NULL?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
