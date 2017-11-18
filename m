From: zohar@linux.vnet.ibm.com (Mimi Zohar)
Date: Sat, 18 Nov 2017 18:23:30 -0500
Subject: [PATCH v2 06/15] ima: add parser of digest lists metadata
In-Reply-To: <20171118042030.GA13456@mail.hallyn.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
	<20171107103710.10883-7-roberto.sassu@huawei.com>
	<20171118042030.GA13456@mail.hallyn.com>
Message-ID: <1511047410.5920.111.camel@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Hi Serge,

On Fri, 2017-11-17 at 22:20 -0600, Serge E. Hallyn wrote:
> On Tue, Nov 07, 2017 at 11:37:01AM +0100, Roberto Sassu wrote:
> > from a predefined position (/etc/ima/digest_lists/metadata), when rootfs
> > becomes available. Digest lists must be loaded before IMA appraisal is in
> > enforcing mode.
> 
> I'm sure there's a good reason for it, but this seems weird to me.
> Why read it from a file on disk instead of accepting it through say
> a securityfile write?

Assuming that the concept of a white list is something we want to
support, then at minimum the list needs to be signed and verified.
Instead of defining a new Kconfig pathname option, a securityfs file
could read it, like the IMA policy.

Mimi


--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
