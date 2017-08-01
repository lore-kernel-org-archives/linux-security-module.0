From: luto@kernel.org (Andy Lutomirski)
Date: Tue, 1 Aug 2017 06:24:42 -0700
Subject: [PATCH v4 05/15] selinux: Refactor to remove bprm_secureexec hook
In-Reply-To: <1501545093-56634-6-git-send-email-keescook@chromium.org>
References: <1501545093-56634-1-git-send-email-keescook@chromium.org>
	<1501545093-56634-6-git-send-email-keescook@chromium.org>
Message-ID: <CALCETrXhuqvDUbHRZSa7gTwpbVrg1N7SH-Px7nWUWhP6p9JXmQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Jul 31, 2017 at 4:51 PM, Kees Cook <keescook@chromium.org> wrote:
> The SELinux bprm_secureexec hook can be merged with the bprm_set_creds
> hook since it's dealing with the same information, and all of the details
> are finalized during the first call to the bprm_set_creds hook via
> prepare_binprm() (subsequent calls due to binfmt_script, etc, are ignored
> via bprm->called_set_creds).
>
> Here, the test can just happen at the end of the bprm_set_creds hook,
> and the bprm_secureexec hook can be dropped.
>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Acked-by: Paul Moore <paul@paul-moore.com>
> Tested-by: Paul Moore <paul@paul-moore.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>

Reviewed-by: Andy Lutomirski <luto@kernel.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
