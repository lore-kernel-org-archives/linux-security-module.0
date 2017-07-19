From: jmorris@namei.org (James Morris)
Date: Wed, 19 Jul 2017 19:29:26 +1000 (AEST)
Subject: [PATCH v3 08/15] LSM: drop bprm_secureexec hook
In-Reply-To: <1500416736-49829-9-git-send-email-keescook@chromium.org>
References: <1500416736-49829-1-git-send-email-keescook@chromium.org>
	<1500416736-49829-9-git-send-email-keescook@chromium.org>
Message-ID: <alpine.LRH.2.20.1707191929070.10539@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 18 Jul 2017, Kees Cook wrote:

> This removes the bprm_secureexec hook since the logic has been folded into
> the bprm_set_creds hook for all LSMs now.
> 
> Cc: James Morris <james.l.morris@oracle.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/binfmt_elf.c           |  1 -
>  fs/binfmt_elf_fdpic.c     |  1 -
>  include/linux/lsm_hooks.h | 14 +++++---------
>  include/linux/security.h  |  7 -------
>  security/security.c       |  5 -----
>  5 files changed, 5 insertions(+), 23 deletions(-)


Acked-by: James Morris <james.l.morris@oracle.com>

-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
