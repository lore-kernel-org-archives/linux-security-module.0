From: penguin-kernel@I-love.SAKURA.ne.jp (Tetsuo Handa)
Date: Thu, 12 Apr 2018 23:18:22 +0900
Subject: [PATCH] security: Remove unused field from security_hook_list
In-Reply-To: <20180412022536.GA8919@ircssh-2.c.rugged-nimbus-611.internal>
References: <20180412022536.GA8919@ircssh-2.c.rugged-nimbus-611.internal>
Message-ID: <201804122318.GEE52615.HOJOFFQVLFOSMt@I-love.SAKURA.ne.jp>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Sargun Dhillon wrote:
> It appears like char * lsm on struct security_hook_list is unused. Even
> since its inception: https://patchwork.kernel.org/patch/9525051/
> it hasn't been read, only written to. This removes that.

It was preserved based on an assumption that complete stacking is accepted in
near future, but still not available. Maybe we can delete this field for now?
http://kernsec.org/pipermail/linux-security-module-archive/2017-March/000104.html
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
