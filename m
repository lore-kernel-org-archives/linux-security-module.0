From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 18 Jul 2017 16:03:08 -0700 (PDT)
Subject: [PATCH v3 00/15] exec: Use sane stack rlimit under secureexec
In-Reply-To: <1500416736-49829-1-git-send-email-keescook@chromium.org>
References: <1500416736-49829-1-git-send-email-keescook@chromium.org>
Message-ID: <alpine.LFD.2.20.1707181601010.14906@i7>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



On Tue, 18 Jul 2017, Kees Cook wrote:
>
> This series has grown... :P

Hmm. It may be bigger, but I like it a lot better. Each step now looks 
fairly obvious and is well documented. 

I don't love the timing of it, but I think I'd be willing to just pull 
this in before rc2 as a "we need to do this sooner or later anyway and 
probably mark much of it for stable" kind of thing.

But it would be really good to get people to look at the series, 
particularly Andy and the LSM folks..

              Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
