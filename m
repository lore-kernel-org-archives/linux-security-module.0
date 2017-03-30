From: jmorris@namei.org (James Morris)
Date: Thu, 30 Mar 2017 17:40:16 +1100 (AEDT)
Subject: [RESEND][PATCH] TOMOYO: Use designated initializers
In-Reply-To: <20170329235258.GA43176@beast>
References: <20170329235258.GA43176@beast>
Message-ID: <alpine.LRH.2.20.1703301739530.24110@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Wed, 29 Mar 2017, Kees Cook wrote:

> Prepare to mark sensitive kernel structures for randomization by making
> sure they're using designated initializers. These were identified during
> allyesconfig builds of x86, arm, and arm64, with most initializer fixes
> extracted from grsecurity.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next


-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
