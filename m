From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Thu, 18 May 2017 11:38:24 +0200
Subject: [Linux-ima-devel] [PATCH 0/7] IMA: new parser for
	ima_restore_measurement_list()
In-Reply-To: <4b536b04-0e61-aea4-fc27-8dd12f2e3a1b@linux.vnet.ibm.com>
References: <20170516125347.10574-1-roberto.sassu@huawei.com>
	<4f5bc289-92cb-1ce2-4496-387efbb11769@linux.vnet.ibm.com>
	<42b629dd-0d1f-b066-03e4-c013d0891ba7@huawei.com>
	<4b536b04-0e61-aea4-fc27-8dd12f2e3a1b@linux.vnet.ibm.com>
Message-ID: <3b204e09-c1c0-b3bc-90fe-a8dfb86baadc@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 5/17/2017 6:28 PM, Ken Goldman wrote:
> On 5/17/2017 3:25 AM, Roberto Sassu wrote:
>>
>> The format of digestN is: <algo name>:\0<digest value>, the same used
>> for the file digest.
>
> Since the format is changing from the SHA-1 log format anyway ...
>
> How do people feel about the colon and null terminated string format for
> algorithm identifiers?
>
> The TCG standard enumerations are uint16_t, and there is a registry of
> hash algorithms.
>
> As a consuming parser, it feels nice to know it's always 2 bytes and not
> have to worry about a missing colon or a missing nul terminator risking
> a buffer overflow.

There cannot be buffer overflow, because the length of each digest
field is known.

Roberto
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
