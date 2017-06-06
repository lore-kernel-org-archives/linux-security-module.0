From: davem@davemloft.net (David Miller)
Date: Tue, 06 Jun 2017 15:19:19 -0400 (EDT)
Subject: [PATCH] net/ipv6: Fix CALIPSO causing GPF with datagram support
In-Reply-To: <20170605154440.2434-1-richard_c_haines@btinternet.com>
References: <20170605154440.2434-1-richard_c_haines@btinternet.com>
Message-ID: <20170606.151919.50793178996552480.davem@davemloft.net>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

From: Richard Haines <richard_c_haines@btinternet.com>
Date: Mon,  5 Jun 2017 16:44:40 +0100

> When using CALIPSO with IPPROTO_UDP it is possible to trigger a GPF as the
> IP header may have moved.
> 
> Also update the payload length after adding the CALIPSO option.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Applied and queued up for -stable, thank you Richard.
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
