From: kgold@linux.vnet.ibm.com (Ken Goldman)
Date: Wed, 17 May 2017 12:28:35 -0400
Subject: [Linux-ima-devel] [PATCH 0/7] IMA: new parser for
	ima_restore_measurement_list()
In-Reply-To: <42b629dd-0d1f-b066-03e4-c013d0891ba7@huawei.com>
References: <20170516125347.10574-1-roberto.sassu@huawei.com>
	<4f5bc289-92cb-1ce2-4496-387efbb11769@linux.vnet.ibm.com>
	<42b629dd-0d1f-b066-03e4-c013d0891ba7@huawei.com>
Message-ID: <4b536b04-0e61-aea4-fc27-8dd12f2e3a1b@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 5/17/2017 3:25 AM, Roberto Sassu wrote:
> 
> The format of digestN is: <algo name>:\0<digest value>, the same used
> for the file digest.

Since the format is changing from the SHA-1 log format anyway ...

How do people feel about the colon and null terminated string format for 
algorithm identifiers?

The TCG standard enumerations are uint16_t, and there is a registry of 
hash algorithms.

As a consuming parser, it feels nice to know it's always 2 bytes and not 
have to worry about a missing colon or a missing nul terminator risking 
a buffer overflow.

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
