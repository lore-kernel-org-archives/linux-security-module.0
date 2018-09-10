From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Mon, 10 Sep 2018 21:46:08 +0300
Subject: [PATCH v6 2/2] tpm: add support for nonblocking operation
In-Reply-To: <153659991327.2284.12202285045326223123.stgit@tstruk-mobl1.jf.intel.com>
References: <153659990230.2284.5511495299744743989.stgit@tstruk-mobl1.jf.intel.com>
	<153659991327.2284.12202285045326223123.stgit@tstruk-mobl1.jf.intel.com>
Message-ID: <20180910184608.GE20225@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Sep 10, 2018 at 10:18:33AM -0700, Tadeusz Struk wrote:
> Currently the TPM driver only supports blocking calls, which doesn't allow
> asynchronous IO operations to the TPM hardware.
> This patch changes it and adds support for nonblocking write and a new poll
> function to enable applications, which want to take advantage of this.
> 
> Tested-by: Philip Tricca <philip.b.tricca@intel.com>
> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.om>

/Jarkko
