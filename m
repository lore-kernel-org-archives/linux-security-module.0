From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 19 Sep 2018 17:04:25 +0300
Subject: [PATCH v3 05/20] tpm: factor out tpm_get_timeouts
In-Reply-To: <20180918093459.19165-6-tomas.winkler@intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
	<20180918093459.19165-6-tomas.winkler@intel.com>
Message-ID: <20180919140425.GH26571@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 18, 2018 at 12:34:44PM +0300, Tomas Winkler wrote:
> Factor out tpm_get_timeouts into tpm2_get_timeouts
> and tpm1_get_timeouts.

Function names missing parentheses. Should be there for clarity when
used in a sentence. Otherwise, the commit looks fine.

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
