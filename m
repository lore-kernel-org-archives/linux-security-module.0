From: jmorris@namei.org (James Morris)
Date: Tue, 1 Aug 2017 10:52:22 +1000 (AEST)
Subject: [PATCH v4 15/15] exec: Consolidate pdeath_signal clearing
In-Reply-To: <1501545093-56634-16-git-send-email-keescook@chromium.org>
References: <1501545093-56634-1-git-send-email-keescook@chromium.org>
	<1501545093-56634-16-git-send-email-keescook@chromium.org>
Message-ID: <alpine.LRH.2.20.1708011052100.6845@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 31 Jul 2017, Kees Cook wrote:

> Instead of an additional secureexec check for pdeath_signal, just move it
> up into the initial secureexec test. Neither perf nor arch code touches
> pdeath_signal, so the relocation shouldn't change anything.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Acked-by: Serge Hallyn <serge@hallyn.com>


Reviewed-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
