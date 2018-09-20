From: cgzones@googlemail.com (=?UTF-8?Q?Christian_G=C3=B6ttsche?=)
Date: Thu, 20 Sep 2018 09:18:56 +0200
Subject: [PATCH] netfilter: nf_tables: add SECMARK support
In-Reply-To: <75b3fed9-e549-4ed0-c435-ec4795fc1e39@schaufler-ca.com>
References: <20180919231402.4482-1-cgzones@googlemail.com>
	<75b3fed9-e549-4ed0-c435-ec4795fc1e39@schaufler-ca.com>
Message-ID: <CAJ2a_Ddd19txwUiKkOwpdWUSq9+VWFSR6Cqe4zgXKggWUPi4hw@mail.gmail.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

> I've only had a cursory look at your patch, but how is it
> different from what's in xt_SECMARK.c ?

xt_SEXMARK.c is for xtables, use-able in iptables; this is for nftables (nft)
