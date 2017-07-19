From: jmorris@namei.org (James Morris)
Date: Wed, 19 Jul 2017 19:26:28 +1000 (AEST)
Subject: [PATCH v3 06/15] commoncap: Refactor to remove bprm_secureexec
	hook
In-Reply-To: <1500416736-49829-7-git-send-email-keescook@chromium.org>
References: <1500416736-49829-1-git-send-email-keescook@chromium.org>
	<1500416736-49829-7-git-send-email-keescook@chromium.org>
Message-ID: <alpine.LRH.2.20.1707191925410.10539@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 18 Jul 2017, Kees Cook wrote:

> The commoncap implementation of the bprm_secureexec hook is the only LSM
> that depends on the final call to its bprm_set_creds hook (since it may
> be called for multiple files, it ignores bprm->called_set_creds). As a
> result, it cannot safely _clear_ bprm->secureexec since other LSMs may
> have set it.  Instead, remove the bprm_secureexec hook by introducing a
> new flag to bprm specific to commoncap: cap_elevated. This is similar to
> cap_effective, but that is used for a specific subset of elevated
> privileges, and exists solely to track state from bprm_set_creds to
> bprm_secureexec. As such, it will be removed in the next patch.
> 
> Here, set the new bprm->cap_elevated flag when setuid/setgid has happened
> from bprm_fill_uid() or fscapabilities have been prepared. This temporarily
> moves the bprm_secureexec hook to a static inline. The helper will be
> removed in the next patch; this makes the step easier to review and bisect,
> since this does not introduce any changes to inputs nor outputs to the
> "elevated privileges" calculation.
> 
> The new flag is merged with the bprm->secureexec flag in setup_new_exec()
> since this marks the end of any further prepare_binprm() calls.
> 
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>


Acked-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
