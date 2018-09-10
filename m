From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Mon, 10 Sep 2018 21:44:16 +0300
Subject: [PATCH v6 1/2] tpm: add ptr to the tpm_space struct to file_priv
In-Reply-To: <153659990801.2284.8342428711970626698.stgit@tstruk-mobl1.jf.intel.com>
References: <153659990230.2284.5511495299744743989.stgit@tstruk-mobl1.jf.intel.com>
	<153659990801.2284.8342428711970626698.stgit@tstruk-mobl1.jf.intel.com>
Message-ID: <20180910184416.GD20225@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Sep 10, 2018 at 10:18:28AM -0700, Tadeusz Struk wrote:
> Add a ptr to struct tpm_space to the file_priv and consolidate
> of the write operations for the two interfaces.
> 
> Tested-by: Philip Tricca <philip.b.tricca@intel.com>
> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.om>

/Jarkko
