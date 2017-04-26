From: mkayaalp@linux.vnet.ibm.com (Mehmet Kayaalp)
Date: Wed, 26 Apr 2017 18:18:34 -0400
Subject: [PATCH 6/6] ima: Support appended signatures for appraisal
In-Reply-To: <35565259.p7kmk0rNRg@morokweng>
References: <201704201148.IPsFhl4B%fengguang.wu@intel.com>
	<35565259.p7kmk0rNRg@morokweng>
Message-ID: <CDEBC6BB-7178-4891-9743-DD2B70328FCC@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org


> On Apr 20, 2017, at 7:41 PM, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> wrote:
> 
> This patch introduces the appended_imasig keyword to the IMA policy syntax
> to specify that a given hook should expect the file to have the IMA
> signature appended to it. Here is how it can be used in a rule:
> 
> appraise func=KEXEC_KERNEL_CHECK appraise_type=appended_imasig
> appraise func=KEXEC_KERNEL_CHECK appraise_type=appended_imasig|imasig
> 
> In the second form, IMA will accept either an appended signature or a
> signature stored in the extended attribute. In that case, it will first
> check whether there is an appended signature, and if not it will read it
> from the extended attribute.
> 
> The format of the appended signature is the same used for signed kernel
> modules. This means that the file can be signed with the scripts/sign-file
> tool, with a command line such as this:

I would suggest naming the appraise_type as modsig (or some variant) to clarify
that the format is defined by how module signatures are handled. Maybe we'd like 
to define a different appended/inline signature format for IMA in the future.

-Mehmet
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
