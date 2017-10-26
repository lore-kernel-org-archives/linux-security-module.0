From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Thu, 26 Oct 2017 16:06:02 +0200
Subject: Fixing CVE-2017-15361
In-Reply-To: <20171026145902.2e7dbb06@kitsune.suse.cz>
References: <20171025134438.vgh6tzkups2tujps@linux.intel.com>
	<CACdnJus6=3XJEVsQEVY-sxqcUm2At4fKi5Ya+w0Hf==yq7ubKQ@mail.gmail.com>
	<20171025185349.ocptudim3g35j6im@linux.intel.com>
	<F1DA2BF7-4A3D-4934-9C45-4DAC4FD33659@gmx.de>
	<20171026111632.g6a3bkhe4nxorfbm@linux.intel.com>
	<20171026145902.2e7dbb06@kitsune.suse.cz>
Message-ID: <20171026140602.syifqbrgysvq7ciy@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Oct 26, 2017 at 02:59:02PM +0200, Michal Such?nek wrote:
> It does not really matter. People ignore the messages unless looking
> for something specific as you already noticed. Warn seems adequate
> because the cipher is weaker than expected but not known to
> be compromised. People who care can look up the message. People who
> don't care will ignore it even if it's crit.

Is it worth of trouble to do any driver changes then (open question to
everyone)? I'm not sure it is worth of trouble to add cruft to the
driver code for a warning that will likely be ignored anyway.

> > you can have special commands and talk to the TPM to do the upgrade
> > even if it is part of the platform and not connected to a standard
> > bus.
> 
> Unless the upgrade command is disabled to not disrupt the platform, of
> course.

Sure. This misconception partly came from live discussions at Prague. Of
course it you can have vendor specific commands to achieve this.

Maybe the original statement came from the fact that on most consumer
devices this is disabled?

> Thanks
> 
> Michal

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
