From: jmorris@namei.org (James Morris)
Date: Tue, 28 Mar 2017 11:21:27 +1100 (AEDT)
Subject: [PATCH] LSM: Revive security_task_alloc() hook and per "struct
	task_struct" security blob.
In-Reply-To: <1490355993-15773-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
References: <1490355993-15773-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <alpine.LRH.2.20.1703281120210.11654@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 24 Mar 2017, Tetsuo Handa wrote:

> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Acked-by: John Johansen <john.johansen@canonical.com>
> Acked-by: Serge Hallyn <serge@hallyn.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Tested-by: Djalal Harouni <tixxdz@gmail.com>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next

I also synced to a newer -rc (4) as requested.

Please test!


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
