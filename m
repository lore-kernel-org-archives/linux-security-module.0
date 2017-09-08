From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 8 Sep 2017 10:25:53 -0700
Subject: [GIT PULL] Security subsystem updates for 4.14
In-Reply-To: <20170908070943.GA26549@infradead.org>
References: <alpine.LRH.2.21.1709041959220.27950@namei.org>
	<CA+55aFw8wgA+jhBOhnY-TSdbPgiYcrFiipCV=rsS1=GQEN+JgQ@mail.gmail.com>
	<alpine.LRH.2.21.1709081448090.7880@namei.org>
	<20170908070943.GA26549@infradead.org>
Message-ID: <CA+55aFwMgUJSMQ96XdKnTbn8UsxzHTb8tZQdH40nxDeF7fWObw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Sep 8, 2017 at 12:09 AM, Christoph Hellwig <hch@infradead.org> wrote:
>
> But yes, for the init-time integrity_read_file this is incorrect.
> It never tripped up, and I explicitly added the lockdep annotations
> so that anything would show up, and it's been half a year since
> I sent that first RFC patch..

I don't think anybody actually tests linux-next kernels in any big
way, and the automated tests that do get run probably don't run with
any integrity checking enabled.

Which is why I actually look at the code when merging unexpected stuff.

This is also why I tend to prefer getting multiple branches for
independent things.

Now the whole security pull will be ignored because of this thing. I
refuse to pull garbage where I notice major fundamental problems in
code that has obviously never ever been tested.

Side note: one of the reasons why I _looked_ at this code was because
the exclusive lock requirement was entirely unexplained in the first
place.

            Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
