From: danielj@mellanox.com (Daniel Jurgens)
Date: Mon, 22 May 2017 10:50:31 +0000
Subject: [PATCH v7 0/9] SELinux support for Infiniband RDMA
References: <1495198139-69993-1-git-send-email-danielj@mellanox.com>
	<alpine.LRH.2.20.1705221033550.3502@namei.org>
Message-ID: <VI1PR05MB167866E1D919FC98BC9DC285C4F80@VI1PR05MB1678.eurprd05.prod.outlook.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 5/21/2017 7:35 PM, James Morris wrote:
> On Fri, 19 May 2017, Dan Jurgens wrote:
>
>> From: Daniel Jurgens <danielj@mellanox.com>
> What kind of testing has this code had?  It's relatively complex and as a 
> security feature, it especially needs to be well-tested.
>
>
I tested it on my own systems, checking that it correctly allows and restricts access, and revokes access to when the partition table or security policy change.  I'm also working with a group of defense contractors to deploy this in a cluster for testing in a more production like environment.  Once it's available in Linus' kernel releases I will also deploy automated testing in our regression system.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
