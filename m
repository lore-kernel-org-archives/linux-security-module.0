From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 25 Oct 2017 09:18:59 -0600
Subject: [PATCH] tpm: Move Linux RNG connection to hwrng
In-Reply-To: <CANc+2y5q78g1Ow1JQ7kO0SkPrgNtbRV=COkB4YLHbSraTQH7aQ@mail.gmail.com>
References: <20171024184235.GC1806@obsidianresearch.com>
	<CANc+2y5q78g1Ow1JQ7kO0SkPrgNtbRV=COkB4YLHbSraTQH7aQ@mail.gmail.com>
Message-ID: <20171025151859.GB15557@obsidianresearch.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Oct 25, 2017 at 08:15:09PM +0530, PrasannaKumar Muralidharan
wrote:

> > +static int tpm_add_hwrng(struct tpm_chip *chip)
> > +{
> > +       if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM))
> > +               return 0;
> 
> Can #ifndef CONFIG_HW_RANDOM_TPM be used instead? That way an if
> condition can be avoided.

Generally speaking IS_ENABLED is prefered over #ifdef as it reduces the
set of compilation combinations.

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
