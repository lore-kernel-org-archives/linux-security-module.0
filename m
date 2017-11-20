From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Mon, 20 Nov 2017 10:40:11 +0100
Subject: [PATCH v2 06/15] ima: add parser of digest lists metadata
In-Reply-To: <1511047410.5920.111.camel@linux.vnet.ibm.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
	<20171107103710.10883-7-roberto.sassu@huawei.com>
	<20171118042030.GA13456@mail.hallyn.com>
	<1511047410.5920.111.camel@linux.vnet.ibm.com>
Message-ID: <175600e1-c472-69fc-2b4d-4255d8e827b5@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 11/19/2017 12:23 AM, Mimi Zohar wrote:
> Hi Serge,
> 
> On Fri, 2017-11-17 at 22:20 -0600, Serge E. Hallyn wrote:
>> On Tue, Nov 07, 2017 at 11:37:01AM +0100, Roberto Sassu wrote:
>>> from a predefined position (/etc/ima/digest_lists/metadata), when rootfs
>>> becomes available. Digest lists must be loaded before IMA appraisal is in
>>> enforcing mode.
>>
>> I'm sure there's a good reason for it, but this seems weird to me.
>> Why read it from a file on disk instead of accepting it through say
>> a securityfile write?

There are two reasons.

Digest lists must be loaded before any file is accessed, otherwise IMA
will deny the operation if appraisal is in enforcing mode. With digest
lists it is possible to appraise files in the initial ram disk without
including extended attributes (the default policy excludes those files).

The second reason is that appraisal has to be temporarily disabled
because the file containing digest list metadata is not signed. The same
happens when loading a public key (check ima_load_x509() in ima_init.c).

The file containing digest list metadata is not signed because its
content depends on the list of installed packages. I thought it is
acceptable to load it without verification, as providing the path of
digest lists is similar to writing the path of a policy to a securityfs
file. The important point is that no digest is added to the hash table
without verifying the signature first.

The alternative would be to load signed digest lists directly. But, the
main issue is that there would be a PCR extend for each digest list,
while with digest list metadata there is only one.


> Assuming that the concept of a white list is something we want to
> support, then at minimum the list needs to be signed and verified.
> Instead of defining a new Kconfig pathname option, a securityfs file
> could read it, like the IMA policy.

Both methods are supported (patch 9/15 introduces 'digest_lists' in the
securityfs filesystem). The securityfs file can be used to load digest
lists for files not in the initial ram disk, and for system updates.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Qiuen PENG, Shengli WANG
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
