From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Thu, 8 Mar 2018 12:53:14 -0800
Subject: [PATCH] net: don't unnecessarily load kernel modules in
	dev_ioctl()
In-Reply-To: <20180308.131115.611191617522587758.davem@davemloft.net>
References: <20180306155920.7b6379ac@xeon-e3>
	<20180308.123440.2224695014753871221.davem@davemloft.net>
	<c2d378b6-80b3-d9e1-7087-95f143875067@gmail.com>
	<20180308.131115.611191617522587758.davem@davemloft.net>
Message-ID: <b5ef30d9-5723-5f92-0f7b-b8d4da9a777a@gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org



On 03/08/2018 10:11 AM, David Miller wrote:

> Yeah, understood.  At small scale the current behavior maybe made
> sense, but these days it really doesn't.
> 
> No objections to the knob if you want to submit it.
> 

Thanks David, I have rebased my patch and sent it.

New numbers on net-next are looking very nice, thanks to Kirill work.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
