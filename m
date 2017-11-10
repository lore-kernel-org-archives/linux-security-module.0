From: james.l.morris@oracle.com (James Morris)
Date: Fri, 10 Nov 2017 13:56:18 +1100 (AEDT)
Subject: [PATCH RFC v3 6/7] proc: support new 'pids=all|ptraceable' mount
	option
In-Reply-To: <1510244046-3256-7-git-send-email-tixxdz@gmail.com>
References: <1510244046-3256-1-git-send-email-tixxdz@gmail.com>
	<1510244046-3256-7-git-send-email-tixxdz@gmail.com>
Message-ID: <alpine.LFD.2.20.1711101356010.8844@localhost>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Thu, 9 Nov 2017, Djalal Harouni wrote:

> This patch introduces the new 'pids' mount option, as it was discussed
> and suggested by Andy Lutomirski [1].
> 
> * If 'pids=' is passed without 'newinstance' then it has no effect.
> 
> * If 'newinstance,pids=all' then all processes will be shown in proc.
> 
> * If 'newinstance,pids=ptraceable' then only ptraceable processes will be
> shown.
> 
> * 'pids=' takes precendence over 'hidepid=' since 'hidepid=' can be
>   ignored if "gid=" was set and caller has the "gid=" set in its groups.
>   We want to guarantee that LSM have a security path there that can not
>   be disabled with "gid=".
> 
> This allows to support lightweight sandboxes in Embedded Linux.
> 
> Later Yama LSM can be updated to check that processes are able only
> able to see their children inside /proc/, allowing to support more tight
> cases.
> 
> [1] https://lkml.org/lkml/2017/4/26/646
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
