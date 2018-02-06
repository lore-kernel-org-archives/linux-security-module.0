From: tomas.winkler@intel.com (Winkler, Tomas)
Date: Tue, 6 Feb 2018 20:51:48 +0000
Subject: [PATCH v2] tpm: add longer timeouts for creation commands.
In-Reply-To: <20180206200650.ozcwsv3uks6eyah3@linux.intel.com>
References: <20180128081739.8066-1-tomas.winkler@intel.com>
	<20180206200650.ozcwsv3uks6eyah3@linux.intel.com>
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9421881D@hasmsx108.ger.corp.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> 
> On Sun, Jan 28, 2018 at 10:17:39AM +0200, Tomas Winkler wrote:
> > TPM2_CC_Create(0x153) and TPM2_CC_CreatePrimary (0x131) involve
> > generation of crypto keys which can be a computationally intensive task.
> > The timeout is set to 3min.
> >
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> 
> This is still NAK because we need some kind of reference for the new value.
> Is that also right value for ARM64/TrustZone based TPMs?

The SPEC itself, doesn't define the timeout,  except for specific commands, 
also the current 'undefined' number is born in air, I wonder if you  can provide the reference as well.
If I would suggest to shorten the number that would maybe a problem for other implementation, 
but I don't see how the increase in timeout is adverse another implementations.
Key generation is computational intensive task because of generation of a prime number, so this is really 
dependent on device capabilities, so there is no better source of definition that HW itself.

Thanks
Tomas

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
