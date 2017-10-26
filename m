From: james.l.morris@oracle.com (James Morris)
Date: Thu, 26 Oct 2017 11:04:59 +0200 (CEST)
Subject: [PATCH V3 1/2] security: Add a cred_getsecid hook
In-Reply-To: <20171026084055.25482-1-mjg59@google.com>
References: <20171026084055.25482-1-mjg59@google.com>
Message-ID: <alpine.LFD.2.20.1710261104330.14992@localhost>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 26 Oct 2017, Matthew Garrett wrote:

> For IMA purposes, we want to be able to obtain the prepared secid in the
> bprm structure before the credentials are committed. Add a cred_getsecid
> hook that makes this possible.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Acked-by: Paul Moore <paul@paul-moore.com>


Acked-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
