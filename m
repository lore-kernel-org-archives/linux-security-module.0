From: davem@davemloft.net (David Miller)
Date: Sun, 24 Jun 2018 16:48:37 +0900 (KST)
Subject: [PATCH] ipv6: avoid copy_from_user() via ipv6_renew_options_kern()
In-Reply-To: <20180623222106.GE30522@ZenIV.linux.org.uk>
References: <20180623.105706.385733107379565893.davem@davemloft.net>
	<20180623212626.GD30522@ZenIV.linux.org.uk>
	<20180623222106.GE30522@ZenIV.linux.org.uk>
Message-ID: <20180624.164837.37612664745856114.davem@davemloft.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Sat, 23 Jun 2018 23:21:07 +0100

> BTW, I wonder if the life would be simpler with do_ipv6_setsockopt() doing
> the copy-in and verifying ipv6_optlen(*hdr) <= newoptlen; that would've
> simplified ipv6_renew_option{,s}() quite a bit and completely eliminated
> ipv6_renew_options_kern()...

I agree that this makes things a lot simpler.

One thing that drives me crazy though is this inherit stuff:

> +	ipv6_renew_option(newtype == IPV6_HOPOPTS ? newopt :
> +				opt ? opt->hopopt : NULL,

Why don't we pass the type into ipv6_renew_option() and have it
do this pointer dance instead?

That's going to definitely be easier to read.

I don't know enough about this code to give feedback about the
option length handling wrt. copies, sorry.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
