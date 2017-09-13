From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 13 Sep 2017 12:14:21 -0600
Subject: [PATCH 1/3] tpm: fix type of a local variable in
	tpm2_get_cc_attrs_tbl()
In-Reply-To: <20170913172620.24829-1-jarkko.sakkinen@linux.intel.com>
References: <20170913172620.24829-1-jarkko.sakkinen@linux.intel.com>
Message-ID: <20170913181421.GA1536@obsidianresearch.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, Sep 13, 2017 at 10:26:20AM -0700, Jarkko Sakkinen wrote:
> The local variable 'attrs' should have the type __be32 instead of u32.
> 
> Fixes: 58472f5cd4f6 ("tpm: validate TPM 2.0 commands")
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

All 3 look good to me:

Reviewed-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
