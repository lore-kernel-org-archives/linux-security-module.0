From: matt@nmatt.com (Matt Brown)
Date: Wed, 19 Apr 2017 20:08:02 -0400
Subject: [PATCH] make TIOCSTI ioctl require CAP_SYS_ADMIN
In-Reply-To: <alpine.LRH.2.20.1704192114270.12914@namei.org>
References: <20170419034526.18565-1-matt@nmatt.com>
	<alpine.LRH.2.20.1704192114270.12914@namei.org>
Message-ID: <4a7ab5c3-590e-891f-61ce-534483dc2ec6@nmatt.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 04/19/2017 07:18 AM, James Morris wrote:
> On Tue, 18 Apr 2017, Matt Brown wrote:
>
>> This patch reproduces GRKERNSEC_HARDEN_TTY functionality from the grsecurity
>> project in-kernel.
>
> It seems like an ugly hack to an ugly feature (CAP_SYS_ADMIN barely makes
> sense here), and rather than sprinkling these types of things throughout
> the kernel, I wonder if it might be better to implement it via LSM, in the
> YAMA module.
>
>

CAP_SYS_ADMIN is already used in the TIOCSTI TTY code to allow
character insertion into TTYs other than the caller's controlling
terminal. This is done because different TTYs indicate a security
boundary that should only be able to be crossed by a privileged
process. This patch would merely extend this security boundary
protection to include unprivileged processes from utilizing a common
TTY to step across a security boundary.

>
> - James
>
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
