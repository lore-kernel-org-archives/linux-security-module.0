From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Mon, 08 Jan 2018 07:18:25 -0500
Subject: [PATCH V5 2/2] IMA: Support using new creds in appraisal policy
In-Reply-To: <20180105211536.11611-2-mjg59@google.com>
References: <20180105211536.11611-1-mjg59@google.com>
	<20180105211536.11611-2-mjg59@google.com>
Message-ID: <1515413905.3460.40.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2018-01-05 at 13:15 -0800, Matthew Garrett wrote:
> The existing BPRM_CHECK functionality in IMA validates against the
> credentials of the existing process, not any new credentials that the
> child process may transition to. Add an additional CREDS_CHECK target
> and refactor IMA to pass the appropriate creds structure. In
> ima_bprm_check(), check with both the existing process credentials and
> the credentials that will be committed when the new process is started.
> This will not change behaviour unless the system policy is extended to
> include CREDS_CHECK targets - BPRM_CHECK will continue to check the same
> credentials that it did previously.

Refactoring IMA to pass the creds structure all the way down is a
generic solution, but if the CREDS_CHECK rule is only being called
from ima_bprm_check(), "container_of" the bprm->file returns a pointer
to the bprm structure. ?Perhaps you could limit the amount of
refactoring needed based on the func.

I would prefer new arguments be added to process_measurement() only as
a last resort.

Could you include in the patch description a simple method for testing
this change?

thanks,

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
