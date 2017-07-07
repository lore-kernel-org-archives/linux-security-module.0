From: keescook@chromium.org (Kees Cook)
Date: Fri, 7 Jul 2017 15:10:58 -0700
Subject: [PATCH 0/2] exec: Use sane stack rlimit for setuid exec
In-Reply-To: <CA+55aFwojBf67Wg6m6D-KoGXiS5ePygAK1QzuKKihhPG=3MGUA@mail.gmail.com>
References: <1499457420-83038-1-git-send-email-keescook@chromium.org>
	<CA+55aFx21616pqhGA_-g-GzYCQNN8Jn2DRm=3+_W1GuBdmb1gA@mail.gmail.com>
	<CA+55aFwojBf67Wg6m6D-KoGXiS5ePygAK1QzuKKihhPG=3MGUA@mail.gmail.com>
Message-ID: <CAGXu5jLKXhBmR-fCLbodgukfFd6CwX5BGJj58hTzxAsbdRSQaA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Jul 7, 2017 at 1:09 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Jul 7, 2017 at 1:04 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> It looks like Kees went through the security modules [..]
>
> i take that back. It looks like Kees looked at smack, but not at
> SElinux, for example.

Well, I looked at the all but misthought about SELinux.

> selinux_bprm_secureexec() seems to just look at current_security(),
> not at the new stuff in bprm at all.

I was looking for cred. Yeah, I'll see what should happen here...

> Which would seem to be exactly the wrong thing to do, and is insane
> (why pass in bprm at all?) but comes from the fact that we used to
> call bprm_secureexec() in an insane place.
>
> So I think this patch series is sadly broken - I think it does the
> right thing, but the security modules definitely look like they need
> to be updated for that right thing.

Yeah, I'll rev this once SELinux is more clear...

-Kees

-- 
Kees Cook
Pixel Security
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
