From: jmorris@namei.org (James Morris)
Date: Tue, 30 May 2017 20:32:02 +1000 (AEST)
Subject: [PATCH v2] LSM: Convert security_hook_heads into explicit array
	of struct list_head
In-Reply-To: <1496003387-3184-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
References: <1495883858-3336-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
	<1496003387-3184-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <alpine.LRH.2.20.1705302025110.31018@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Mon, 29 May 2017, Tetsuo Handa wrote:

> Igor proposed a sealable memory allocator, and the LSM hooks
> ("struct security_hook_heads security_hook_heads" and
> "struct security_hook_list ...[]") will benefit from that allocator via
> protection using set_memory_ro()/set_memory_rw(), and that allocator
> will remove CONFIG_SECURITY_WRITABLE_HOOKS config option. Thus, we will
> likely be moving to that direction.
> 
> This means that these structures will be allocated at run time using
> that allocator, and therefore the address of these structures will be
> determined at run time rather than compile time.
> 
> But currently, LSM_HOOK_INIT() macro depends on the address of
> security_hook_heads being known at compile time. If we use an enum
> so that LSM_HOOK_INIT() macro does not need to know absolute address of
> security_hook_heads, it will help us to use that allocator for LSM hooks.
> 

This seems like pointless churn in security-critical code in anticipation 
of features which are still in development and may not be adopted.

Is there a compelling reason to merge this now? (And I don't mean worrying 
about non-existent compliers).



-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
