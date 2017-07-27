From: jmorris@namei.org (James Morris)
Date: Thu, 27 Jul 2017 16:10:41 +1000 (AEST)
Subject: [PATCH v2] security: fix description of values returned by
	cap_inode_need_killpriv
In-Reply-To: <1501122425-12250-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1501122425-12250-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-ID: <alpine.LRH.2.20.1707271610320.31428@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 26 Jul 2017, Stefan Berger wrote:

> cap_inode_need_killpriv returns 1 if security.capability exists and
> has a value and inode_killpriv() is required, 0 otherwise. Fix the
> description of the return value to reflect this.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  security/commoncap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
