From: jmorris@namei.org (James Morris)
Date: Thu, 3 May 2018 07:01:55 +1000 (AEST)
Subject: [PATCH v2 1/4] seccomp: Separate read and write code for
	actions_logged sysctl
In-Reply-To: <1525276400-7161-2-git-send-email-tyhicks@canonical.com>
References: <1525276400-7161-1-git-send-email-tyhicks@canonical.com>
	<1525276400-7161-2-git-send-email-tyhicks@canonical.com>
Message-ID: <alpine.LRH.2.21.1805030701220.30206@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 2 May 2018, Tyler Hicks wrote:

> Break the read and write paths of the kernel.seccomp.actions_logged
> sysctl into separate functions to maintain readability. An upcoming
> change will need to audit writes, but not reads, of this sysctl which
> would introduce too many conditional code paths on whether or not the
> 'write' parameter evaluates to true.
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
