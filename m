From: davem@davemloft.net (David Miller)
Date: Thu, 19 Oct 2017 12:00:37 +0100 (WEST)
Subject: [PATCH net-next v6 0/5] bpf: security: New file mode and LSM
	hooks for eBPF object permission control
In-Reply-To: <alpine.LFD.2.20.1710191248100.1108@t440.gateway.2wire.net>
References: <20171016191135.8046-1-chenbofeng.kernel@gmail.com>
	<20171018.134729.837318478487425125.davem@davemloft.net>
	<alpine.LFD.2.20.1710191248100.1108@t440.gateway.2wire.net>
Message-ID: <20171019.120037.800835994706244516.davem@davemloft.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: James Morris <james.l.morris@oracle.com>
Date: Thu, 19 Oct 2017 12:49:59 +1100 (AEDT)

> On Wed, 18 Oct 2017, David Miller wrote:
> 
>> Series applied.
> 
> I hadn't gotten to reviewing this patchset yet.
> 
> Please wait for more acks/reviews from LSM folk for things touching 
> security/, next time.

Well it got reverted and respun in order to deal with build failures.
So you have some time.

However...

Please review the changes more expediantly.  I don't like paches
rotting in my backlog for more than a day or two, weekends not
withstanding.  So if I don't see anything after two work week days,
I'll use my best judgment and apply if I can't find a major flaw in
the change(s).
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
