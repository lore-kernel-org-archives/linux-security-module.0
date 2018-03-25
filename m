From: jmorris@namei.org (James Morris)
Date: Mon, 26 Mar 2018 08:25:34 +1100 (AEDT)
Subject: [PATCH] security: convert security hooks to use hlist
In-Reply-To: <6f9d93bdf8122230ea53823a07a9d79f0c3fdafe.1521972503.git.sargun@sargun.me>
References: <6f9d93bdf8122230ea53823a07a9d79f0c3fdafe.1521972503.git.sargun@sargun.me>
Message-ID: <alpine.LRH.2.21.1803260824560.324@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, 25 Mar 2018, Sargun Dhillon wrote:

> This changes security_hook_heads to use hlist_heads instead of
> the circular doubly-linked list heads. This should cut down
> the size of the struct by about half.

Can you please measure it?


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
