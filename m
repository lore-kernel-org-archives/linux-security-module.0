From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Mon, 26 Mar 2018 23:09:36 +0300
Subject: [PATCH V4] tpm: separate cmd_ready/go_idle from runtime_pm
In-Reply-To: <20180324183935.20784-1-tomas.winkler@intel.com>
References: <20180324183935.20784-1-tomas.winkler@intel.com>
Message-ID: <20180326200936.GA3810@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Mar 24, 2018 at 09:39:35PM +0300, Tomas Winkler wrote:
> From: "Winkler, Tomas" <tomas.winkler@intel.com>
> 
> We cannot use go_idle cmd_ready commands via runtime_pm handles
> as with the introduction of localities this is no longer an optional
> feature, while runtime pm can be not enabled.
> Though cmd_ready/go_idle provides power saving feature, it's also part of
> TPM2 protocol and should be called explicitly.
> This patch exposes cmd_read/go_idle via tpm class ops and removes
> runtime pm support as it is not used by any driver.
> 
> tpm_crb no longer needs own power saving functions and can drop using
> tpm_pm_suspend/resume.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Still fails on Kabylake exactly the same way. With this I get
RC_UNBALANCED in these four test cases:

test_flush_context (tpm2_smoke.SpaceTest) ... ERROR
test_get_handles (tpm2_smoke.SpaceTest) ... ERROR
test_make_two_spaces (tpm2_smoke.SpaceTest) ... ERROR

Without this patch applied these errors do not occur.

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
