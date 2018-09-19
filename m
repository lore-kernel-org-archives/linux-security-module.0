From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Wed, 19 Sep 2018 17:58:51 +0300
Subject: [PATCH v3 12/20] tpm: move pcr extend code to tpm2-cmd.c
In-Reply-To: <20180918093459.19165-13-tomas.winkler@intel.com>
References: <20180918093459.19165-1-tomas.winkler@intel.com>
	<20180918093459.19165-13-tomas.winkler@intel.com>
Message-ID: <20180919145851.GB31076@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Sep 18, 2018 at 12:34:51PM +0300, Tomas Winkler wrote:
> Add tpm2_pcr_extend() function to tpm2-cmd.c with signature required
> by tpm-interface.c. It wraps the original open code
> implementation. The original original tpm2_pcr_extend() function
> is renamed and made static, called only from new tpm2_pcr_extend()
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

The change is OK. The last sentence in the commit message needs to
be fixed.


/Jarkko
