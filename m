From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 19 Sep 2018 17:56:55 +0300
Subject: [PATCH v3 08/20] tpm: factor out tpm1_get_random into tpm1-cmd.c
In-Reply-To: <20180918093459.19165-9-tomas.winkler@intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
	<20180918093459.19165-9-tomas.winkler@intel.com>
Message-ID: <20180919145655.GA31076@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 18, 2018 at 12:34:47PM +0300, Tomas Winkler wrote:
> Factor out get random implementation from tpm-interface.c
> into tpm1_get_random function in tpm1-cmd.c.
> No functional changes.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Reviewed-by: Jarkko Sakkine <jarkko.sakkinen@linux.intel.com>

/Jarkko
