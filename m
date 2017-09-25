From: jmorris@namei.org (James Morris)
Date: Mon, 25 Sep 2017 14:59:23 +1000 (AEST)
Subject: Security updates for v4.15 and beyond
In-Reply-To: <5b63c120-5116-1e77-d090-331d2ae3aa8e@schaufler-ca.com>
References: <alpine.LRH.2.21.1709241454480.3941@namei.org>
	<5b63c120-5116-1e77-d090-331d2ae3aa8e@schaufler-ca.com>
Message-ID: <alpine.LRH.2.21.1709251450150.30951@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, 24 Sep 2017, Casey Schaufler wrote:

> On 9/23/2017 10:00 PM, James Morris wrote:
> > <snip>
> >
> > I plan on maintaining a separate branch for TPM (and other security 
> > subsystems) from now on.
> 
> Can you tell us how you expect this to work? I know
> there was discussion about this at the Security Summit.
> We need to get whatever needs doing lined up if we're
> going to make 4.15 happen smoothly.

I'll post a more detailed and general update in a few days when I'm back 
in Sydney, but briefly, send me a pull request against my next-general 
branch, which replaces the 'next' branch.  I'll sync that to -rc2 after 
this email.

I'll fetch your branch into my next-smack branch, which will track 
next-general.

All of these subsystem branches and next-general will be merged into 
next-testing, for use by Stephen Rothwell for linux-next, and any other 
general testing which may be done.

When the merge window opens, I'll merge the subsystem branches into 
next-for-linus for him to pull.  If all is going well, this will be the 
same as next-testing.  If there are problems in any of the branches, they 
can be left out of next-for-linus until they're resolved.

Linus can then pull from that to get everything at once, or pull individual 
branches as he sees fit.

In summary: track my next-general branch instead of 'next', and your 
workflow is otherwise unchanged.

How does that sound?


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
