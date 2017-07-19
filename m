From: jmorris@namei.org (James Morris)
Date: Wed, 19 Jul 2017 19:21:55 +1000 (AEST)
Subject: [PATCH v3 03/15] apparmor: Refactor to remove bprm_secureexec hook
In-Reply-To: <1500416736-49829-4-git-send-email-keescook@chromium.org>
References: <1500416736-49829-1-git-send-email-keescook@chromium.org>
	<1500416736-49829-4-git-send-email-keescook@chromium.org>
Message-ID: <alpine.LRH.2.20.1707191921360.10539@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 18 Jul 2017, Kees Cook wrote:

> The AppArmor bprm_secureexec hook can be merged with the bprm_set_creds
> hook since it's dealing with the same information, and all of the details
> are finalized during the first call to the bprm_set_creds hook via
> prepare_binprm() (subsequent calls due to binfmt_script, etc, are ignored
> via bprm->called_set_creds).
> 
> Here, all the comments describe how secureexec is actually calculated
> during bprm_set_creds, so this actually does it, drops the bprm flag that
> was being used internally by AppArmor, and drops the bprm_secureexec hook.
> 
> Cc: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>


Reviewed-by: James Morris <james.l.morris@oracle.com>

-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
