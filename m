From: jmorris@namei.org (James Morris)
Date: Thu, 3 May 2018 07:11:36 +1000 (AEST)
Subject: [PATCH v2 2/4] seccomp: Configurable separator for the
	actions_logged string
In-Reply-To: <1525276400-7161-3-git-send-email-tyhicks@canonical.com>
References: <1525276400-7161-1-git-send-email-tyhicks@canonical.com>
	<1525276400-7161-3-git-send-email-tyhicks@canonical.com>
Message-ID: <alpine.LRH.2.21.1805030711200.30206@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 2 May 2018, Tyler Hicks wrote:

> The function that converts a bitmask of seccomp actions that are
> allowed to be logged is currently only used for constructing the display
> string for the kernel.seccomp.actions_logged sysctl. That string wants a
> space character to be used for the separator between actions.
> 
> A future patch will make use of the same function for building a string
> that will be sent to the audit subsystem for tracking modifications to
> the kernel.seccomp.actions_logged sysctl. That string will need to use a
> comma as a separator. This patch allows the separator character to be
> configurable to meet both needs.
> 
> Signed-off-by: Tyler Hicks <tyhicks@canonical.com>


Reviewed-by: James Morris <james.morris@microsoft.com>


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
