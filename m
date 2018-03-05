From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Mon, 5 Mar 2018 19:51:29 +0200
Subject: [PATCH v7] tpm: cmd_ready command can be issued only after
	granting locality
In-Reply-To: <20180305113449.8876-1-tomas.winkler@intel.com>
References: <20180305113449.8876-1-tomas.winkler@intel.com>
Message-ID: <20180305175128.GB5791@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, Mar 05, 2018 at 01:34:49PM +0200, Tomas Winkler wrote:
> The correct sequence is to first request locality and only after
> that perform cmd_ready handshake, otherwise the hardware will drop
> the subsequent message as from the device point of view the cmd_ready
> handshake wasn't performed. Symmetrically locality has to be relinquished
> only after going idle handshake has completed, this requires that
> go_idle has to poll for the completion and as well locality
> relinquish has to poll for completion so it is not overridden
> in back to back commands flow.
> 
> Two wrapper functions are added (request_locality relinquish_locality)
> to simplify the error handling.
> 
> The issue is only visible on devices that support multiple localities.
> 
> Fixes: 877c57d0d0ca ("tpm_crb: request and relinquish locality 0")
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Tested-by: Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
