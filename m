From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 25 Aug 2017 10:53:09 -0600
Subject: [PATCH] tpm/tpm_crb: Access locality for non-ACPI and non-SMC
	start method
In-Reply-To: <20170825162139.s5oasztecntzg223@linux.intel.com>
References: <1503029736-591-1-git-send-email-anjiandi@codeaurora.org>
	<20170822173956.zpqe4scdnv7plrhj@linux.intel.com>
	<d88e255c-f8c9-b6fc-64bd-8cf56153fcce@codeaurora.org>
	<20170824122630.75sxjmkj5f7p7tv5@linux.intel.com>
	<7478e964-6553-9d1e-3d8f-83b044a9a562@codeaurora.org>
	<20170825162139.s5oasztecntzg223@linux.intel.com>
Message-ID: <20170825165309.GB5254@obsidianresearch.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Aug 25, 2017 at 07:21:39PM +0300, Jarkko Sakkinen wrote:
> As I said before it would make much more sense to make code always deal
> with sm and remove flags completely. That would help maintaining code
> easier as new logic for TZ is introduced.

Yes please

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
