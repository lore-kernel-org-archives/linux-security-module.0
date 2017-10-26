From: james.l.morris@oracle.com (James Morris)
Date: Thu, 26 Oct 2017 11:11:09 +0200 (CEST)
Subject: [PATCH V3 2/2] IMA: Support using new creds in appraisal
 policy
In-Reply-To: <20171026084055.25482-2-mjg59@google.com>
References: <20171026084055.25482-1-mjg59@google.com>
	<20171026084055.25482-2-mjg59@google.com>
Message-ID: <alpine.LFD.2.20.1710261110260.14992@localhost>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 26 Oct 2017, Matthew Garrett wrote:

> The existing BPRM_CHECK functionality in IMA validates against the
> credentials of the existing process, not any new credentials that the
> child process may transition to. Add an additional CREDS_CHECK target
> and refactor IMA to pass the appropriate creds structure. In
> ima_bprm_check(), check with both the existing process credentials and
> the credentials that will be committed when the new process is started.
> This will not change behaviour unless the system policy is extended to
> include CREDS_CHECK targets - BPRM_CHECK will continue to check the same
> credentials that it did previously.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>


Reviewed-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
