From: jmorris@namei.org (James Morris)
Date: Sat, 11 Mar 2017 12:05:30 +1100 (AEDT)
Subject: [PATCH] fs: switch order of CAP_DAC_OVERRIDE and
	CAP_DAC_READ_SEARCH checks
In-Reply-To: <1489166058-11789-1-git-send-email-sds@tycho.nsa.gov>
References: <1489166058-11789-1-git-send-email-sds@tycho.nsa.gov>
Message-ID: <alpine.LRH.2.20.1703111205200.20298@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 10 Mar 2017, Stephen Smalley wrote:

> generic_permission() presently checks CAP_DAC_OVERRIDE prior to
> CAP_DAC_READ_SEARCH.  This can cause misleading audit messages when
> using a LSM such as SELinux or AppArmor, since CAP_DAC_OVERRIDE
> may not be required for the operation.  Flip the order of the
> tests so that CAP_DAC_OVERRIDE is only checked when required for
> the operation.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>


Acked-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
