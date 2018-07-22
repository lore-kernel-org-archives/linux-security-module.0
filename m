From: zohar@linux.ibm.com (Mimi Zohar)
Date: Sun, 22 Jul 2018 19:38:41 -0400
Subject: [PATCH -next] EVM: fix return value check in evm_write_xattrs()
In-Reply-To: <20180711151510.GA23645@mail.hallyn.com>
References: <1531315720-4191-1-git-send-email-weiyongjun1@huawei.com>
	<20180711151510.GA23645@mail.hallyn.com>
Message-ID: <1532302721.6206.24.camel@linux.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 2018-07-11 at 10:15 -0500, Serge E. Hallyn wrote:
> Quoting Wei Yongjun (weiyongjun1 at huawei.com):
> > In case of error, the function audit_log_start() returns NULL pointer
> > not ERR_PTR(). The IS_ERR() test in the return value check should be
> > replaced with NULL test.
> > 
> > Fixes: fa516b66a1bf ("EVM: Allow runtime modification of the set of verified xattrs")
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Acked-by: Serge Hallyn <serge@hallyn.com>

Thanks, this patch is now queued in the next-integrity branch of the
linux-integrity tree.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
