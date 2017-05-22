From: jmorris@namei.org (James Morris)
Date: Mon, 22 May 2017 10:32:43 +1000 (AEST)
Subject: [PATCH v7 8/9] selinux: Add IB Port SMP access vector
In-Reply-To: <1495198139-69993-9-git-send-email-danielj@mellanox.com>
References: <1495198139-69993-1-git-send-email-danielj@mellanox.com>
	<1495198139-69993-9-git-send-email-danielj@mellanox.com>
Message-ID: <alpine.LRH.2.20.1705221032250.3502@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 19 May 2017, Dan Jurgens wrote:

> From: Daniel Jurgens <danielj@mellanox.com>
> 
> Add a type for Infiniband ports and an access vector for subnet
> management packets. Implement the ib_port_smp hook to check that the
> caller has permission to send and receive SMPs on the end port specified
> by the device name and port. Add interface to query the SID for a IB
> port, which walks the IB_PORT ocontexts to find an entry for the
> given name and port.
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
