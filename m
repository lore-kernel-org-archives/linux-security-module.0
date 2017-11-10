From: james.l.morris@oracle.com (James Morris)
Date: Fri, 10 Nov 2017 13:53:25 +1100 (AEDT)
Subject: [PATCH RFC v3 4/7] proc: support mounting private procfs instances
	inside same pid namespace
In-Reply-To: <1510244046-3256-5-git-send-email-tixxdz@gmail.com>
References: <1510244046-3256-1-git-send-email-tixxdz@gmail.com>
	<1510244046-3256-5-git-send-email-tixxdz@gmail.com>
Message-ID: <alpine.LFD.2.20.1711101352580.8844@localhost>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 9 Nov 2017, Djalal Harouni wrote:

> This should allow later after real testing to have a smooth transition
> to a procfs with default private instances.
> 
> [1] https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2017-January/004215.html
> [2] http://www.openwall.com/lists/kernel-hardening/2017/10/05/5
> [3] https://lwn.net/Articles/689539/
> [4] http://lxr.free-electrons.com/source/Documentation/filesystems/devpts.txt?v=3.14
> [5] https://lkml.org/lkml/2017/5/2/407
> [6] https://lkml.org/lkml/2017/5/3/357
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
> Signed-off-by: Djalal Harouni <tixxdz@gmail.com>


Reviewed-by: James Morris <james.l.morris@oracle.com>


-- 
James Morris
<james.l.morris@oracle.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
