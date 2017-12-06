From: gregkh@linuxfoundation.org (Greg KH)
Date: Wed, 6 Dec 2017 16:32:31 +0100
Subject: [PATCH] security: Export few symbols referred by other modules
In-Reply-To: <0322ddc2-f1a2-93f5-d34d-d57f6be734a3@codeaurora.org>
References: <1512471537-23865-1-git-send-email-hareeshg@codeaurora.org>
	<alpine.LFD.2.20.1712052259390.14735@localhost>
	<201712052221.HDJ00044.tOOHVMFQFOJLSF@I-love.SAKURA.ne.jp>
	<0322ddc2-f1a2-93f5-d34d-d57f6be734a3@codeaurora.org>
Message-ID: <20171206153231.GC29623@kroah.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Dec 06, 2017 at 08:45:01PM +0530, Hareesh Gundu wrote:
> On 12/5/2017 6:51 PM, Tetsuo Handa wrote:
> > James Morris wrote:
> > > On Tue, 5 Dec 2017, Hareesh Gundu wrote:
> > > 
> > > > Export mmap_min_addr and security_mmap_addr() to allow
> > > > kernel modules to use them.
> > > > 
> > > > Signed-off-by: Hareesh Gundu <hareeshg@codeaurora.org>
> Can other folks comment whether this should be EXPORT_SYMBOL or
> EXPORT_SYMBOL_GPL ?

What do you think?

> > > I'm not sure whether this should be EXPORT_SYMBOL or EXPORT_SYMBOL_GPL, as
> > > this hook was added in 2009, well after EXPORT_SYMBOL_GPL came into being.
> > > 
> > > Most of the LSM hooks are marked EXPORT_SYMBOL because they were part of
> > > an existing interface when EXPORT_SYMBOL_GPL was introduced, IIRC.
> > > 
> > > What do folks think?
> > > 
> ?That's right, This change is for outside kernel tree modules.

Then it should not be exported at all, sorry.

Please work to get your code merged into the kernel tree and then it can
be exported properly for it.  Odds are, you don't really need these
symbols, as {hint}, no one else does...

sorry,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
