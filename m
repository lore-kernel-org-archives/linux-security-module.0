From: jmorris@namei.org (James Morris)
Date: Mon, 22 May 2017 09:56:18 +1000 (AEST)
Subject: [PATCH v7 1/9] IB/core: IB cache enhancements to support
	Infiniband security
In-Reply-To: <1495198139-69993-2-git-send-email-danielj@mellanox.com>
References: <1495198139-69993-1-git-send-email-danielj@mellanox.com>
	<1495198139-69993-2-git-send-email-danielj@mellanox.com>
Message-ID: <alpine.LRH.2.20.1705220956020.3502@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 19 May 2017, Dan Jurgens wrote:

> From: Daniel Jurgens <danielj@mellanox.com>
> 
> Cache the subnet prefix and add a function to access it. Enforcing
> security requires frequent queries of the subnet prefix and the pkeys in
> the pkey table.
> 
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
> Reviewed-by: Eli Cohen <eli@mellanox.com>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>

Reviewed-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
