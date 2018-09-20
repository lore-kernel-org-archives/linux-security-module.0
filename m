From: casey@schaufler-ca.com (Casey Schaufler)
Date: Thu, 20 Sep 2018 08:23:30 -0700
Subject: [PATCH] netfilter: nf_tables: add SECMARK support
In-Reply-To: <CAJ2a_Ddd19txwUiKkOwpdWUSq9+VWFSR6Cqe4zgXKggWUPi4hw@mail.gmail.com>
References: <20180919231402.4482-1-cgzones@googlemail.com>
	<75b3fed9-e549-4ed0-c435-ec4795fc1e39@schaufler-ca.com>
	<CAJ2a_Ddd19txwUiKkOwpdWUSq9+VWFSR6Cqe4zgXKggWUPi4hw@mail.gmail.com>
Message-ID: <f65fb0db-d79f-3867-f48c-cec2f61e027b@schaufler-ca.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

On 9/20/2018 12:18 AM, Christian G?ttsche wrote:
>> I've only had a cursory look at your patch, but how is it
>> different from what's in xt_SECMARK.c ?
> xt_SEXMARK.c is for xtables, use-able in iptables; this is for nftables (nft)

Thank you. I am enlightened.
