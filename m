From: mjg59@google.com (Matthew Garrett)
Date: Wed, 8 Nov 2017 10:48:56 -0500
Subject: [PATCH v2 00/15] ima: digest list feature
In-Reply-To: <e879759b-d866-e3e3-b070-3025baf3454d@huawei.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
	<CACdnJutBFhCpudkbE0uKx1Ja=p8NUrmTMnA+9F4Y7+a7ioE8jA@mail.gmail.com>
	<899b68a6-fefe-a6db-d624-ea83f597caf1@huawei.com>
	<CACdnJut-FzG=6DW-Pisx+_Ot5+=62_MabP1SU_RR2d9n-RJvyw@mail.gmail.com>
	<e879759b-d866-e3e3-b070-3025baf3454d@huawei.com>
Message-ID: <CACdnJut0-4k97m0TM-Zd4jLPTraBe6_JoE-eznFYKwbPEmNS0Q@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Nov 8, 2017 at 7:00 AM, Roberto Sassu <roberto.sassu@huawei.com> wrote:
> On 11/7/2017 7:06 PM, Matthew Garrett wrote:
>> But we're still left in a state where the kernel has to end up
>> supporting a number of very niche formats, and userland agility is
>> tied to the kernel. I think it makes significantly more sense to push
>> the problem out to userland.
>
>
> At least for appraisal, digest lists must be parsed by the kernel. If
> the parser is moved to userspace, I don't know if we are able to provide
> the same guarantee, that the correct set of digests has been uploaded to
> IMA. A new measurement can be added, when IMA receives the digests, but
> a verifier has to verify the signature of the original file, perform
> format conversion, calculate the digest and compare it with that in the
> new IMA measurement. If digest lists are parsed directly by the kernel,
> then the signature can be verified directly.

The code doing the parsing is in the initramfs, which has already been
measured at boot time. You can guarantee that it's being done by
trusted code.

>> Isn't failing to upload the expected digest list just a DoS? We
>> already expect to load keys from initramfs, so it seems fine to parse
>> stuff there - what's the problem with extracting information from
>> RPMs, translating them to the generic format and pushing that into the
>> kernel?
>
>
> The main problem is that the digest list measurement, performed when the
> parser accesses the file containing the RPM header, might not reflect
> what IMA uses for digest lookup.

Why not?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
