From: corbet@lwn.net (Jonathan Corbet)
Date: Mon, 15 May 2017 11:26:21 -0600
Subject: [PATCH 00/17] convert/reorganize Documentation/security/
In-Reply-To: <1494676313-144890-1-git-send-email-keescook@chromium.org>
References: <1494676313-144890-1-git-send-email-keescook@chromium.org>
Message-ID: <20170515112621.38aef111@lwn.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, 13 May 2017 04:51:36 -0700
Kees Cook <keescook@chromium.org> wrote:

> This ReSTifies everything under Documentation/security/, and reorganizes
> some of it (mainly the LSMs) under /admin-guide/ per Jon's request. Since
> /security/ is already being indexed under the kernel development portion
> of the sphinx index, I didn't move it, keeping only things that were
> directly related to internal kernel development (keys, creds, etc).
> 
> I also updated some path references, and MAINTAINERS lines. Some of the
> conversion could probably do with some tweaks, but I think this is a
> good first step in the right direction.

This all looks pretty good to me, though I'll confess I haven't actually
built the resulting docs yet.  Assuming no issues turn up there, I'd be
happy to just apply these and let any follow-on tweaks go from there.
Thanks for doing this, and for humoring me on the organizational issues :)

jon
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
