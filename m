From: jmorris@namei.org (James Morris)
Date: Mon, 28 Aug 2017 11:32:07 +1000 (AEST)
Subject: [PATCH V3 05/10] capabilities: use intuitive names for id changes
In-Reply-To: <20170825200646.GA27821@mail.hallyn.com>
References: <cover.1503459890.git.rgb@redhat.com>
	<1360ed3437f87ac0b9e076ff5ea05c67ee8a7ed8.1503459890.git.rgb@redhat.com>
	<CALCETrVf4Vc8A+sFk6cFqfovmNOrgin3BEvsTEP8aBmiavhRnQ@mail.gmail.com>
	<20170825185127.GB26620@mail.hallyn.com>
	<9465A086-A2C8-41E6-994E-34C7B1B9F0F9@amacapital.net>
	<20170825200646.GA27821@mail.hallyn.com>
Message-ID: <alpine.LRH.2.20.1708281130270.3474@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 25 Aug 2017, Serge E. Hallyn wrote:

> Part of the motivation here is that the things we are checking for are some
> rather baroque combinations of conditions, so having each piece of those be
> as simple and clear as possible helps to better reason about what is going on
> (which helped Richard to find the bug he is fixing).
> 
> These helpers are local (should all be static, as James pointed out).  Making
> helpers to simplify the final checks is the right way to clarify code.  I'm
> all for making sure they are as clear as possible, but I do think their existence
> is justified.

Perhaps document them better and maybe prefix them with __ to emphasize 
that they're internal only?

-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
