From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 25 Oct 2017 13:37:07 -0600
Subject: [PATCH] tpm: Move Linux RNG connection to hwrng
In-Reply-To: <20171025185817.hoalqzud3646yuy7@linux.intel.com>
References: <20171024184235.GC1806@obsidianresearch.com>
	<CANc+2y5q78g1Ow1JQ7kO0SkPrgNtbRV=COkB4YLHbSraTQH7aQ@mail.gmail.com>
	<20171025185817.hoalqzud3646yuy7@linux.intel.com>
Message-ID: <20171025193707.GA998@obsidianresearch.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Oct 25, 2017 at 08:58:17PM +0200, Jarkko Sakkinen wrote:
> On Wed, Oct 25, 2017 at 08:15:09PM +0530, PrasannaKumar Muralidharan wrote:
> > > +       if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM))
> > > +               return 0;
> > 
> > Can #ifndef CONFIG_HW_RANDOM_TPM be used instead? That way an if
> > condition can be avoided.
> 
> Nope. There is no reason to avoid the if-condition. Compiler will take
> care of it. IS_ENABLED() macro is available just for the purpose Jason
> is using it.
> 
> > > +       char tpm_hwrng_name[64];
> > > +       struct hwrng tpm_hwrng;
> > > +
> > 
> > Can this also be put inside the #ifdef?
> 
> Yes. It should be inside #ifdef.

Then we need #idefs in the .c code, IS_ENABLED is not enough :\ I
don't think the few bytes matters enough to bother.

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
