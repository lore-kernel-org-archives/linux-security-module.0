From: jmorris@namei.org (James Morris)
Date: Sat, 31 Mar 2018 13:13:22 +1100 (AEDT)
Subject: [REVIEW][PATCH 12/11] ipc: Directly call the security hook in
	ipc_ops.associate
In-Reply-To: <877eq2m3or.fsf_-_@xmission.com>
References: <1520875093-18174-1-git-send-email-nagarathnam.muthusamy@oracle.com>
	<87vadzqqq6.fsf@xmission.com>
	<990e88fa-ab50-9645-b031-14e1afbf7ccc@oracle.com>
	<877eqejowd.fsf@xmission.com>
	<3a46a03d-e4dd-59b6-e25f-0020be1b1dc9@oracle.com>
	<87a7v2z2qa.fsf@xmission.com> <87vadmobdw.fsf_-_@xmission.com>
	<877eq2m3or.fsf_-_@xmission.com>
Message-ID: <alpine.LRH.2.21.1803311313010.7769@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, 24 Mar 2018, Eric W. Biederman wrote:

> 
> After the last round of cleanups the shm, sem, and msg associate
> operations just became trivial wrappers around the appropriate security
> method.  Simplify things further by just calling the security method
> directly.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>


Reviewed-by: James Morris <james.morris@microsoft.com>


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
