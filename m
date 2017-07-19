From: luto@kernel.org (Andy Lutomirski)
Date: Tue, 18 Jul 2017 18:10:10 -0700
Subject: [PATCH v3 06/15] commoncap: Refactor to remove bprm_secureexec
	hook
In-Reply-To: <1500416736-49829-7-git-send-email-keescook@chromium.org>
References: <1500416736-49829-1-git-send-email-keescook@chromium.org>
	<1500416736-49829-7-git-send-email-keescook@chromium.org>
Message-ID: <CALCETrVwR580iJA-Wb=-Do+XhyfQhefp6R7Hxy=TLE53hMvFvw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jul 18, 2017 at 3:25 PM, Kees Cook <keescook@chromium.org> wrote:
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

Reviewed-by: Andy Lutomirski <luto@kernel.org>

with the redundant caveat that...

> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1330,6 +1330,13 @@ EXPORT_SYMBOL(would_dump);
>
>  void setup_new_exec(struct linux_binprm * bprm)
>  {
> +       /*
> +        * Once here, prepare_binrpm() will not be called any more, so
> +        * the final state of setuid/setgid/fscaps can be merged into the
> +        * secureexec flag.
> +        */
> +       bprm->secureexec |= bprm->cap_elevated;
> +

...the weird placement of the other assignments to bprm->secureexec
makes this exceedingly confusing.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
