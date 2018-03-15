From: jarkko.sakkinen@linux.intel.com (Jarkko Sakkinen)
Date: Thu, 15 Mar 2018 18:40:49 +0200
Subject: [PATCH v2 5/8] tpm: factor out tpm1 pm suspend flow into
	tpm1-cmd.c
In-Reply-To: <20180310082428.31519-6-tomas.winkler@intel.com>
References: <20180310082428.31519-1-tomas.winkler@intel.com>
	<20180310082428.31519-6-tomas.winkler@intel.com>
Message-ID: <67805a53fd3471c70a9f29daa430d85d4879a23a.camel@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, 2018-03-10 at 10:24 +0200, Tomas Winkler wrote:
> Factor out tpm1 suspend flow from tpm-interface.c into a new function
> tpm1_pm_suspend in tpm1-cmd.c
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
