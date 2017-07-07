From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 7 Jul 2017 13:04:20 -0700
Subject: [PATCH 0/2] exec: Use sane stack rlimit for setuid exec
In-Reply-To: <1499457420-83038-1-git-send-email-keescook@chromium.org>
References: <1499457420-83038-1-git-send-email-keescook@chromium.org>
Message-ID: <CA+55aFx21616pqhGA_-g-GzYCQNN8Jn2DRm=3+_W1GuBdmb1gA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Jul 7, 2017 at 12:56 PM, Kees Cook <keescook@chromium.org> wrote:
> As discussed with Linus and Andy, we need to reset the stack rlimit
> before we do memory layouts when execing a privilege-gaining (e.g.
> setuid) program. This moves security_bprm_secureexec() earlier (with
> required changes), and then lowers the stack limit when appropriate.

Looks sane to me, and that first patch looks like a nice cleanup
regardless - the old semantics were insane.

But yes, we should have more people look at this, particular have the
security module people look at that first patch to make sure it is the
right thing to do for their policies, and make sure that everybody's
bprm_secureexec() function actually looks at the creds in the brmp,
not "current" (well, maybe they compare the two, which makes tons of
sense, and which the old  placement didn't sanely support).

It looks like Kees went through the security modules, but having the
people involved double-check is a good good idea.

                 Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
