From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Mon, 27 Mar 2017 08:25:44 +0300
Subject: [tpmdd-devel] [PATCH v3 2/7] tpm: validate TPM 2.0 commands
In-Reply-To: <93c74fb96fe04433ac9c910204539d84@MUCSE603.infineon.com>
References: <20170303151912.14752-1-jarkko.sakkinen@linux.intel.com>
	<20170303151912.14752-3-jarkko.sakkinen@linux.intel.com>
	<22e8fa0caf8b4386a12cd93ee7170ed5@MUCSE603.infineon.com>
	<20170317204243.5j376svqeky6bhqk@intel.com>
	<93c74fb96fe04433ac9c910204539d84@MUCSE603.infineon.com>
Message-ID: <20170327052544.5enxnqvcwfut3hvf@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Mar 20, 2017 at 09:56:17AM +0000, Alexander.Steffen at infineon.com wrote:
> > I think the most straight-forward way to sort this out would be to limit
> > validation to the resource manager.
> 
> Sounds good to me.
> 
> > If I send a fix, would you care to test it?
> 
> Sure, will do.
> 
> Alexander

I sent the patch. Please check it out.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
