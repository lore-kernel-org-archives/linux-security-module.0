From: jmorris@namei.org (James Morris)
Date: Tue, 1 Aug 2017 10:45:54 +1000 (AEST)
Subject: [PATCH v4 05/15] selinux: Refactor to remove bprm_secureexec hook
In-Reply-To: <1501545093-56634-6-git-send-email-keescook@chromium.org>
References: <1501545093-56634-1-git-send-email-keescook@chromium.org>
	<1501545093-56634-6-git-send-email-keescook@chromium.org>
Message-ID: <alpine.LRH.2.20.1708011045380.6845@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 31 Jul 2017, Kees Cook wrote:

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
> ---
>  security/selinux/hooks.c | 24 +++++-------------------
>  1 file changed, 5 insertions(+), 19 deletions(-)


Reviewed-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
