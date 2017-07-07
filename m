From: keescook@chromium.org (Kees Cook)
Date: Fri, 7 Jul 2017 15:13:35 -0700
Subject: [PATCH 0/2] exec: Use sane stack rlimit for setuid exec
In-Reply-To: <CA+55aFx21616pqhGA_-g-GzYCQNN8Jn2DRm=3+_W1GuBdmb1gA@mail.gmail.com>
References: <1499457420-83038-1-git-send-email-keescook@chromium.org>
	<CA+55aFx21616pqhGA_-g-GzYCQNN8Jn2DRm=3+_W1GuBdmb1gA@mail.gmail.com>
Message-ID: <CAGXu5jL0rAqsjS73Fh+_NoGntr2OVrz6OoJCQxQmq24pswXPRQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Jul 7, 2017 at 1:04 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Jul 7, 2017 at 12:56 PM, Kees Cook <keescook@chromium.org> wrote:
>> As discussed with Linus and Andy, we need to reset the stack rlimit
>> before we do memory layouts when execing a privilege-gaining (e.g.
>> setuid) program. This moves security_bprm_secureexec() earlier (with
>> required changes), and then lowers the stack limit when appropriate.
>
> Looks sane to me, and that first patch looks like a nice cleanup
> regardless - the old semantics were insane.

I wonder if we could collapse all the secureexec logic in
setup_new_exec. There are three places (?). I was shy to consolidate
those in this patch in case there were weird dependencies on
dumpability ordering. But I'll go see if I can clean those up too...

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
