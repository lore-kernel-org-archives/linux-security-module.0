From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Thu, 15 Mar 2018 18:29:48 +0200
Subject: [PATCH v2 2/8] tpm: move tpm_getcap to tpm1-cmd.c
In-Reply-To: <20180310082428.31519-3-tomas.winkler@intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
	<20180310082428.31519-3-tomas.winkler@intel.com>
Message-ID: <3f6082da29c0f779faed7a14f068b601c87d92c6.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, 2018-03-10 at 10:24 +0200, Tomas Winkler wrote:
> 1. Move tpm_getcap to tpm1-cmd. Rename the function to tpm1_getcap.
> 2. Remove unused tpm_getcap_header with unused constant
> as this functionality is already implemented using tpm_buf construct.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
