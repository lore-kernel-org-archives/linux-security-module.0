From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 25 Oct 2017 14:04:42 -0600
Subject: [PATCH] tpm: Move Linux RNG connection to hwrng
In-Reply-To: <20171025200030.ikygzc3lxnwex7sg@linux.intel.com>
References: <20171024184235.GC1806@obsidianresearch.com>
	<CANc+2y5q78g1Ow1JQ7kO0SkPrgNtbRV=COkB4YLHbSraTQH7aQ@mail.gmail.com>
	<20171025185817.hoalqzud3646yuy7@linux.intel.com>
	<20171025193707.GA998@obsidianresearch.com>
	<20171025200030.ikygzc3lxnwex7sg@linux.intel.com>
Message-ID: <20171025200442.GA2815@obsidianresearch.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Oct 25, 2017 at 10:00:30PM +0200, Jarkko Sakkinen wrote:
> A minor tidbit: could the tpm_ prefix removed from those fields?

Yes, in v2

I will send v2 when you land your rework patch as this will depend on it.

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
