From: luto@kernel.org (Andy Lutomirski)
Date: Fri, 7 Jul 2017 14:55:53 -0700
Subject: [PATCH 0/2] exec: Use sane stack rlimit for setuid exec
In-Reply-To: <1499457420-83038-1-git-send-email-keescook@chromium.org>
References: <1499457420-83038-1-git-send-email-keescook@chromium.org>
Message-ID: <CALCETrVdV5HKxRf8+pJgP0bKRgA_YeJYpwtGUFRomSNTHWJ5YA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Jul 7, 2017 at 12:56 PM, Kees Cook <keescook@chromium.org> wrote:
> As discussed with Linus and Andy, we need to reset the stack rlimit
> before we do memory layouts when execing a privilege-gaining (e.g.
> setuid) program. This moves security_bprm_secureexec() earlier (with
> required changes), and then lowers the stack limit when appropriate.

As I see it, there are two cases to harden:

1. Bad guy has a high rlimit and runs a setuid program with crazy
large arguments.  This is improved by this patch.  It's not entirely
clear to me exactly what problem is solved, though, except that the
rest of the exec code does not sanely check that we haven't used too
much stack.  How about putting a check later on to make sure that
we're not running low on stack rather than hoping we got the
arithmetic right?

2. Bad guy wants to trigger stack exhaustion in a setuid program at a
controlled location and thus sets a crazy low rlimit.  This isn't
addressed at all by this patch, but I assume it's what grsecurity was
trying to do.  FWIW, I seem to recall that a lot of setuid attacks use
intentionally weird rlimits to trigger unexpected signals.

--Andy
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
