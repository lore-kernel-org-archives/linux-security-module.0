From: jmorris@namei.org (James Morris)
Date: Fri, 24 Mar 2017 14:54:49 +1100 (AEDT)
Subject: [PATCH 1/2] LSM: Initialize security_hook_heads upon registration.
In-Reply-To: <1490179580-7065-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
References: <1490179580-7065-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <alpine.LRH.2.20.1703241453530.26984@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 22 Mar 2017, Tetsuo Handa wrote:

> "struct security_hook_heads" is an array of "struct list_head"
> where elements can be initialized just before registration.
> 
> We might introduce different "struct security_hook_heads" for built-in
> LSM modules and dynamically loadable LSM modules when we start allowing
> dynamically loadable LSM modules. But even if we decide to use different
> lists, there is no need to waste 350+ lines for initialization. Let's
> initialize "struct security_hook_heads" just before registration.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Nice cleanup, applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next

with edited changelog.


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
