From: roberto.sassu@huawei.com (Roberto Sassu)
Date: Thu, 9 Nov 2017 10:51:15 +0100
Subject: [PATCH v2 00/15] ima: digest list feature
In-Reply-To: <CACdnJut0-4k97m0TM-Zd4jLPTraBe6_JoE-eznFYKwbPEmNS0Q@mail.gmail.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
	<CACdnJutBFhCpudkbE0uKx1Ja=p8NUrmTMnA+9F4Y7+a7ioE8jA@mail.gmail.com>
	<899b68a6-fefe-a6db-d624-ea83f597caf1@huawei.com>
	<CACdnJut-FzG=6DW-Pisx+_Ot5+=62_MabP1SU_RR2d9n-RJvyw@mail.gmail.com>
	<e879759b-d866-e3e3-b070-3025baf3454d@huawei.com>
	<CACdnJut0-4k97m0TM-Zd4jLPTraBe6_JoE-eznFYKwbPEmNS0Q@mail.gmail.com>
Message-ID: <210975fe-527c-df2f-5a8a-9aca31e9246a@huawei.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 11/8/2017 4:48 PM, Matthew Garrett wrote:
> On Wed, Nov 8, 2017 at 7:00 AM, Roberto Sassu <roberto.sassu@huawei.com> wrote:
>> On 11/7/2017 7:06 PM, Matthew Garrett wrote:
>>> But we're still left in a state where the kernel has to end up
>>> supporting a number of very niche formats, and userland agility is
>>> tied to the kernel. I think it makes significantly more sense to push
>>> the problem out to userland.
>>
>>
>> At least for appraisal, digest lists must be parsed by the kernel. If
>> the parser is moved to userspace, I don't know if we are able to provide
>> the same guarantee, that the correct set of digests has been uploaded to
>> IMA. A new measurement can be added, when IMA receives the digests, but
>> a verifier has to verify the signature of the original file, perform
>> format conversion, calculate the digest and compare it with that in the
>> new IMA measurement. If digest lists are parsed directly by the kernel,
>> then the signature can be verified directly.
> 
> The code doing the parsing is in the initramfs, which has already been
> measured at boot time. You can guarantee that it's being done by
> trusted code.

The parser can be executed in the initial ram disk, but everything
accessed before the parser is executed will be measured/appraised
without digest lists. To do signature-based remote attestation, where
the verification consists on checking the signature of digests of
measured files, it would be necessary to sign systemd, libraries,
everything accessed before the parser, and the parser. If RPM headers
are parsed by the kernel, measurement/appraisal will be done directly
with digest lists.


>>> Isn't failing to upload the expected digest list just a DoS? We
>>> already expect to load keys from initramfs, so it seems fine to parse
>>> stuff there - what's the problem with extracting information from
>>> RPMs, translating them to the generic format and pushing that into the
>>> kernel?
>>
>>
>> The main problem is that the digest list measurement, performed when the
>> parser accesses the file containing the RPM header, might not reflect
>> what IMA uses for digest lookup.
> 
> Why not?

I assumed you wanted to measure digest lists only at the time they are
read by the parser, and not when they are read by IMA. If instead digest
lists are verified again after conversion, the new workflow should be:

1) the kernel parses digest list metadata before systemd is executed
2) the kernel verifies the signature of digest lists (RPM headers) and
    add the digest of digest lists to the hash table, so that appraisal
    succeeds
3) systemd (with file signature) is executed
4) the parser (with file signature) is executed
5) the parser reads and converts the digest lists to the generic format,
    and writes them to a tmpfs filesystem
6) the parser generates a new digest list metadata file with the path of
    converted digest lists and sends the path of the new metadata to IMA
7) IMA reads the generic digest lists

The measurement list should look like:

10 <digest> ima-sig <digest> boot_aggregate
10 <digest> ima-sig <digest> /etc/ima/digest_lists/metadata
10 <digest> ima-sig <digest> /usr/lib/systemd/systemd <signature>
...
10 <digest> ima-sig <digest> <parser> <signature>
10 <digest> ima-sig <digest> /tmp/metadata


If parsing of RPM headers is done by the kernel, the measurement list
will look like:

10 <digest> ima-ng <digest> boot_aggregate
10 <digest> ima-ng <digest> /etc/ima/digest_lists/metadata


A built-in policy should enable appraisal of tmpfs. If not, patch 11/15
disables digest lookup for appraisal. Since generic digest lists will
have a security.ima extended attribute (they are mutable files),
appraisal verification will succeed.

With this solution, digital signatures cannot be required, because
generic digest lists will have a HMAC. For appraisal, it becomes
necessary to ensure that only digest lists written by the parser can be
processed by IMA.

Roberto

-- 
HUAWEI TECHNOLOGIES Duesseldorf GmbH, HRB 56063
Managing Director: Bo PENG, Qiuen PENG, Shengli WANG
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
