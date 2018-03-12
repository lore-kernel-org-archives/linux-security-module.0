From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Mon, 12 Mar 2018 13:09:07 +0200
Subject: [PATCH] tpm: allow TCPA log area to be empty
In-Reply-To: <20180310161637.7723-1-jarkko.sakkinen@linux.intel.com>
References: <20180310161637.7723-1-jarkko.sakkinen@linux.intel.com>
Message-ID: <20180312110907.GA7448@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Mar 10, 2018 at 06:16:37PM +0200, Jarkko Sakkinen wrote:
> TCPA log are can be empty when the TPM is disabled. This commit changes the
> behavior of tpm_read_log_acpi() to return successfully in this case.
> 
> Cc: stable at vger.kernel.org
> Fixes: 55a82ab3181b ("[PATCH] tpm: add bios measurement log")
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Already applied to my master (bleeding edge) branch in order to
facilitate testing:

git://git.infradead.org/users/jjs/linux-tpmdd.git

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
