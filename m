From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 25 Sep 2018 17:41:52 +0300
Subject: [PATCH v4 21/21] tpm: use u32 instead of int for PCR index
In-Reply-To: <20180921135820.20549-22-tomas.winkler@intel.com>
References: <20180921135820.20549-1-tomas.winkler@intel.com>
	<20180921135820.20549-22-tomas.winkler@intel.com>
Message-ID: <c08ed1def2ba28c3a44291b0652dd7f8830de1f4.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 2018-09-21 at 16:58 +0300, Tomas Winkler wrote:
> The TPM specs defines PCR index a positive number, there is
> no reason to use a signed number and it's also a possible security
> issue as currently no functions check for a negative index,
> which my into a large number when converted to u32.
> 
> Adjust the API to use u32 instead of int in all PCR related
> functions.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

I think I barked something about this in prev version but after giving
some thought. I think this a good change (more exact API).

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
