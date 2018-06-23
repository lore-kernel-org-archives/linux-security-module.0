From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Sat, 23 Jun 2018 22:26:27 +0100
Subject: [PATCH] ipv6: avoid copy_from_user() via ipv6_renew_options_kern()
In-Reply-To: <20180623.105706.385733107379565893.davem@davemloft.net>
References: <152970230022.7734.15824980755229329454.stgit@chester>
	<20180623.105706.385733107379565893.davem@davemloft.net>
Message-ID: <20180623212626.GD30522@ZenIV.linux.org.uk>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sat, Jun 23, 2018 at 10:57:06AM +0900, David Miller wrote:
> From: Paul Moore <pmoore@redhat.com>
> Date: Fri, 22 Jun 2018 17:18:20 -0400
> 
> > -	const mm_segment_t old_fs = get_fs();
> > -
> > -	set_fs(KERNEL_DS);
> > -	ret_val = ipv6_renew_options(sk, opt, newtype,
> > -				     (struct ipv6_opt_hdr __user *)newopt,
> > -				     newoptlen);
> > -	set_fs(old_fs);
> 
> So is it really the case that the traditional construct:
> 
> 	set_fs(KERNEL_DS);
> 	... copy_{from,to}_user(...);
> 	set_fs(old_fs);
> 
> is no longer allowed?

s/no longer allowed/best avoided/, but IMO in this case the replacement is
too ugly to live ;-/
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
