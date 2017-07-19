From: paul@paul-moore.com (Paul Moore)
Date: Wed, 19 Jul 2017 19:56:46 -0400
Subject: [PATCH v3 02/15] exec: Rename bprm->cred_prepared to
	called_set_creds
In-Reply-To: <1500416736-49829-3-git-send-email-keescook@chromium.org>
References: <1500416736-49829-1-git-send-email-keescook@chromium.org>
	<1500416736-49829-3-git-send-email-keescook@chromium.org>
Message-ID: <CAHC9VhSEZaQpayvatnwY=-yT9un1ajdzFi8mFJ3ndWskzD1TTQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jul 18, 2017 at 6:25 PM, Kees Cook <keescook@chromium.org> wrote:
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
> ---
>  fs/binfmt_flat.c           | 2 +-
>  fs/exec.c                  | 2 +-
>  include/linux/binfmts.h    | 8 ++++++--
>  security/apparmor/domain.c | 2 +-
>  security/selinux/hooks.c   | 2 +-
>  security/smack/smack_lsm.c | 2 +-
>  security/tomoyo/tomoyo.c   | 2 +-
>  7 files changed, 12 insertions(+), 8 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
