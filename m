From: davem@davemloft.net (David Miller)
Date: Thu, 05 Jul 2018 20:15:51 +0900 (KST)
Subject: [RFC PATCH v3] ipv6: make ipv6_renew_options()
	interrupt/kernel safe
In-Reply-To: <153071268532.4174.13831205890855497876.stgit@chester>
References: <153071268532.4174.13831205890855497876.stgit@chester>
Message-ID: <20180705.201551.1158772045763837695.davem@davemloft.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Paul Moore <pmoore@redhat.com>
Date: Wed, 04 Jul 2018 09:58:05 -0400

> From: Paul Moore <paul@paul-moore.com>
> 
> At present the ipv6_renew_options_kern() function ends up calling into
> access_ok() which is problematic if done from inside an interrupt as
> access_ok() calls WARN_ON_IN_IRQ() on some (all?) architectures
> (x86-64 is affected).  Example warning/backtrace is shown below:
> 
>  WARNING: CPU: 1 PID: 3144 at lib/usercopy.c:11 _copy_from_user+0x85/0x90
 ...
> While not present in the backtrace, ipv6_renew_option() ends up calling
> access_ok() via the following chain:
> 
>   access_ok()
>   _copy_from_user()
>   copy_from_user()
>   ipv6_renew_option()
> 
> The fix presented in this patch is to perform the userspace copy
> earlier in the call chain such that it is only called when the option
> data is actually coming from userspace; that place is
> do_ipv6_setsockopt().  Not only does this solve the problem seen in
> the backtrace above, it also allows us to simplify the code quite a
> bit by removing ipv6_renew_options_kern() completely.  We also take
> this opportunity to cleanup ipv6_renew_options()/ipv6_renew_option()
> a small amount as well.
> 
> This patch is heavily based on a rough patch by Al Viro.  I've taken
> his original patch, converted a kmemdup() call in do_ipv6_setsockopt()
> to a memdup_user() call, made better use of the e_inval jump target in
> the same function, and cleaned up the use ipv6_renew_option() by
> ipv6_renew_options().
> 
> CC: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

This looks good to me, applied to 'net'.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
