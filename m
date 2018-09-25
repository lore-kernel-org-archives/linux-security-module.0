From: jmorris@namei.org (James Morris)
Date: Wed, 26 Sep 2018 04:07:39 +1000 (AEST)
Subject: [GIT PULL] Keys: fix C++ reserved word issue
In-Reply-To: <20180925113026.GA1696@kroah.com>
References: <20180925094147.GC21972@kroah.com>
	<alpine.LRH.2.21.1809250738020.27047@namei.org>
	<31929.1537870620@warthog.procyon.org.uk>
	<20180925113026.GA1696@kroah.com>
Message-ID: <alpine.LRH.2.21.1809260407160.29804@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 25 Sep 2018, Greg KH wrote:

> On Tue, Sep 25, 2018 at 11:17:00AM +0100, David Howells wrote:
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > > I'll wait a few days on this one...
> > 
> > Can you at least apply the reversion patch?  UAPI is currently broken by the
> > change that needs reverting.
> 
> Yes, as that's obviously correct.  I think you should wait for your
> patch 2 here until 4.20-rc1, as this isn't a "fix" that is required at
> this point in time.

Ok, I'll queue this for the merge window.


-- 
James Morris
<jmorris@namei.org>
