From: keescook@chromium.org (Kees Cook)
Date: Fri,  7 Jul 2017 12:56:58 -0700
Subject: [PATCH 0/2] exec: Use sane stack rlimit for setuid exec
Message-ID: <1499457420-83038-1-git-send-email-keescook@chromium.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

As discussed with Linus and Andy, we need to reset the stack rlimit
before we do memory layouts when execing a privilege-gaining (e.g.
setuid) program. This moves security_bprm_secureexec() earlier (with
required changes), and then lowers the stack limit when appropriate.

As a side-effect, dumpability is expanded to cover capabilities and
other LSM definitions of secureexec, and Smack can drop its special
handler for pdeath_signal clearing.

I'd appreciate some extra eyes on this to make sure this isn't
broken in some special way. I couldn't find anything that _depended_
on security_bprm_secureexec() being called late.

Thanks!

-Kees

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
