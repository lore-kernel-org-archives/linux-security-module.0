From: jmorris@namei.org (James Morris)
Date: Mon, 22 May 2017 10:31:52 +1000 (AEST)
Subject: [PATCH v7 7/9] selinux: Implement Infiniband PKey "Access" access
	vector
In-Reply-To: <1495198139-69993-8-git-send-email-danielj@mellanox.com>
References: <1495198139-69993-1-git-send-email-danielj@mellanox.com>
	<1495198139-69993-8-git-send-email-danielj@mellanox.com>
Message-ID: <alpine.LRH.2.20.1705221031310.3502@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 19 May 2017, Dan Jurgens wrote:

> From: Daniel Jurgens <danielj@mellanox.com>
> 
> Add a type and access vector for PKeys. Implement the ib_pkey_access
> hook to check that the caller has permission to access the PKey on the
> given subnet prefix. Add an interface to get the PKey SID. Walk the PKey
> ocontexts to find an entry for the given subnet prefix and pkey.
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
