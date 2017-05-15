From: corbet@lwn.net (Jonathan Corbet)
Date: Mon, 15 May 2017 11:21:49 -0600
Subject: [PATCH 06/17] doc: security: minor cleanups to build kernel-doc
In-Reply-To: <alpine.LRH.2.20.1705150915360.29831@namei.org>
References: <1494676313-144890-1-git-send-email-keescook@chromium.org>
	<1494676313-144890-7-git-send-email-keescook@chromium.org>
	<alpine.LRH.2.20.1705150915360.29831@namei.org>
Message-ID: <20170515112149.2ef38651@lwn.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 15 May 2017 09:17:25 +1000 (AEST)
James Morris <jmorris@namei.org> wrote:

> On Sat, 13 May 2017, Kees Cook wrote:
> 
> > These fixes were needed to parse lsm_hooks.h kernel-doc. More work is
> > needed, but this is the first step.
> > 
> > Cc: Casey Schaufler <casey@schaufler-ca.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>  
> 
> Should these changes go in via the docs tree or mine?
> 
> In any case:
> Acked-by: James Morris <james.l.morris@oracle.com>

These changes are entirely independent from the documentation stuff, so it
could really go either way.  I'm happy to carry them with the set, if that
works for you.

Thanks,

jon
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
