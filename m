From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 7 Jul 2017 13:09:49 -0700
Subject: [PATCH 0/2] exec: Use sane stack rlimit for setuid exec
In-Reply-To: <CA+55aFx21616pqhGA_-g-GzYCQNN8Jn2DRm=3+_W1GuBdmb1gA@mail.gmail.com>
References: <1499457420-83038-1-git-send-email-keescook@chromium.org>
	<CA+55aFx21616pqhGA_-g-GzYCQNN8Jn2DRm=3+_W1GuBdmb1gA@mail.gmail.com>
Message-ID: <CA+55aFwojBf67Wg6m6D-KoGXiS5ePygAK1QzuKKihhPG=3MGUA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Jul 7, 2017 at 1:04 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It looks like Kees went through the security modules [..]

i take that back. It looks like Kees looked at smack, but not at
SElinux, for example.

selinux_bprm_secureexec() seems to just look at current_security(),
not at the new stuff in bprm at all.

Which would seem to be exactly the wrong thing to do, and is insane
(why pass in bprm at all?) but comes from the fact that we used to
call bprm_secureexec() in an insane place.

So I think this patch series is sadly broken - I think it does the
right thing, but the security modules definitely look like they need
to be updated for that right thing.

                    Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
