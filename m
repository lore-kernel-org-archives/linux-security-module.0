From: tadeusz.struk@intel.com (Tadeusz Struk)
Date: Tue, 7 Aug 2018 12:09:41 -0700
Subject: [PATCH v3 RESEND 2/2] tpm: add support for nonblocking operation
In-Reply-To: <20180807182013.GC4960@ziepe.ca>
References: <153358975874.26901.16081444242758666628.stgit@tstruk-mobl1.jf.intel.com>
	<153359005823.27531.1050952672299708433.stgit@tstruk-mobl1.jf.intel.com>
	<1533596748.3159.19.camel@HansenPartnership.com>
	<20180807182013.GC4960@ziepe.ca>
Message-ID: <83e71fcc-d97d-e690-08c2-939458c7fe0c@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 08/07/2018 11:20 AM, Jason Gunthorpe wrote:
> Doesn't lockdep complain when locks are left held after returning to
> user space? Even if it doesn't, that is a pretty ugly thing to do.

I didn't notice anything from lockdep during my testing,
but I will change it to release the lock before returning.
Will send v4 soon.
Thanks,
-- 
Tadeusz
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
