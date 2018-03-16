From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Fri, 16 Mar 2018 15:34:02 +0200
Subject: [PATCH v3 0/6] add integrity and security to TPM2 transactions
In-Reply-To: <1520870233.4522.20.camel@HansenPartnership.com>
References: <1520720026.4495.11.camel@HansenPartnership.com>
	<4aa8a4daf4b2f9f76f86b07bbdcb2f4c06b69a98.camel@linux.intel.com>
	<1520870233.4522.20.camel@HansenPartnership.com>
Message-ID: <20180316133402.GA7387@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Mar 12, 2018 at 08:57:13AM -0700, James Bottomley wrote:
> I think the way I'm going to fix the trusted key policy problem is to
> move it back into the kernel for the simple PCR lock policy (which will
> make changing from 1.2 to 2.0 seamless because the external Key API
> will then become the same) so the kernel gets the missing TPM nonce and
> can then do TPM2_PolicyAuthValue.

Sounds reasonable.

> User generated policy sessions for trusted keys are very flexible but
> also a hugely bad idea for consumers because it's so different from the
> way 1.2 works and it means now the user has to exercise a TPM API to
> produce the policy sessions.
> 
> Longer term, I think having a particular trusted key represent a policy
> session which can then be attached to a different trusted key
> representing the blob is the best idea because we can expose the policy
> build up via the trusted key API and keep all the TPM nastiness inside
> the kernel.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
