From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Sat, 11 Mar 2017 10:15:32 +0200
Subject: [PATCH] tpm_crb: request and relinquish locality 0
In-Reply-To: <20170311002709.GA14174@obsidianresearch.com>
References: <20170310235802.30765-1-jarkko.sakkinen@linux.intel.com>
	<20170311002709.GA14174@obsidianresearch.com>
Message-ID: <20170311081532.qfxwrx3xqjzoppa2@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, Mar 10, 2017 at 05:27:09PM -0700, Jason Gunthorpe wrote:
> On Sat, Mar 11, 2017 at 01:58:00AM +0200, Jarkko Sakkinen wrote:
> > Added two new callbacks to struct tpm_class_ops:
> > 
> > - request_locality
> > - relinquish_locality
> > 
> > These are called before sending and receiving data from the TPM.
> 
> If we are going to add new ops, I think we should also adjust the
> existing drivers to use this mechanism as well?
> 
> eg tis just calls its request_locality as the first thing in send..
> 
> Jason

Would it be sufficient to adjust tpm_tis in addition to tpm_crb? Those
are the only once where I can edit edit-compile-run cycle.

The original commit I did worked on SKL platform that I tested but fails
on KBL but keeping the locality throughout the transmit makes it stable
on every platform I've tested.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
