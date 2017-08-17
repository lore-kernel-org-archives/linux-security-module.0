From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Thu, 17 Aug 2017 10:32:40 +0200
Subject: [Linux-ima-devel] [PATCH 11/12] ima: don't report measurements if
	digests are included in the loaded lists
In-Reply-To: <96860a64-2ba1-d445-dd8e-08b131fe402b@linux.vnet.ibm.com>
References: <20170725154423.24845-1-roberto.sassu@huawei.com>
	<20170725154423.24845-12-roberto.sassu@huawei.com>
	<96860a64-2ba1-d445-dd8e-08b131fe402b@linux.vnet.ibm.com>
Message-ID: <f0dd1d3f-766a-0a8a-ccfc-e6b1ddd06adf@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 8/9/2017 10:36 PM, Ken Goldman wrote:
> On 7/25/2017 11:44 AM, Roberto Sassu wrote:
>> Don't report measurements if the file digest has been included in
>> an uploaded digest list.
>>
>> The advantage of this solution is that the boot time overhead, when
>> a TPM is available, is very small because a PCR is extended only
>> for unknown files. The disadvantage is that verifiers do not know
>> anymore which and when files are accessed (they must assume that
>> the worst case happened, i.e. all files have been accessed).
>
> Am I reading this correctly that you want to measure certain files, but
> not ones that have been included in a "digest list", which sounds like a
> white list of sorts.
>
> If so, I have two concerns:
>
> 1 - How would the client get this digest list?  Shouldn't it be up to
> the relying party to decide what is trusted and not trusted, not the
> client?

The client can get the digest list from the RPM database or the
measurement list of a previous boot. A verifier still decides if the
client is trusted or not, depending on what could be possibly accessed
rather than what has been accessed.


> What of the case with two different relying parties that have a
> different list of trusted applications?  E.g., one trusts any version of
> program X, while the other trusts only version 3.1 and up?

There are two ways to provide more accurate information (make the list
of possibly accessed files closer to the list of accessed files):

1) use the measurement list of a previous boot as a source for
    the digest list

2) use the RPM database as a source for the digest lists, and load the
    headers of the latest version of RPMs

    and:

    load only the headers of RPMs including files that appear in the
    measurement list of a previous boot (this solution should be
    preferred to solution 1, as signature-based attestation can be done)


> 2 - What about files on the digest list that were not run?  The relying
> party may want to know if a program wasn't run?  E.g., antivirus or a
> firewall.
>
> If the rule is "don't measure if it's on the digest list", how does the
> relying party know if it was run?

If a measurement list does not contain unknown digests, this means that
no malicious software was loaded. But, if the measurement list contains
the digest of an antivirus binary, this does not necessarily mean that
it was loaded.

Since PCR 10 can be extended from userspace, a malicious user can
extend the PCR with the digest of a fake measurement entry reporting
the loading of the antivirus. He can then add the fake entry to the
measurement list before it is sent to verifiers, so that they won't
notice the addition.

A possible countermeasure to this attack would be to modify the TPM
driver to refuse to extend the PCRs used by IMA.

Then, IMA could be further extended to accept a list of digests of files
that will be certainly used and to create a measurement entry only after
all files have been accessed.

Roberto


> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-security-module" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Qiuen PENG, Shengli WANG
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
