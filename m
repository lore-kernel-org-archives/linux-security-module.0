From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Tue, 23 Jan 2018 15:08:41 +0200
Subject: [PATCH 2/3] tpm: separate cmd_ready/go_idle from runtime_pm
In-Reply-To: <20180123112731.3687-2-tomas.winkler@intel.com>
References: <20180123112731.3687-1-tomas.winkler@intel.com>
	<20180123112731.3687-2-tomas.winkler@intel.com>
Message-ID: <20180123130841.ub2amxalgr2oapu6@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, Jan 23, 2018 at 01:27:30PM +0200, Tomas Winkler wrote:
> We cannot use go_idle cmd_ready commands via runtime_pm handles
> as with the introduction of localities this is no longer an optional
> feature, while runtime pm can be not enabled.
> Though cmd_ready/go_idle provides power saving feature, it's also part of
> TPM2 protocol and should be called explicitly.
> This patch exposes cmd_read/go_idle via tpm class ops and removes
> runtime pm support as it is not used by any driver.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Thank you.

LGTM

Jason, what do you think?

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
