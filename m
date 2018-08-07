From: tadeusz.struk@intel.com (Tadeusz Struk)
Date: Mon, 6 Aug 2018 17:09:01 -0700
Subject: [PATCH v3 RESEND 2/2] tpm: add support for nonblocking operation
In-Reply-To: <1533596748.3159.19.camel@HansenPartnership.com>
References: <153358975874.26901.16081444242758666628.stgit@tstruk-mobl1.jf.intel.com>
	<153359005823.27531.1050952672299708433.stgit@tstruk-mobl1.jf.intel.com>
	<1533596748.3159.19.camel@HansenPartnership.com>
Message-ID: <1064594c-3a3f-4d2a-5d94-e8314b330292@intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 08/06/2018 04:05 PM, James Bottomley wrote:
> For an async interface, shouldn't I be able to queue an
> arbitrary number of commands without blocking?

That was the approach in the v1 version of this patch, but
Jason requested this to be changed so that only one command
at a time can be processed.
Thanks,
-- 
Tadeusz
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
