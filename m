From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Mon, 5 Mar 2018 15:02:15 +0200
Subject: [PATCH 2/3] tpm: add new tpm2 commands according to TCG 1.36
In-Reply-To: <20180304121205.16934-2-tomas.winkler@intel.com>
References: <20180304121205.16934-1-tomas.winkler@intel.com>
	<20180304121205.16934-2-tomas.winkler@intel.com>
Message-ID: <20180305130136.GB3425@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Mar 04, 2018 at 02:12:04PM +0200, Tomas Winkler wrote:
> 1. TPM2_CC_LAST has moved from 182 to 193
> 2. Convert tpm2_ordinal_duration from an array into a switch statement,
>    as there are not so many commands that require special duration
>    relative to a number of commands.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

My previous suggestion applies here.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
