From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Thu, 26 Oct 2017 12:54:30 +0200
Subject: [PATCH v2] tpm: use struct tpm_chip for tpm_chip_find_get()
In-Reply-To: <20171025201744.GB2815@obsidianresearch.com>
References: <20171025115508.5682-1-jarkko.sakkinen@linux.intel.com>
	<CANc+2y46q85+G1=9cXKW0R8FpGBqCuzkLnJzvSYFQ1S=ztKGew@mail.gmail.com>
	<20171025193452.d4qa4dhacfgqejk7@linux.intel.com>
	<20171025194633.GB998@obsidianresearch.com>
	<20171025200746.svsraubdotjyzt2i@linux.intel.com>
	<20171025201744.GB2815@obsidianresearch.com>
Message-ID: <20171026105430.t6khk6cekk3cyfrs@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Oct 25, 2017 at 02:17:44PM -0600, Jason Gunthorpe wrote:
> On Wed, Oct 25, 2017 at 10:07:46PM +0200, Jarkko Sakkinen wrote:
> 
> > The id has a nice feature that it is unique for one boot cycle you can
> > even try to get a chip that has been deleted. It has the most stable
> > properties in the long run.
> 
> It isn't unique, we can re-use ids them via idr_alloc(). We should
> never use index inside the kernel.
> 
> > Address is a reusable identifier in one boot cycle.
> 
> It is invalid to pass in a chip for which the caller does not hold a
> kref, so address is the safest argument.
> 
> Jason

I'll buy this too (sending update today).

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
