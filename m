From: jmorris@namei.org (James Morris)
Date: Mon, 22 May 2017 10:24:59 +1000 (AEST)
Subject: [PATCH v7 5/9] selinux: Create policydb version for Infiniband
	support
In-Reply-To: <1495198139-69993-6-git-send-email-danielj@mellanox.com>
References: <1495198139-69993-1-git-send-email-danielj@mellanox.com>
	<1495198139-69993-6-git-send-email-danielj@mellanox.com>
Message-ID: <alpine.LRH.2.20.1705221024350.3502@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 19 May 2017, Dan Jurgens wrote:

> From: Daniel Jurgens <danielj@mellanox.com>
> 
> Support for Infiniband requires the addition of two new object contexts,
> one for infiniband PKeys and another IB Ports. Added handlers to read
> and write the new ocontext types when reading or writing a binary policy
> representation.
> 
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
> Reviewed-by: Eli Cohen <eli@mellanox.com>


Reviewed-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
