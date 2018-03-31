From: jmorris@namei.org (James Morris)
Date: Sat, 31 Mar 2018 13:30:20 +1100 (AEDT)
Subject: [PATCH v3] security: convert security hooks to use hlist
In-Reply-To: <20180329012820.GA7901@ircssh-2.c.rugged-nimbus-611.internal>
References: <20180329012820.GA7901@ircssh-2.c.rugged-nimbus-611.internal>
Message-ID: <alpine.LRH.2.21.1803311329370.27572@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 29 Mar 2018, Sargun Dhillon wrote:

> This changes security_hook_heads to use hlist_heads instead of
> the circular doubly-linked list heads. This should cut down
> the size of the struct by about half.
> 
> In addition, it allows mutation of the hooks at the tail of the
> callback list without having to modify the head. The longer-term
> purpose of this is to enable making the heads read only.
> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> Reviewed-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>

Thanks.

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general
and next-testing


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
