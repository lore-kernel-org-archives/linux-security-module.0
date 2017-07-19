From: jmorris@namei.org (James Morris)
Date: Wed, 19 Jul 2017 19:42:53 +1000 (AEST)
Subject: [PATCH v3 14/15] exec: Use sane stack rlimit under secureexec
In-Reply-To: <1500416736-49829-15-git-send-email-keescook@chromium.org>
References: <1500416736-49829-1-git-send-email-keescook@chromium.org>
	<1500416736-49829-15-git-send-email-keescook@chromium.org>
Message-ID: <alpine.LRH.2.20.1707191942400.10539@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 18 Jul 2017, Kees Cook wrote:

> For a secureexec, before memory layout selection has happened, reset the
> stack rlimit to something sane to avoid the caller having control over
> the resulting layouts.
> 
> $ ulimit -s
> 8192
> $ ulimit -s unlimited
> $ /bin/sh -c 'ulimit -s'
> unlimited
> $ sudo /bin/sh -c 'ulimit -s'
> 8192
> 
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>


Reviewed-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
