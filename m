From: jmorris@namei.org (James Morris)
Date: Tue, 1 Aug 2017 10:50:29 +1000 (AEST)
Subject: [PATCH v4 12/15] smack: Remove redundant pdeath_signal
 clearing
In-Reply-To: <1501545093-56634-13-git-send-email-keescook@chromium.org>
References: <1501545093-56634-1-git-send-email-keescook@chromium.org>
	<1501545093-56634-13-git-send-email-keescook@chromium.org>
Message-ID: <alpine.LRH.2.20.1708011050170.6845@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 31 Jul 2017, Kees Cook wrote:

> This removes the redundant pdeath_signal clearing in Smack: the check in
> smack_bprm_committing_creds() matches the check in smack_bprm_set_creds()
> (which used to be in the now-removed smack_bprm_securexec() hook) and
> since secureexec is now being checked for clearing pdeath_signal, this
> is redundant to the common exec code.
> 
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Acked-by: Serge Hallyn <serge@hallyn.com>
> ---
>  security/smack/smack_lsm.c | 15 ---------------
>  1 file changed, 15 deletions(-)


Reviewed-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
