From: jmorris@namei.org (James Morris)
Date: Wed, 19 Jul 2017 19:19:33 +1000 (AEST)
Subject: [PATCH v3 02/15] exec: Rename bprm->cred_prepared to
	called_set_creds
In-Reply-To: <1500416736-49829-3-git-send-email-keescook@chromium.org>
References: <1500416736-49829-1-git-send-email-keescook@chromium.org>
	<1500416736-49829-3-git-send-email-keescook@chromium.org>
Message-ID: <alpine.LRH.2.20.1707191919130.10539@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 18 Jul 2017, Kees Cook wrote:

> The cred_prepared bprm flag has a misleading name. It has nothing to do
> with the bprm_prepare_cred hook, and actually tracks if bprm_set_creds has
> been called. Rename this flag and improve its comment.
> 
> Cc: David Howells <dhowells@redhat.com>
> Cc: John Johansen <john.johansen@canonical.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: James Morris <james.l.morris@oracle.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>


Acked-by: James Morris <james.l.morris@oracle.com>

-- 

James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
