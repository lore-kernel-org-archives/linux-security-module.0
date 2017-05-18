From: corbet@lwn.net (Jonathan Corbet)
Date: Thu, 18 May 2017 10:49:24 -0600
Subject: [PATCH 00/17] convert/reorganize Documentation/security/
In-Reply-To: <1494676313-144890-1-git-send-email-keescook@chromium.org>
References: <1494676313-144890-1-git-send-email-keescook@chromium.org>
Message-ID: <20170518104924.49824167@lwn.net>
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

I agree with the need for tweaks :)  I fixed up key-request.rst a bit
since I just couldn't stand it.

Anyway, the set is applied, many thanks for doing this!

jon
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
