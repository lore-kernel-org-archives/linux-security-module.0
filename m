From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Mon, 12 Mar 2018 09:02:32 -0600
Subject: [PATCH] tpm: allow TCPA log area to be empty
In-Reply-To: <20180310161637.7723-1-jarkko.sakkinen@linux.intel.com>
References: <20180310161637.7723-1-jarkko.sakkinen@linux.intel.com>
Message-ID: <20180312150231.GA24717@ziepe.ca>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Mar 10, 2018 at 06:16:37PM +0200, Jarkko Sakkinen wrote:
> TCPA log are can be empty when the TPM is disabled. This commit changes the
> behavior of tpm_read_log_acpi() to return successfully in this case.

The commit should explain why we'd want this..

eg Why does it matter to create the extra sysfs files to report an empty
log?

Jason
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
