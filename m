From: jmorris@namei.org (James Morris)
Date: Mon, 22 May 2017 10:26:09 +1000 (AEST)
Subject: [PATCH v7 6/9] selinux: Allocate and free infiniband security
	hooks
In-Reply-To: <1495198139-69993-7-git-send-email-danielj@mellanox.com>
References: <1495198139-69993-1-git-send-email-danielj@mellanox.com>
	<1495198139-69993-7-git-send-email-danielj@mellanox.com>
Message-ID: <alpine.LRH.2.20.1705221025540.3502@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 19 May 2017, Dan Jurgens wrote:

> From: Daniel Jurgens <danielj@mellanox.com>
> 
> Implement and attach hooks to allocate and free Infiniband object
> security structures.
> 
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>


Reviewed-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
