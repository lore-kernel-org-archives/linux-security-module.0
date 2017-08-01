From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 1 Aug 2017 03:27:09 -0700
Subject: [PATCH, RESEND 08/12] ima: added parser for RPM data type
In-Reply-To: <20170801102036.15371-1-roberto.sassu@huawei.com>
References: <20170725154423.24845-9-roberto.sassu@huawei.com>
	<20170801102036.15371-1-roberto.sassu@huawei.com>
Message-ID: <20170801102709.GA24285@infradead.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Aug 01, 2017 at 12:20:36PM +0200, Roberto Sassu wrote:
> This patch introduces a parser for RPM packages. It extracts the digests
> from the RPMTAG_FILEDIGESTS header section and converts them to binary data
> before adding them to the hash table.
> 
> The advantage of this data type is that verifiers can determine who
> produced that data, as headers are signed by Linux distributions vendors.
> RPM headers signatures can be provided as digest list metadata.

Err, parsing arbitrary file formats has no business in the kernel.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
