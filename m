From: jmorris@namei.org (James Morris)
Date: Tue, 1 Aug 2017 10:48:17 +1000 (AEST)
Subject: [PATCH v4 10/15] exec: Use secureexec for setting dumpability
In-Reply-To: <1501545093-56634-11-git-send-email-keescook@chromium.org>
References: <1501545093-56634-1-git-send-email-keescook@chromium.org>
	<1501545093-56634-11-git-send-email-keescook@chromium.org>
Message-ID: <alpine.LRH.2.20.1708011048030.6845@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 31 Jul 2017, Kees Cook wrote:

> The examination of "current" to decide dumpability is wrong. This was a
> check of and euid/uid (or egid/gid) mismatch in the existing process,
> not the newly created one. This appears to stretch back into even the
> "history.git" tree. Luckily, dumpability is later set in commit_creds().
> In earlier kernel versions before creds existed, similar checks also
> existed late in the exec flow, covering up the mistake as far back as I
> could find.
> 
> Note that because the commit_creds() check examines differences of euid,
> uid, egid, gid, and capabilities between the old and new creds, it would
> look like the setup_new_exec() dumpability test could be entirely removed.
> However, the secureexec test may cover a different set of tests (specific
> to the LSMs) than what commit_creds() checks for. So, fix this test to
> use secureexec (the removed euid tests are redundant to the commoncap
> secureexec checks now).
> 
> Cc: David Howells <dhowells@redhat.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Acked-by: Serge Hallyn <serge@hallyn.com>
> ---
>  fs/exec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
