From: keescook@chromium.org (Kees Cook)
Date: Sat, 13 May 2017 04:51:36 -0700
Subject: [PATCH 00/17] convert/reorganize Documentation/security/
Message-ID: <1494676313-144890-1-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi,

This ReSTifies everything under Documentation/security/, and reorganizes
some of it (mainly the LSMs) under /admin-guide/ per Jon's request. Since
/security/ is already being indexed under the kernel development portion
of the sphinx index, I didn't move it, keeping only things that were
directly related to internal kernel development (keys, creds, etc).

I also updated some path references, and MAINTAINERS lines. Some of the
conversion could probably do with some tweaks, but I think this is a
good first step in the right direction.

-Kees

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
