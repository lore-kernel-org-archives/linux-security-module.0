From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 7 Jul 2017 15:39:59 -0700
Subject: [PATCH 0/2] exec: Use sane stack rlimit for setuid exec
In-Reply-To: <CAGXu5jL0rAqsjS73Fh+_NoGntr2OVrz6OoJCQxQmq24pswXPRQ@mail.gmail.com>
References: <1499457420-83038-1-git-send-email-keescook@chromium.org>
	<CA+55aFx21616pqhGA_-g-GzYCQNN8Jn2DRm=3+_W1GuBdmb1gA@mail.gmail.com>
	<CAGXu5jL0rAqsjS73Fh+_NoGntr2OVrz6OoJCQxQmq24pswXPRQ@mail.gmail.com>
Message-ID: <CA+55aFxqf3=AarWLjzZ4dUZX00qLenUdWQxKAd_ceLvT2y=N5w@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Jul 7, 2017 at 3:13 PM, Kees Cook <keescook@chromium.org> wrote:
>
> I wonder if we could collapse all the secureexec logic in
> setup_new_exec.

Probably.

Some of our insane calls back-and-forth between different layers are
due to people abstracting things out and trying very hard to keep old
(and bad) orderings without trying to really determine if they are the
right thing to do.

We *have* occasionally collapsed things when it became obvious just
how crazy things were, but not very often.

There's another thing that I _think_ should be cleaned up:

     install_exec_creds(bprm);

should also be moved into setup_new_exec().

It used to be at a different point in the load sequence, but we fixed
all that up in the ELF loader, but we kept it in the *callers* because
some of the old loaders have different sequences.

But it's quite likely that all the other loaders should be fixed to do
what ELF does. I think they currently have the odd old semantics that
they may load the binary using the old permissions, so a suid binary
needs to be readable by non-root users (which is just stupid).

But it's nasty nasty work to go through and check what subtle things
might change.

Which is why nobody ever does it ;(

                  Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
