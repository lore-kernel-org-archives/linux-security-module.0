From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 06 Mar 2018 14:17:02 +0200
Subject: [PATCH 0/5 V2] tpm: timeouts revamp
In-Reply-To: <20180306092503.11568-1-tomas.winkler@intel.com>
References: <20180306092503.11568-1-tomas.winkler@intel.com>
Message-ID: <1520338622.3779.1.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-03-06 at 11:24 +0200, Tomas Winkler wrote:
> This series cleans up tpm timeouts setting and handling.
> 
> First motivation was to fix failures coming from too short timeouts
> for commands that creates keys.
> Key generation may take significant time depending on the underlying
> hardware. Rather than increasing default timeout a new constant is
> added, to not stall too long on regular commands failures.
> 
> Second is to define timeouts for new tpm2 commands
> defined in TCG 1.36 spec.

Where can we get that specification? I don't have that new
version and couldn't find it from the public internet.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
