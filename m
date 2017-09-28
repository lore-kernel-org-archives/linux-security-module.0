From: jmorris@namei.org (James Morris)
Date: Fri, 29 Sep 2017 08:53:28 +1000 (AEST)
Subject: [GIT PULL] security: keys fixes for v4.14-rc3
In-Reply-To: <CAHmME9oRwa+Oi=wa0MT3vRagZL6FTTzxwvE3NBO13_yxg4Kznw@mail.gmail.com>
References: <alpine.LRH.2.21.1709290822590.15742@namei.org>
	<CAHmME9oRwa+Oi=wa0MT3vRagZL6FTTzxwvE3NBO13_yxg4Kznw@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1709290852340.19449@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 29 Sep 2017, Jason A. Donenfeld wrote:

> On Fri, Sep 29, 2017 at 12:33 AM, James Morris <jmorris@namei.org> wrote:
> > Generally speaking, we likely need to improve the amount of crypto review
> > for kernel crypto users including keys (I'll post a note separately to
> > ksummit-discuss).
> 
> Indeed.
> 
> I won't be at kernel summit, regrettably, but I do intend to
> methodically work through the kernel reviewing the various crypto
> [mis]uses in places. I also have some larger plans regarding reworking
> a few aspects of the crypto API, that I'll start a discussion with
> Herbert about during the next several months. (I'm CCing Andy because
> this is something the two of us have also discussed.)
> 
> So, expect some more things like this patch to gradually be rolling
> your way, along with maybe larger overall changes. If you wind up
> discussing this in any substantial way at the summit this year, please
> do try to loop me in at some point.

Absolutely.  This is important work and great to hear!

-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
