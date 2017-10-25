From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 25 Oct 2017 20:58:17 +0200
Subject: [PATCH] tpm: Move Linux RNG connection to hwrng
In-Reply-To: <CANc+2y5q78g1Ow1JQ7kO0SkPrgNtbRV=COkB4YLHbSraTQH7aQ@mail.gmail.com>
References: <20171024184235.GC1806@obsidianresearch.com>
	<CANc+2y5q78g1Ow1JQ7kO0SkPrgNtbRV=COkB4YLHbSraTQH7aQ@mail.gmail.com>
Message-ID: <20171025185817.hoalqzud3646yuy7@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Oct 25, 2017 at 08:15:09PM +0530, PrasannaKumar Muralidharan wrote:
> > +       if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM))
> > +               return 0;
> 
> Can #ifndef CONFIG_HW_RANDOM_TPM be used instead? That way an if
> condition can be avoided.

Nope. There is no reason to avoid the if-condition. Compiler will take
care of it. IS_ENABLED() macro is available just for the purpose Jason
is using it.

> > +       char tpm_hwrng_name[64];
> > +       struct hwrng tpm_hwrng;
> > +
> 
> Can this also be put inside the #ifdef?

Yes. It should be inside #ifdef.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
