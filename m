From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 10 Mar 2017 17:27:09 -0700
Subject: [PATCH] tpm_crb: request and relinquish locality 0
In-Reply-To: <20170310235802.30765-1-jarkko.sakkinen@linux.intel.com>
References: <20170310235802.30765-1-jarkko.sakkinen@linux.intel.com>
Message-ID: <20170311002709.GA14174@obsidianresearch.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Mar 11, 2017 at 01:58:00AM +0200, Jarkko Sakkinen wrote:
> Added two new callbacks to struct tpm_class_ops:
> 
> - request_locality
> - relinquish_locality
> 
> These are called before sending and receiving data from the TPM.

If we are going to add new ops, I think we should also adjust the
existing drivers to use this mechanism as well?

eg tis just calls its request_locality as the first thing in send..

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
