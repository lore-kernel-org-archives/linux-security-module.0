From: davem@davemloft.net (David Miller)
Date: Sat, 23 Jun 2018 10:57:06 +0900 (KST)
Subject: [PATCH] ipv6: avoid copy_from_user() via ipv6_renew_options_kern()
In-Reply-To: <152970230022.7734.15824980755229329454.stgit@chester>
References: <152970230022.7734.15824980755229329454.stgit@chester>
Message-ID: <20180623.105706.385733107379565893.davem@davemloft.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Paul Moore <pmoore@redhat.com>
Date: Fri, 22 Jun 2018 17:18:20 -0400

> -	const mm_segment_t old_fs = get_fs();
> -
> -	set_fs(KERNEL_DS);
> -	ret_val = ipv6_renew_options(sk, opt, newtype,
> -				     (struct ipv6_opt_hdr __user *)newopt,
> -				     newoptlen);
> -	set_fs(old_fs);

So is it really the case that the traditional construct:

	set_fs(KERNEL_DS);
	... copy_{from,to}_user(...);
	set_fs(old_fs);

is no longer allowed?

Setting fs to KERNEL_DS is supposed to make user copies work on kernel
memory.  Or at least it did for 20+ years :-)
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
