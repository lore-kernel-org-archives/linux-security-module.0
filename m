From: serge@hallyn.com (Serge E. Hallyn)
Date: Fri, 17 Nov 2017 22:20:30 -0600
Subject: [PATCH v2 06/15] ima: add parser of digest lists metadata
In-Reply-To: <20171107103710.10883-7-roberto.sassu@huawei.com>
References: <20171107103710.10883-1-roberto.sassu@huawei.com>
	<20171107103710.10883-7-roberto.sassu@huawei.com>
Message-ID: <20171118042030.GA13456@mail.hallyn.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Nov 07, 2017 at 11:37:01AM +0100, Roberto Sassu wrote:
> from a predefined position (/etc/ima/digest_lists/metadata), when rootfs
> becomes available. Digest lists must be loaded before IMA appraisal is in
> enforcing mode.

I'm sure there's a good reason for it, but this seems weird to me.
Why read it from a file on disk instead of accepting it through say
a securityfile write?
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
