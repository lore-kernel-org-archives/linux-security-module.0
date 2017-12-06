From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Wed, 6 Dec 2017 10:22:52 +0100
Subject: [Linux-ima-devel] [PATCH 12/12] ima: added
	Documentation/security/IMA-digest-lists.txt
In-Reply-To: <97fded2f-b494-b633-3bd7-e7dea8e230c0@linux.vnet.ibm.com>
References: <20170725154423.24845-1-roberto.sassu@huawei.com>
	<20170725154423.24845-13-roberto.sassu@huawei.com>
	<97fded2f-b494-b633-3bd7-e7dea8e230c0@linux.vnet.ibm.com>
Message-ID: <bbf48fb2-fa13-31c0-2f17-65aa52f3f04b@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 12/5/2017 11:28 PM, Ken Goldman wrote:
> On 7/25/2017 11:44 AM, Roberto Sassu wrote:
>> +==== FORMAT ====
>> +
>> +The format of digest list metadata is:
>> +
>> +algo[2] digest_len[4] digest[digest_len]
>> +??????? signature_len[4] signature[signature_len]
>> +??????? path_len[4] path[path_len]
>> +??????? ref_id_len[4] ref_id[ref_id_len]
>> +??????? list_type_len[4] list_type[list_type_len]
>> +
> 
> It's not obvious how this would handle the TPM 2.0 case where there are 
> multiple PCR banks with different hash algorithms

'algo[2]' is the identifier of the algorithm used to calculate file
digests. PCR banks are extended with digests of measurement entries.

Roberto

> -- 
> To unsubscribe from this list: send the line "unsubscribe 
> linux-security-module" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at? http://vger.kernel.org/majordomo-info.html

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Qiuen PENG, Shengli WANG
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
