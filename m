From: jmorris@namei.org (James Morris)
Date: Wed, 19 Apr 2017 21:18:13 +1000 (AEST)
Subject: [PATCH] make TIOCSTI ioctl require CAP_SYS_ADMIN
In-Reply-To: <20170419034526.18565-1-matt@nmatt.com>
References: <20170419034526.18565-1-matt@nmatt.com>
Message-ID: <alpine.LRH.2.20.1704192114270.12914@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Tue, 18 Apr 2017, Matt Brown wrote:

> This patch reproduces GRKERNSEC_HARDEN_TTY functionality from the grsecurity
> project in-kernel.

It seems like an ugly hack to an ugly feature (CAP_SYS_ADMIN barely makes 
sense here), and rather than sprinkling these types of things throughout 
the kernel, I wonder if it might be better to implement it via LSM, in the 
YAMA module.



- James
-- 
James Morris
<jmorris@namei.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
