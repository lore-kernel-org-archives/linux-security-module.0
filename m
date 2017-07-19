From: jmorris@namei.org (James Morris)
Date: Wed, 19 Jul 2017 19:28:31 +1000 (AEST)
Subject: [PATCH v3 07/15] commoncap: Move cap_elevated calculation into
	bprm_set_creds
In-Reply-To: <1500416736-49829-8-git-send-email-keescook@chromium.org>
References: <1500416736-49829-1-git-send-email-keescook@chromium.org>
	<1500416736-49829-8-git-send-email-keescook@chromium.org>
Message-ID: <alpine.LRH.2.20.1707191928090.10539@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 18 Jul 2017, Kees Cook wrote:

> Instead of a separate function, open-code the cap_elevated test, which
> lets us entirely remove bprm->cap_effective (to use the local "effective"
> variable instead), and more accurately examine euid/egid changes via the
> existing local "is_setid".
> 
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>


Reviewed-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
