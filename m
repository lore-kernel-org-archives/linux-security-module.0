From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Thu, 26 Oct 2017 19:03:59 +0200
Subject: Fixing CVE-2017-15361
In-Reply-To: <20171026170237.6q43xsenbzrw6hi4@linux.intel.com>
References: <20171025134438.vgh6tzkups2tujps@linux.intel.com>
	<CACdnJus6=3XJEVsQEVY-sxqcUm2At4fKi5Ya+w0Hf==yq7ubKQ@mail.gmail.com>
	<20171025185349.ocptudim3g35j6im@linux.intel.com>
	<F1DA2BF7-4A3D-4934-9C45-4DAC4FD33659@gmx.de>
	<20171026111632.g6a3bkhe4nxorfbm@linux.intel.com>
	<20171026145902.2e7dbb06@kitsune.suse.cz>
	<20171026140602.syifqbrgysvq7ciy@linux.intel.com>
	<20171026165748.265e6dcf@kitsune.suse.cz>
	<20171026170237.6q43xsenbzrw6hi4@linux.intel.com>
Message-ID: <20171026170359.v3f7od6hagrt2pv7@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Oct 26, 2017 at 07:02:37PM +0200, Jarkko Sakkinen wrote:
> On Thu, Oct 26, 2017 at 04:57:48PM +0200, Michal Such?nek wrote:
> > On Thu, 26 Oct 2017 16:06:02 +0200
> > Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:
> > 
> > > On Thu, Oct 26, 2017 at 02:59:02PM +0200, Michal Such?nek wrote:
> > > > It does not really matter. People ignore the messages unless looking
> > > > for something specific as you already noticed. Warn seems adequate
> > > > because the cipher is weaker than expected but not known to
> > > > be compromised. People who care can look up the message. People who
> > > > don't care will ignore it even if it's crit.  
> > > 
> > > Is it worth of trouble to do any driver changes then (open question to
> > > everyone)? I'm not sure it is worth of trouble to add cruft to the
> > > driver code for a warning that will likely be ignored anyway.
> > 
> > If the kernel can reliably detect the affected TPMs it saves the
> > user the work of figuring out where the firmware revision is accessible
> > on the running machine and what firmware revisions are affected.
> > 
> > Thanks
> > 
> > Michal
> 
> Just giving the warning does not require any kernel functionality. If
> nothing proactive is required from the kernel I'd move the
> responsibility to the user space. Nothing in the kernel is broken an
> kernel cannot workaround the issue by ay means.
> 
> /Jarkko

I.e. I'm not going to fix a bug if there is no bug to fix.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
