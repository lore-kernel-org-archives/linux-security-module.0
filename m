From: mjg59@google.com (Matthew Garrett)
Date: Tue, 7 Nov 2017 13:06:48 -0500
Subject: [PATCH v2 00/15] ima: digest list feature
In-Reply-To: <899b68a6-fefe-a6db-d624-ea83f597caf1@huawei.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
	<CACdnJutBFhCpudkbE0uKx1Ja=p8NUrmTMnA+9F4Y7+a7ioE8jA@mail.gmail.com>
	<899b68a6-fefe-a6db-d624-ea83f597caf1@huawei.com>
Message-ID: <CACdnJut-FzG=6DW-Pisx+_Ot5+=62_MabP1SU_RR2d9n-RJvyw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Nov 7, 2017 at 12:53 PM, Roberto Sassu <roberto.sassu@huawei.com> wrote:
> On 11/7/2017 3:49 PM, Matthew Garrett wrote:
>> RPM's hardly universal, and distributions are in the process of moving
>> away from using it for distributing non-core applications (Flatpak and
>> Snap are becoming increasingly popular here). I think this needs to be
>> a generic solution rather than having the kernel tied to a specific
>> package format.
>
>
> Support for new digest list formats can be easily added. Digest list
> metadata includes the digest list type, so that the appropriate parser
> is selected.

But we're still left in a state where the kernel has to end up
supporting a number of very niche formats, and userland agility is
tied to the kernel. I think it makes significantly more sense to push
the problem out to userland.

> Digest lists should be parsed directly by the kernel, because processing
> the lists in userspace would increase the chances that a compromised
> tool does not upload to the kernel the expected digests. Also, digest
> lists must be processed before init, otherwise appraisal will deny the
> execution. Lastly, the mechanism of parsing files from the kernel is
> already used to parse the IMA policy.

Isn't failing to upload the expected digest list just a DoS? We
already expect to load keys from initramfs, so it seems fine to parse
stuff there - what's the problem with extracting information from
RPMs, translating them to the generic format and pushing that into the
kernel?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
