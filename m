From: jmorris@namei.org (James Morris)
Date: Wed, 1 Aug 2018 06:08:59 +1000 (AEST)
Subject: [PATCH v2] security: Add LSM fixup hooks to set*gid syscalls.
In-Reply-To: <CAJ-EccNNCNrA7to85WrYFjRUP7Z1XC+sJ2JXkargiEvXd11AVg@mail.gmail.com>
References: <CAJ-EccNNCNrA7to85WrYFjRUP7Z1XC+sJ2JXkargiEvXd11AVg@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1808010608080.8072@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 31 Jul 2018, Micah Morton wrote:

> +static inline int security_task_fix_setgid(struct cred *new,
> +    const struct cred *old,
> +    int flags)
> +{
> + return 0;
> +}
> +

This looks whitespace-damaged.  Please send patches as plain text.


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
