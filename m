From: davem@davemloft.net (David Miller)
Date: Thu, 08 Mar 2018 12:34:40 -0500 (EST)
Subject: [PATCH] net: don't unnecessarily load kernel modules in
	dev_ioctl()
In-Reply-To: <20180306155920.7b6379ac@xeon-e3>
References: <152037526427.18953.14013300464173153064.stgit@chester>
	<20180306155920.7b6379ac@xeon-e3>
Message-ID: <20180308.123440.2224695014753871221.davem@davemloft.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Stephen Hemminger <stephen@networkplumber.org>
Date: Tue, 6 Mar 2018 15:59:20 -0800

> Actually dev_load by ethernet name is really a legacy thing that
> should just die,
> 
> It was kept around so that some very tunnel configuration using special names.
> 
> 	# ifconfig sit0
> 
> which probably several web pages still tell users to do...
> We have much better control now with ip commands so that this is just
> baggage.

As you say, some people use this stuff, so we really can't break
it at this point.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
