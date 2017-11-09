From: mjg59@google.com (Matthew Garrett)
Date: Thu, 9 Nov 2017 09:47:46 -0500
Subject: [PATCH v2 00/15] ima: digest list feature
In-Reply-To: <210975fe-527c-df2f-5a8a-9aca31e9246a@huawei.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
	<CACdnJutBFhCpudkbE0uKx1Ja=p8NUrmTMnA+9F4Y7+a7ioE8jA@mail.gmail.com>
	<899b68a6-fefe-a6db-d624-ea83f597caf1@huawei.com>
	<CACdnJut-FzG=6DW-Pisx+_Ot5+=62_MabP1SU_RR2d9n-RJvyw@mail.gmail.com>
	<e879759b-d866-e3e3-b070-3025baf3454d@huawei.com>
	<CACdnJut0-4k97m0TM-Zd4jLPTraBe6_JoE-eznFYKwbPEmNS0Q@mail.gmail.com>
	<210975fe-527c-df2f-5a8a-9aca31e9246a@huawei.com>
Message-ID: <CACdnJusj5aHHEJ2zY6UonK-XG_=P4Z09EPMZVKoXYUMZoUdHQQ@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, Nov 9, 2017 at 4:51 AM, Roberto Sassu <roberto.sassu@huawei.com> wrote:
> On 11/8/2017 4:48 PM, Matthew Garrett wrote:
>> The code doing the parsing is in the initramfs, which has already been
>> measured at boot time. You can guarantee that it's being done by
>> trusted code.
>
>
> The parser can be executed in the initial ram disk, but everything
> accessed before the parser is executed will be measured/appraised
> without digest lists. To do signature-based remote attestation, where
> the verification consists on checking the signature of digests of
> measured files, it would be necessary to sign systemd, libraries,
> everything accessed before the parser, and the parser. If RPM headers
> are parsed by the kernel, measurement/appraisal will be done directly
> with digest lists.

There's no need to have a policy that measures those files, because
they're part of the already-measured initramfs. Just set the IMA
policy after you've loaded the digest list.

>>> The main problem is that the digest list measurement, performed when the
>>> parser accesses the file containing the RPM header, might not reflect
>>> what IMA uses for digest lookup.
>>
>>
>> Why not?
>
>
> I assumed you wanted to measure digest lists only at the time they are
> read by the parser, and not when they are read by IMA. If instead digest
> lists are verified again after conversion, the new workflow should be:
>
> 1) the kernel parses digest list metadata before systemd is executed
> 2) the kernel verifies the signature of digest lists (RPM headers) and
>    add the digest of digest lists to the hash table, so that appraisal
>    succeeds
> 3) systemd (with file signature) is executed
> 4) the parser (with file signature) is executed
> 5) the parser reads and converts the digest lists to the generic format,
>    and writes them to a tmpfs filesystem
> 6) the parser generates a new digest list metadata file with the path of
>    converted digest lists and sends the path of the new metadata to IMA
> 7) IMA reads the generic digest lists
>
> The measurement list should look like:
>
> 10 <digest> ima-sig <digest> boot_aggregate
> 10 <digest> ima-sig <digest> /etc/ima/digest_lists/metadata
> 10 <digest> ima-sig <digest> /usr/lib/systemd/systemd <signature>
> ...
> 10 <digest> ima-sig <digest> <parser> <signature>
> 10 <digest> ima-sig <digest> /tmp/metadata
>
>
> If parsing of RPM headers is done by the kernel, the measurement list
> will look like:
>
> 10 <digest> ima-ng <digest> boot_aggregate
> 10 <digest> ima-ng <digest> /etc/ima/digest_lists/metadata
>
>
> A built-in policy should enable appraisal of tmpfs. If not, patch 11/15
> disables digest lookup for appraisal. Since generic digest lists will
> have a security.ima extended attribute (they are mutable files),
> appraisal verification will succeed.
>
> With this solution, digital signatures cannot be required, because
> generic digest lists will have a HMAC. For appraisal, it becomes
> necessary to ensure that only digest lists written by the parser can be
> processed by IMA.

This seems very over-complicated, and it's unclear why the kernel
needs to open the file itself. You *know* that all of userland is
trustworthy at this point even in the absence of signatures. It seems
reasonable to provide a interface that allows userland to pass a
digest list to the kernel, in the same way that userland can pass an
IMA policy to the kernel. You can then restrict access to that
interface via an LSM.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
