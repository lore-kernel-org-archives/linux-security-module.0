From: kgold@linux.vnet.ibm.com (Ken Goldman)
Date: Tue, 23 May 2017 17:00:27 -0400
Subject: [Linux-ima-devel] [PATCH 0/7] IMA: new parser for
	ima_restore_measurement_list()
In-Reply-To: <3b204e09-c1c0-b3bc-90fe-a8dfb86baadc@huawei.com>
References: <20170516125347.10574-1-roberto.sassu@huawei.com>
	<4f5bc289-92cb-1ce2-4496-387efbb11769@linux.vnet.ibm.com>
	<42b629dd-0d1f-b066-03e4-c013d0891ba7@huawei.com>
	<4b536b04-0e61-aea4-fc27-8dd12f2e3a1b@linux.vnet.ibm.com>
	<3b204e09-c1c0-b3bc-90fe-a8dfb86baadc@huawei.com>
Message-ID: <96385c1f-26f9-989b-3b68-0ad261e927b5@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 5/18/2017 5:38 AM, Roberto Sassu wrote:
> 
> There cannot be buffer overflow, because the length of each digest
> field is known.

Crypto Agile: pcr[4] total_digest_len[4]
                digest1_len[4] digest1[digest1_len] ...

The way I read this, the digest length is supplied by the caller, which 
is slightly different from "known".  For example, if I supply a digest 
length of 0xffffffff, a too trusting (buggy) parser could overflow the 
buffer.

total_digest_len is similarly untrusted.  The attacker can send invalid 
values.


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
