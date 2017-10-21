From: james.l.morris@oracle.com (James Morris)
Date: Sat, 21 Oct 2017 06:22:30 +0400 (+04)
Subject: [PATCH] [v2] tomoyo: fix timestamping for y2038
In-Reply-To: <20171019122919.1263808-1-arnd@arndb.de>
References: <20171019122919.1263808-1-arnd@arndb.de>
Message-ID: <alpine.LFD.2.20.1710210621580.22771@t440>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 19 Oct 2017, Arnd Bergmann wrote:

> Tomoyo uses an open-coded version of time_to_tm() to create a timestamp
> from the current time as read by get_seconds(). This will overflow and
> give wrong results on 32-bit systems in 2038.
> 
> To correct this, this changes the code to use ktime_get_real_seconds()
> and the generic time64_to_tm() function that are both y2038-safe.
> Using the library function avoids adding an expensive 64-bit division
> in this code and can benefit from any optimizations we do in common
> code.
> 
> Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: fix year calculation

Applied to:

git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
