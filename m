From: james.l.morris@oracle.com (James Morris)
Date: Thu, 7 Dec 2017 11:10:12 +1100 (AEDT)
Subject: [PATCH] security: Export few symbols referred by other modules
In-Reply-To: <20171206153231.GC29623@kroah.com>
References: <1512471537-23865-1-git-send-email-hareeshg@codeaurora.org>
	<alpine.LFD.2.20.1712052259390.14735@localhost>
	<201712052221.HDJ00044.tOOHVMFQFOJLSF@I-love.SAKURA.ne.jp>
	<0322ddc2-f1a2-93f5-d34d-d57f6be734a3@codeaurora.org>
	<20171206153231.GC29623@kroah.com>
Message-ID: <alpine.LFD.2.20.1712071100540.8348@localhost>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 6 Dec 2017, Greg KH wrote:

> On Wed, Dec 06, 2017 at 08:45:01PM +0530, Hareesh Gundu wrote:
> > On 12/5/2017 6:51 PM, Tetsuo Handa wrote:
> > > James Morris wrote:
> > > > On Tue, 5 Dec 2017, Hareesh Gundu wrote:
> > > > 
> > > > > Export mmap_min_addr and security_mmap_addr() to allow
> > > > > kernel modules to use them.
> > > > > 
> > > > > Signed-off-by: Hareesh Gundu <hareeshg@codeaurora.org>
> > Can other folks comment whether this should be EXPORT_SYMBOL or
> > EXPORT_SYMBOL_GPL ?
> 
> What do you think?

The API has some EXPORT_SYMBOLs already and it's probably not useful to 
add any EXPORT_SYMBOL_GPLs on a technical level, as you can't use the API 
with just those.

In terms of documenting developer intent, it may make a difference.

So, what I would propose is that for new hooks which are exported, the 
author can specify which type of export.  In the case of hooks which were 
added after EXPORT_SYMBOL_GPL was merged, and which are only now being 
exported, ask the original author of the hook to decide, otherwise default 
to EXPORT_SYMBOL, which is consistent with the most of the existing API.

For pre-EXPORT_SYMBOL_GPL hooks, if they need to be exported, continue to 
do so as EXPORT_SYMBOL.

And obviously all of the above is contingent on having in-tree users of 
exported hooks.




- James
-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
