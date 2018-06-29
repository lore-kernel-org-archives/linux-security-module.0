From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Fri, 29 Jun 2018 12:09:53 -0600
Subject: [PATCH] tpm: require to compile as part of the kernel
In-Reply-To: <20180629174743.GC4060@linux.intel.com>
References: <20180629151005.10899-1-jarkko.sakkinen@linux.intel.com>
	<20180629153141.GE379@ziepe.ca>
	<20180629174743.GC4060@linux.intel.com>
Message-ID: <20180629180953.GG379@ziepe.ca>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Jun 29, 2018 at 08:47:43PM +0300, Jarkko Sakkinen wrote:
> On Fri, Jun 29, 2018 at 09:31:41AM -0600, Jason Gunthorpe wrote:
> > > -#if defined(CONFIG_TCG_TPM) || defined(CONFIG_TCG_TPM_MODULE)
> > > -
> > > +#if defined(CONFIG_TCG_TPM)
> > 
> > Huh. This new version is certainly right
> 
> Hmm...
> 
> If the option is kept as tristate, shouldn't this be actually:
> 
> #if defined(CONFIG_TCG_TPM) && !defined(CONFIG_TCG_TPM_MODULE)
> 
> ?

Er, yes, it should be writte as

#if IS_ENABLED(CONFIG_TCG_TPM)

these days

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
