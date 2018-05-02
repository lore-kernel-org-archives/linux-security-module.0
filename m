From: jmorris@namei.org (James Morris)
Date: Thu, 3 May 2018 07:17:37 +1000 (AEST)
Subject: [PATCH v2 3/4] seccomp: Audit attempts to modify the
	actions_logged sysctl
In-Reply-To: <1525276400-7161-4-git-send-email-tyhicks@canonical.com>
References: <1525276400-7161-1-git-send-email-tyhicks@canonical.com>
	<1525276400-7161-4-git-send-email-tyhicks@canonical.com>
Message-ID: <alpine.LRH.2.21.1805030717090.30206@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 2 May 2018, Tyler Hicks wrote:

>  type=CONFIG_CHANGE msg=audit(1525275325.613:142): op=seccomp-logging
>  actions=kill_process,kill_thread,errno,trace,log
>  old-actions=kill_process,kill_thread,errno,trace,log res=1
> 
> No audit records are generated when reading the actions_logged sysctl.
> 
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> Signed-off-by: Tyler Hicks <tyhicks@canonical.com>


Reviewed-by: James Morris <james.morris@microsoft.com>

-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
