From: jmorris@namei.org (James Morris)
Date: Fri, 25 Aug 2017 15:50:23 +1000 (AEST)
Subject: [PATCH V3 10/10] capabilities: audit log other surprising
	conditions
In-Reply-To: <11df9e69904600785a8a609f471ff30431ef5464.1503459890.git.rgb@redhat.com>
References: <cover.1503459890.git.rgb@redhat.com>
	<11df9e69904600785a8a609f471ff30431ef5464.1503459890.git.rgb@redhat.com>
Message-ID: <alpine.LRH.2.20.1708251550050.29541@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 23 Aug 2017, Richard Guy Briggs wrote:

> The existing condition tested for process effective capabilities set by file
> attributes but intended to ignore the change if the result was unsurprisingly an
> effective full set in the case root is special with a setuid root executable
> file and we are root.
> 
> Stated again:
> - When you execute a setuid root application, it is no surprise and expected
> that it got all capabilities, so we do not want capabilities recorded.
>         if (pE_grew && !(pE_fullset && (eff_root || real_root) && root_priveleged) )
> 
> Now make sure we cover other cases:
> - If something prevented a setuid root app getting all capabilities and it
> wound up with one capability only, then it is a surprise and should be logged.
> When it is a setuid root file, we only want capabilities when the process does
> not get full capabilities..
>         root_priveleged && setuid_root && !pE_fullset
> 
> - Similarly if a non-setuid program does pick up capabilities due to file system
> based capabilities, then we want to know what capabilities were picked up.
> When it has file system based capabilities we want the capabilities.
>         !is_setuid && (has_fcap && pP_gained)
> 
> - If it is a non-setuid file and it gets ambient capabilities, we want the
> capabilities.
>         !is_setuid && pA_gained
> 
> - These last two are combined into one due to the common first parameter.
> 
> Related: https://github.com/linux-audit/audit-kernel/issues/16
> 
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>


Acked-by: James Morris <james.l.morris@oracle.com>

-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
