From: jmorris@namei.org (James Morris)
Date: Tue, 18 Jul 2017 18:09:12 +1000 (AEST)
Subject: [PATCH] LSM: Remove security_task_create() hook.
In-Reply-To: <1500028716-29328-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
References: <1500028716-29328-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <alpine.LRH.2.20.1707181808510.5209@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Fri, 14 Jul 2017, Tetsuo Handa wrote:

> Since commit a79be238600d1a03 ("selinux: Use task_alloc hook rather than
> task_create hook") changed to use task_alloc hook, task_create hook is
> no longer used.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next


Thanks!

-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
