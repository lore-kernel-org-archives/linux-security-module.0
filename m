From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Thu, 26 Oct 2017 21:07:28 +0200
Subject: Fixing CVE-2017-15361
In-Reply-To: <6d23d2e2efbb4b7ba11c7d430d7c816e@infineon.com>
References: <20171025134438.vgh6tzkups2tujps@linux.intel.com>
	<CACdnJus6=3XJEVsQEVY-sxqcUm2At4fKi5Ya+w0Hf==yq7ubKQ@mail.gmail.com>
	<20171025185349.ocptudim3g35j6im@linux.intel.com>
	<6d23d2e2efbb4b7ba11c7d430d7c816e@infineon.com>
Message-ID: <20171026190728.mxqvrglutxuqnnua@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Oct 26, 2017 at 03:51:27PM +0000, Alexander.Steffen at infineon.com wrote:
> > > On Wed, Oct 25, 2017 at 07:17:17AM -0700, Matthew Garrett wrote:
> > > > On Wed, Oct 25, 2017 at 6:44 AM, Jarkko Sakkinen
> > > > <jarkko.sakkinen@linux.intel.com> wrote:
> > > > > I'm implementing a fix for CVE-2017-15361 that simply blacklists
> > > > > vulnerable FW versions. I think this is the only responsible action from
> > > > > my side that I can do.
> > > >
> > > > I'm not sure this is ideal - do Infineon have any Linux tooling for
> > > > performing firmware updates, and if so will that continue working if
> > > > the device is blacklisted? It's also a poor user experience to have
> > > > systems using TPM-backed disk encryption keys suddenly rendered
> > > > unbootable, and making it as easy as possible for people to do an
> > > > upgrade and then re-seal secrets with new keys feels like the correct
> > > > approach.
> > >
> > > I talked today with Alexander Steffen in the KS unconference and we
> > > concluded that this would be a terrible idea.
> > 
> > Right. Thinking more about this issue, I'd say the ideal way to handle it would
> > be in the applications using the TPM. Not all functionalities of the TPM are
> > affected, so only the applications can know whether their use cases are still
> > safe and it are the applications that need to migrate to a safe solution should
> > this be necessary. (Of course, this puts the burden on each individual
> > application instead of having one central place to decide what is safe and
> > what isn't, but I do not see any way around that.)
> > 
> > As far as I know, the kernel itself is not using any of the affected
> > functionalities, so there is no need for an immediate mitigation within the
> > kernel.
> 
> This does not seem to be entirely true. The code in
> security/keys/trusted.c might be affected under some circumstances,
> but I am not familiar enough with that code to say for sure. As far as
> I can tell, it does not create any RSA keys directly, but it might
> reference them as parent keys, so that vulnerable keys are used to
> protect the secrets. 
> 
> If that is the case, can we detect that issue and migrate the secrets
> to a safe configuration? Do we (as the kernel) want to do that? How
> much do we want/have to involve the user in the process?

I've implemented the TPM 2.0 trusted keys code and some parts have faded
away bit (I still run tests with that code for every kernel release) but
AFAIK you can give a non-primary key as parent.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
