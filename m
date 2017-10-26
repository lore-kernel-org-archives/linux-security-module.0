From: msuchanek@suse.de (Michal =?UTF-8?B?U3VjaMOhbmVr?=)
Date: Thu, 26 Oct 2017 14:59:02 +0200
Subject: Fixing CVE-2017-15361
In-Reply-To: <20171026111632.g6a3bkhe4nxorfbm@linux.intel.com>
References: <20171025134438.vgh6tzkups2tujps@linux.intel.com>
	<CACdnJus6=3XJEVsQEVY-sxqcUm2At4fKi5Ya+w0Hf==yq7ubKQ@mail.gmail.com>
	<20171025185349.ocptudim3g35j6im@linux.intel.com>
	<F1DA2BF7-4A3D-4934-9C45-4DAC4FD33659@gmx.de>
	<20171026111632.g6a3bkhe4nxorfbm@linux.intel.com>
Message-ID: <20171026145902.2e7dbb06@kitsune.suse.cz>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 26 Oct 2017 13:16:32 +0200
Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:

> On Thu, Oct 26, 2017 at 12:26:10AM +0200, Peter Huewe wrote:
> > 
> > 
> > Am 25. Oktober 2017 20:53:49 MESZ schrieb Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com>:  
> > >On Wed, Oct 25, 2017 at 07:17:17AM -0700, Matthew Garrett wrote:  
> > >> On Wed, Oct 25, 2017 at 6:44 AM, Jarkko Sakkinen
> > >> <jarkko.sakkinen@linux.intel.com> wrote:  

> > >I proposed the following as an alternative:
> > >
> > >* Print a message to the klog (which log level would be
> > >appropriate?).  
> > Info?
> > Maybe warn, definitely not err  
> 
> Since the driver does not fail usually warn would make sense but since
> here even allowing to continue to use such TPM is questionable I would
> use error here.

It does not really matter. People ignore the messages unless looking
for something specific as you already noticed. Warn seems adequate
because the cipher is weaker than expected but not known to
be compromised. People who care can look up the message. People who
don't care will ignore it even if it's crit.

> 
> People anyway ignore klog too easily so using warn would be a mistake
> in my opinion. It's like saying that nothing serious is happening
> here, move along.
> 
> Do you think so?
> 
> > >* Possibly sleep for few seconds. Is this a good idea?  
> > Helps how?  
> 
> Obviously to get it noticed that the system integrity is broken.

Overly intrusive. The message is not visible with splashscreens anyway.

Presumably other stuff can run in parallel these days spamming with
unrelated messages.

> 
> > >While writing this email yet another alternative popped into my
> > >mind: what if we allow only in-kernel use but disallow the use
> > >of /dev/tpm0? You could still use trusted keys.
> > >  
> > No, same terrible idea since you block the upgrade path.
> > Upgrade tools work from userspace via the kernel driver. 
> > So /dev/tpm0 is necessary.  
> 
> Right! How stupid of me (my previous response to Jerry) :-) Of course
> you can have special commands and talk to the TPM to do the upgrade
> even if it is part of the platform and not connected to a standard
> bus.

Unless the upgrade command is disabled to not disrupt the platform, of
course.

Thanks

Michal
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
