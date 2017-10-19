From: daniel@iogearbox.net (Daniel Borkmann)
Date: Thu, 19 Oct 2017 11:48:33 +0200
Subject: [PATCH net-next v6 0/5] bpf: security: New file mode and LSM
	hooks for eBPF object permission control
In-Reply-To: <alpine.LFD.2.20.1710191248100.1108@t440.gateway.2wire.net>
References: <20171016191135.8046-1-chenbofeng.kernel@gmail.com>
	<20171018.134729.837318478487425125.davem@davemloft.net>
	<alpine.LFD.2.20.1710191248100.1108@t440.gateway.2wire.net>
Message-ID: <59E874F1.6040609@iogearbox.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 10/19/2017 03:49 AM, James Morris wrote:
> On Wed, 18 Oct 2017, David Miller wrote:
>
>> Series applied.
>
> I hadn't gotten to reviewing this patchset yet.
>
> Please wait for more acks/reviews from LSM folk for things touching
> security/, next time.

It didn't get applied yet due to a build error, v7 is pending here
if you want to take a look (the series is already on the lists with
multiple feedback rounds since beginning of Oct):

   http://patchwork.ozlabs.org/project/netdev/list/?series=8967

Thanks,
Daniel
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
