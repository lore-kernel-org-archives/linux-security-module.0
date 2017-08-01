From: jmorris@namei.org (James Morris)
Date: Tue, 1 Aug 2017 10:50:03 +1000 (AEST)
Subject: [PATCH v4 11/15] exec: Use secureexec for clearing pdeath_signal
In-Reply-To: <1501545093-56634-12-git-send-email-keescook@chromium.org>
References: <1501545093-56634-1-git-send-email-keescook@chromium.org>
	<1501545093-56634-12-git-send-email-keescook@chromium.org>
Message-ID: <alpine.LRH.2.20.1708011049420.6845@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 31 Jul 2017, Kees Cook wrote:

> Cc: David Howells <dhowells@redhat.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Acked-by: Serge Hallyn <serge@hallyn.com>
> ---
>  fs/exec.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)


Reviewed-by: James Morris <james.l.morris@oracle.com>

-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
