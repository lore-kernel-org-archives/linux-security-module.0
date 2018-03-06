From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 06 Mar 2018 13:31:21 +0200
Subject: [PATCH 3/4] tmp: factor out tpm1_get_random into tpm1-cmd.c
In-Reply-To: <20180306093041.11996-4-tomas.winkler@intel.com>
References: <20180306093041.11996-1-tomas.winkler@intel.com>
	<20180306093041.11996-4-tomas.winkler@intel.com>
Message-ID: <1520335881.7549.9.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 2018-03-06 at 11:30 +0200, Tomas Winkler wrote:
> Factor out get random implementation from tpm-interface.c
> into tpm1_get_random function in tpm1-cmd.c.
> No functional changes.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

While you are doing this, please make it use tpm_buf so tha we get stuff
out of that nasty union. Using "helper" structs is still fine, just move
it right before the function implementation out of tpm.h (there are
examples of this tpm2-cmd.c).

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
