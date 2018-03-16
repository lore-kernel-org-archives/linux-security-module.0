From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Fri, 16 Mar 2018 16:08:50 +0200
Subject: [PATCH v2 7/8] tpm: Move pcr extend to tpm2-cmd.c
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B94237DEE@hasmsx108.ger.corp.intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
	<20180310082428.31519-8-tomas.winkler@intel.com>
	<62dcb95fa349f0b195afd3c28c9fa9aeac60fe98.camel@linux.intel.com>
	<5B8DA87D05A7694D9FA63FD143655C1B94237DEE@hasmsx108.ger.corp.intel.com>
Message-ID: <20180316140850.GC9616@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Mar 15, 2018 at 11:28:55PM +0000, Winkler, Tomas wrote:
> > 
> > On Sat, 2018-03-10 at 10:24 +0200, Tomas Winkler wrote:
> > > Add tpm2_pcr_extend function to tpm2-cmd.c with signature required by
> > > tpm-interface.c. It wraps the original open code implementation. The
> > > original original tpm2_pcr_extend function is renamed and made static,
> > > called only from new tpm2_pcr_extend.
> > >
> > > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > 
> > This might concern some of the earlier patches too but please use exact
> > names for functions in the short and long summary i.e.
> > 
> >   tpm: migrate all of the PCR extension code to tpm2_pcr_extend()
> > 
> > Check this also for your long descriptions and previous that I gave reviewed-
> > by (I think they were otherwise fine). And you refer to a function in text use
> > parentheses after the name. I don't like hastily written commit messages.
> 
> 
> Yeah,  got little tired of describing the obvious. but you are right.
> Tomas

Might sound nit picking but a solid git log is useful tool.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
