From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Thu, 09 Nov 2017 11:17:16 -0500
Subject: [PATCH v2 00/15] ima: digest list feature
In-Reply-To: <CACdnJusj5aHHEJ2zY6UonK-XG_=P4Z09EPMZVKoXYUMZoUdHQQ@mail.gmail.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
	<CACdnJutBFhCpudkbE0uKx1Ja=p8NUrmTMnA+9F4Y7+a7ioE8jA@mail.gmail.com>
	<899b68a6-fefe-a6db-d624-ea83f597caf1@huawei.com>
	<CACdnJut-FzG=6DW-Pisx+_Ot5+=62_MabP1SU_RR2d9n-RJvyw@mail.gmail.com>
	<e879759b-d866-e3e3-b070-3025baf3454d@huawei.com>
	<CACdnJut0-4k97m0TM-Zd4jLPTraBe6_JoE-eznFYKwbPEmNS0Q@mail.gmail.com>
	<210975fe-527c-df2f-5a8a-9aca31e9246a@huawei.com>
	<CACdnJusj5aHHEJ2zY6UonK-XG_=P4Z09EPMZVKoXYUMZoUdHQQ@mail.gmail.com>
Message-ID: <1510244236.4484.172.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 2017-11-09 at 09:47 -0500, Matthew Garrett wrote:

> This seems very over-complicated, and it's unclear why the kernel
> needs to open the file itself. You *know* that all of userland is
> trustworthy at this point even in the absence of signatures.

Assuming the initramfs is signed, then yes the rootfs files would be
trusted. ?rootfs can still access files from real root, which is where
policies are normally stored.

> It seems
> reasonable to provide a interface that allows userland to pass a
> digest list to the kernel, in the same way that userland can pass an
> IMA policy to the kernel. You can then restrict access to that
> interface via an LSM.

IMA can and should be configured to require signed policies.

Mimi

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
