From: jmorris@namei.org (James Morris)
Date: Tue, 25 Apr 2017 10:04:20 +1000 (AEST)
Subject: [GIT PULL] tpmdd fixes for 4.12
In-Reply-To: <20170424213710.qrc5za4tigjdqspi@intel.com>
References: <20170424213710.qrc5za4tigjdqspi@intel.com>
Message-ID: <alpine.LRH.2.20.1704251004100.8213@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 25 Apr 2017, Jarkko Sakkinen wrote:

> Hi
> 
> Here are fixes for the 4.12 release. In addition there is an update to
> the tpm_tis driver to use common callbacks for requesting and
> relinquishing locality as they were with locality support for tpm_crb.
> Now the logic flow for both driver is driven in tpm_transmit().
> 

pulled, thanks!

-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
