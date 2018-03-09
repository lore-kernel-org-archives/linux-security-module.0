From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 9 Mar 2018 11:47:43 -0800
Subject: [PATCH v2] exec: Set file unwritable before LSM check
In-Reply-To: <20180309193020.GA5149@beast>
References: <20180309193020.GA5149@beast>
Message-ID: <CA+55aFyp4Lvz8QVckBr+zp4OfB1VaFNb2J1s0-xEMA9h44c0UA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Mar 9, 2018 at 11:30 AM, Kees Cook <keescook@chromium.org> wrote:
> The LSM check should happen after the file has been confirmed to be
> unchanging. Without this, we could have a race between the Time of Check
> (the call to security_kernel_read_file() which could read the file and
> make access policy decisions) and the Time of Use (starting with
> kernel_read_file()'s reading of the file contents). In theory, file
> contents could change between the two.

I'm going to assume I get this for 4.17 from the security tree.

Because I'm guessing there are actually no existing users that care?
selinux seems to just look at file state, not actually at contents or
anything that write access denial would care about.

And the only other security module that even registers this is
loadpin, and again it just seems to check things like "on the right
filesystem" that aren't actually impacted by write access (in fact,
the documented reason is to check that it's a read-only filesystem so
that write access is simply _irrelevant_).

So this issue seems to be mainly a cleanliness thing, not an actual bug.

             Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
