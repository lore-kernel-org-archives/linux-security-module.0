From: penguin-kernel@i-love.sakura.ne.jp (Tetsuo Handa)
Date: Mon, 09 Apr 2018 14:25:01 +0900
Subject: [PATCH v5 1/1] security: Add mechanism to safely (un)load LSMs
	after boot time
In-Reply-To: <CAMp4zn8GOFk9EKCS9JaEsKayDZ+pLFORWBRHPaCCsN--EyvFVg@mail.gmail.com>
References: <201804090338.w393crfv005435@www262.sakura.ne.jp>
	<CAMp4zn8GOFk9EKCS9JaEsKayDZ+pLFORWBRHPaCCsN--EyvFVg@mail.gmail.com>
Message-ID: <201804090525.w395P1qS044316@www262.sakura.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Sargun Dhillon wrote:
> >   Remove SECURITY_HOOK_COUNT and "struct security_hook_list"->owner and
> >   the exception in randomize_layout_plugin.c because preventing module
> >   unloading won't work as expected.
> >
> 
> Rather than completely removing the unloading code, might it make
> sense to add a BUG_ON or WARN_ON, in security_delete_hooks if
> allow_unload_module is false, and owner is not NULL?

Do we need to check ->owner != NULL? Although it will be true that
SELinux's ->owner == NULL and LKM-based LSM module's ->owner != NULL,
I think we unregister SELinux before setting allow_unload_module to false.
Thus, rejecting delete_security_hooks() if allow_unload_module == false will
be sufficient. SELinux might want to call panic() if delete_security_hooks()
did not unregister due to allow_unload_module == false. Also,
allow_unload_module would be renamed to allow_unregister_module.

By the way, please don't use BUG_ON() or WARN_ON() because syzbot would hit
and call panic() because syzbot runs tests with panic_on_warn == true.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
