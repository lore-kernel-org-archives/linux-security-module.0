From: jmorris@namei.org (James Morris)
Date: Tue, 1 Aug 2017 10:44:20 +1000 (AEST)
Subject: [PATCH v4 03/15] binfmt: Introduce secureexec flag
In-Reply-To: <1501545093-56634-4-git-send-email-keescook@chromium.org>
References: <1501545093-56634-1-git-send-email-keescook@chromium.org>
	<1501545093-56634-4-git-send-email-keescook@chromium.org>
Message-ID: <alpine.LRH.2.20.1708011043470.6845@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 31 Jul 2017, Kees Cook wrote:

> Cc: David Howells <dhowells@redhat.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>
> ---
>  fs/binfmt_elf.c         | 2 +-
>  fs/binfmt_elf_fdpic.c   | 2 +-
>  fs/exec.c               | 2 ++
>  include/linux/binfmts.h | 6 ++++++
>  4 files changed, 10 insertions(+), 2 deletions(-)
> 


Reviewed-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
