From: kgold@linux.vnet.ibm.com (Ken Goldman)
Date: Wed, 9 Aug 2017 16:36:01 -0400
Subject: [Linux-ima-devel] [PATCH 11/12] ima: don't report measurements if
	digests are included in the loaded lists
In-Reply-To: <20170725154423.24845-12-roberto.sassu@huawei.com>
References: <20170725154423.24845-1-roberto.sassu@huawei.com>
	<20170725154423.24845-12-roberto.sassu@huawei.com>
Message-ID: <96860a64-2ba1-d445-dd8e-08b131fe402b@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 7/25/2017 11:44 AM, Roberto Sassu wrote:
> Don't report measurements if the file digest has been included in
> an uploaded digest list.
> 
> The advantage of this solution is that the boot time overhead, when
> a TPM is available, is very small because a PCR is extended only
> for unknown files. The disadvantage is that verifiers do not know
> anymore which and when files are accessed (they must assume that
> the worst case happened, i.e. all files have been accessed).

Am I reading this correctly that you want to measure certain files, but 
not ones that have been included in a "digest list", which sounds like a 
white list of sorts.

If so, I have two concerns:

1 - How would the client get this digest list?  Shouldn't it be up to 
the relying party to decide what is trusted and not trusted, not the client?

What of the case with two different relying parties that have a 
different list of trusted applications?  E.g., one trusts any version of 
program X, while the other trusts only version 3.1 and up?

2 - What about files on the digest list that were not run?  The relying 
party may want to know if a program wasn't run?  E.g., antivirus or a 
firewall.

If the rule is "don't measure if it's on the digest list", how does the 
relying party know if it was run?

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
