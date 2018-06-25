From: paul@paul-moore.com (Paul Moore)
Date: Mon, 25 Jun 2018 10:49:07 -0400
Subject: [PATCH] ipv6: avoid copy_from_user() via ipv6_renew_options_kern()
In-Reply-To: <20180624.164837.37612664745856114.davem@davemloft.net>
References: <20180623.105706.385733107379565893.davem@davemloft.net>
	<20180623212626.GD30522@ZenIV.linux.org.uk>
	<20180623222106.GE30522@ZenIV.linux.org.uk>
	<20180624.164837.37612664745856114.davem@davemloft.net>
Message-ID: <CAHC9VhTS1_GxegDvktFriZTBEPzSQYHNWwa6RDB3HU9NJL9MRA@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On Sun, Jun 24, 2018 at 3:48 AM David Miller <davem@davemloft.net> wrote:
>
> From: Al Viro <viro@ZenIV.linux.org.uk>
> Date: Sat, 23 Jun 2018 23:21:07 +0100
>
> > BTW, I wonder if the life would be simpler with do_ipv6_setsockopt() doing
> > the copy-in and verifying ipv6_optlen(*hdr) <= newoptlen; that would've
> > simplified ipv6_renew_option{,s}() quite a bit and completely eliminated
> > ipv6_renew_options_kern()...
>
> I agree that this makes things a lot simpler.

I had looked at moving the userspace copy up, but feared it was a bit
too invasive.  It sounds like you are open to the idea so I'll code
something up.

> One thing that drives me crazy though is this inherit stuff:
>
> > +     ipv6_renew_option(newtype == IPV6_HOPOPTS ? newopt :
> > +                             opt ? opt->hopopt : NULL,
>
> Why don't we pass the type into ipv6_renew_option() and have it
> do this pointer dance instead?
>
> That's going to definitely be easier to read.

I agree, that struck me as a little odd.  I'll rework that too.  I'll
send you guys something this week to take a look at.

Thanks.

> I don't know enough about this code to give feedback about the
> option length handling wrt. copies, sorry.

-- 
paul moore
www.paul-moore.com
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
