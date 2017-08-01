From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Tue, 1 Aug 2017 12:58:46 +0200
Subject: [PATCH, RESEND 08/12] ima: added parser for RPM data type
In-Reply-To: <20170801102709.GA24285@infradead.org>
References: <20170725154423.24845-9-roberto.sassu@huawei.com>
	<20170801102036.15371-1-roberto.sassu@huawei.com>
	<20170801102709.GA24285@infradead.org>
Message-ID: <11206fd8-d189-deb0-ab67-aec373f8d979@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 8/1/2017 12:27 PM, Christoph Hellwig wrote:
> On Tue, Aug 01, 2017 at 12:20:36PM +0200, Roberto Sassu wrote:
>> This patch introduces a parser for RPM packages. It extracts the digests
>> from the RPMTAG_FILEDIGESTS header section and converts them to binary data
>> before adding them to the hash table.
>>
>> The advantage of this data type is that verifiers can determine who
>> produced that data, as headers are signed by Linux distributions vendors.
>> RPM headers signatures can be provided as digest list metadata.
>
> Err, parsing arbitrary file formats has no business in the kernel.

The benefit of this choice is that no actions are required for
Linux distribution vendors to support the solution I'm proposing,
because they already provide signed digest lists (RPM headers).

Since the proof of loading a digest list is the digest of the
digest list (included in the list metadata), if RPM headers are
converted to a different format, remote attestation verifiers
cannot check the signature.

If the concern is security, it would be possible to prevent unsigned
RPM headers from being parsed, if the PGP key type is upstreamed
(adding in CC keyrings at vger.kernel.org).

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Qiuen PENG, Shengli WANG
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
