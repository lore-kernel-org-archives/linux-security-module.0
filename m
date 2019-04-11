Return-Path: <SRS0=MFhz=SN=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73615C10F13
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Apr 2019 16:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 357072146F
	for <linux-security-module@archiver.kernel.org>; Thu, 11 Apr 2019 16:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="DfX0s6ZR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfDKQpZ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:45:25 -0400
Received: from sonic309-27.consmr.mail.gq1.yahoo.com ([98.137.65.153]:41359
        "EHLO sonic309-27.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbfDKQpZ (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 11 Apr 2019 12:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1555001123; bh=WH1mZQ4mAqsPlfaPbRHMFkFOMdzhViDQvjL8sWGRGCM=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=DfX0s6ZRcYeOi19VYKDBb1SOHAfZVDoZuGvOVjKZ5Ul2TZUIc6SN1JIgdl3se6PosvTwOvJrVGAfzcrfPtMugq4cZM/p9PiVk42aqDCnfAwVMq9Bs5SvbxOrfpgTSmxI21l8loZcsMNh2mDOLRgr4f2TUGEMvWnxJgoj7DgvxSts/mtCPEA8jrpg2c9GAgcTiJ28hpB5PD/Hcn2HU2b20XAUov5Ju14uBaGlEJdXbNIRpatKuRmLs109eiN6ku2ZI7cDAezpoHqDoClQm5kphL2Ulvq6Z9Z75mbepj/fy+0DCzGDHNE4kNaqtegKLk0mFJjRFDZfPnPsnlBu7A2AVA==
X-YMail-OSG: 74lfD5cVM1nUj2MUcbPmOcg9rizpkXs0reaS0X2zaAVh.8dGX9Kb_OSJALe5vwe
 364.xwxJeEdw0xiFwu5.q6scA9IjVwERDApLfYJDZsPOHQtxjWjdbOpG7ox_qQfQECZ3b8YPkDeg
 mrPS4kUlJSx5kcmcaNy1xgSW4EHjbgL56xZkuqA1J2cpBrPxrY1sHdtqfadnwAiju0i4vfFc4jJi
 zfeggq6cMYOcRy9woQtM9R4EJdp2DutIjV904jrbxw0KP56TTbGhdUDg.rkMb.FhUYv7Wwep5Lx8
 rVvC9.uH7UzpksKvGwuN4SLv_MIMCCfb4sB7oY.E3fBqMmQ6LvUp43khO4aI4_26jl_pH9kG2hF8
 UfNi1kotR0C.Nr1PDEZlPf1lmI5yqk_zgj_HWay.D2Z6R7ziSeEwxZYn4_hsr0tyeyhJX2M9kA_F
 z.d29CjzZ9PE1A1St1EJHy9hydnWXaJ4tuLRIPzU.VMdS6UHD.6NmqrYv2IoK3s4ewThf50obf30
 ut.3v4J5gB1MqicVmYu55VBWNqJQ.kgtvhwlcO2qHVbAuTy8HF7DZoxDJwwPrr4Pwl5vkFMXvgNH
 ffhYEpUh47uGlwXcc0mO45hryDBDKHPS60R4tk3PvDUbX0YPOUdorG1.FOAdvNHx184PmL2CXFfV
 s0bC4OhUgPVk5VMPw7PF4ZNYQBV4pVg0e1q5Uuz6l2Pqisl0WaMgGYNzjs_aiANXm14FhooSV.Zk
 QYrEXs7ql3okCa_mVDBAyVATUtqwQLvRuuxDKCtTW1IS1.wXg9W7oYwEudnj44y_YzxXNYE5AG1x
 XQPB_5toU754GIC0orKjmaJ73jOP8xi.TY4Xs2OMs5Q_1XnJJDMMbAttGFXY1Aam_zxpKc1nkqZz
 7Z5P7NkhQHpVGegqkFIdNl57L2IHNmTN0v3KFVI6piSPXNVp98YJ92KaSh59_cXWDSL81YhNgSeP
 Ql2SEPgjZaqz9wh4rijq624Ta9nh57E31yvRx_OT5TRGyBak97O1xOvf.Yl647uiMJ5rQ1eqGoiQ
 ZUsZEG1vX_VEdxjMdKGPmr6epFatVXCjREIoGTWjd.pkxG12mlTtc_9B2ErLVxJcVWCr09_e9j9M
 TtJ0ixXdeSWcZJPRpUW.BuzH3oaZf_vMZ4hS5pq6K4Lszvwpm3u5zLQpd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Thu, 11 Apr 2019 16:45:23 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp429.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9838c879a17d521e8eab8c1dd5c89713;
          Thu, 11 Apr 2019 16:45:19 +0000 (UTC)
Subject: Re: [PATCH] net: socket: Always initialize family field at
 move_addr_to_kernel().
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-security-module <linux-security-module@vger.kernel.org>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        syzbot+0049bebbf3042dbd2e8f@syzkaller.appspotmail.com,
        syzbot+915c9f99f3dbc4bd6cd1@syzkaller.appspotmail.com,
        casey@schaufler-ca.com
References: <1554128362-12274-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20190402.132306.2280596762532017665.davem@davemloft.net>
 <b4083428-53b2-0f71-585f-d648b8fd1331@i-love.sakura.ne.jp>
 <20190403.214926.2003732231073495468.davem@davemloft.net>
 <4d077355-03de-0b8a-b6fc-51757eafe7eb@i-love.sakura.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <4f949dcc-7757-0f02-758b-2509f6be0c6d@schaufler-ca.com>
Date:   Thu, 11 Apr 2019 09:45:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4d077355-03de-0b8a-b6fc-51757eafe7eb@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 4/11/2019 4:31 AM, Tetsuo Handa wrote:
> On 2019/04/04 13:49, David Miller wrote:
>> From: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
>> Date: Wed, 3 Apr 2019 06:07:40 +0900
>>
>>> On 2019/04/03 5:23, David Miller wrote:
>>>> Please fix RDS and other protocols to examine the length properly
>>>> instead.
>>> Do you prefer adding branches only for allow reading the family of socket address?
>> If the length is zero, there is no point in reading the family.
>>
> (Adding LSM people.)
>
> syzbot is reporting that RDS is not checking valid length of address given from userspace.
> It turned out that there are several users who access "struct sockaddr"->family without
> checking valid length (which will be reported by KMSAN).
>
> Unfortunately, since tipc_bind() in net/tipc/socket.c accepts length == 0 as a valid input,
> we can't reject length < offsetofend(struct sockaddr, sa_family) with -EINVAL at
> move_addr_to_kernel() which are called from bind()/connect() system calls. I proposed
> always setting "struct sockaddr"->family at move_addr_to_kernel() but David does not
> like such trick.
>
> Therefore, LSM modules which checks address and/or port have to check valid length
> before accessing "struct sockaddr"->family in order to determine IPv4 or IPv6 or UNIX.
>
> Below is all-in-one change (for x86_64 allmodconfig). Well, I've just realized that
> move_addr_to_kernel() is also called by sendmsg() system call and for now added changes
> for only security/ directory. Is this change appropriate for you? (I wish we could
> simplify this by automatically initializing "struct sockaddr_storage" with 0 at
> move_addr_to_kernel()...)
> ---
>   drivers/isdn/mISDN/socket.c |  4 ++--
>   net/bluetooth/sco.c         |  4 ++--
>   net/core/filter.c           |  2 ++
>   net/ipv6/udp.c              |  2 ++
>   net/llc/af_llc.c            |  3 +--
>   net/netlink/af_netlink.c    |  3 ++-
>   net/rds/af_rds.c            |  3 +++
>   net/rds/bind.c              |  2 ++
>   net/rxrpc/af_rxrpc.c        |  3 ++-
>   net/sctp/socket.c           |  3 ++-
>   security/apparmor/lsm.c     |  6 ++++++
>   security/selinux/hooks.c    | 12 ++++++++++++
>   security/smack/smack_lsm.c  | 39 +++++++++++++++++++++++++++++++++++----
>   security/tomoyo/network.c   | 12 ++++++++++++
>   14 files changed, 85 insertions(+), 13 deletions(-)

Except as noted below this looks fine for Smack.

> ...

> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 5c16135..7c19c04 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -2805,13 +2805,21 @@ static int smack_socket_socketpair(struct socket *socka,
>    *
>    * Records the label bound to a port.
>    *
> - * Returns 0
> + * Returns 0 on success, and error code otherwise
>    */
>   static int smack_socket_bind(struct socket *sock, struct sockaddr *address,
>   				int addrlen)
>   {
> -	if (sock->sk != NULL && sock->sk->sk_family == PF_INET6)
> +	if (sock->sk != NULL && sock->sk->sk_family == PF_INET6) {
> +		/*
> +		 * Reject if valid length is too short for IPv6 address or
> +		 * address family is not IPv6.
> +		 */
> +		if (addr_len < SIN6_LEN_RFC2133 ||

  +		if (addrlen < SIN6_LEN_RFC2133 ||
  

> +		    address->sa_family != AF_INET6)
> +			return -EINVAL;
>   		smk_ipv6_port_label(sock, address);
> +	}
>   	return 0;
>   }
>   #endif /* SMACK_IPV6_PORT_LABELING */
> @@ -2847,12 +2855,21 @@ static int smack_socket_connect(struct socket *sock, struct sockaddr *sap,
>   
>   	switch (sock->sk->sk_family) {
>   	case PF_INET:
> -		if (addrlen < sizeof(struct sockaddr_in))
> +		/*
> +		 * Reject if valid length is too short for IPv4 address or
> +		 * address family is not IPv4.
> +		 */
> +		if (addrlen < sizeof(struct sockaddr_in) ||
> +		    sap->sa_family != AF_INET)
>   			return -EINVAL;
>   		rc = smack_netlabel_send(sock->sk, (struct sockaddr_in *)sap);
>   		break;
>   	case PF_INET6:
> -		if (addrlen < sizeof(struct sockaddr_in6))
> +		/*
> +		 * Reject if valid length is too short for IPv6 address or
> +		 * address family is not IPv6.
> +		 */
> +		if (addrlen < SIN6_LEN_RFC2133 || sap->sa_family != AF_INET6)
>   			return -EINVAL;
>   #ifdef SMACK_IPV6_SECMARK_LABELING
>   		rsp = smack_ipv6host_label(sip);
> @@ -3682,9 +3699,23 @@ static int smack_socket_sendmsg(struct socket *sock, struct msghdr *msg,
>   
>   	switch (sock->sk->sk_family) {
>   	case AF_INET:
> +		/*
> +		 * Reject if valid length is too short for IPv4 address or
> +		 * address family is not IPv4.
> +		 */
> +		if (msg->msg_namelen < sizeof(struct sockaddr_in) ||
> +		    sip->sin_family != AF_INET)
> +			return -EINVAL;
>   		rc = smack_netlabel_send(sock->sk, sip);
>   		break;
>   	case AF_INET6:
> +		/*
> +		 * Reject if valid length is too short for IPv6 address or
> +		 * address family is not IPv6.
> +		 */
> +		if (msg->msg_namelen < SIN6_LEN_RFC2133 ||
> +		    sap->sin6_family != AF_INET6)
> +			return -EINVAL;
>   #ifdef SMACK_IPV6_SECMARK_LABELING
>   		rsp = smack_ipv6host_label(sap);
>   		if (rsp != NULL)
> diff --git a/security/tomoyo/network.c b/security/tomoyo/network.c
> index 9094f4b..3cbd6bd 100644
> --- a/security/tomoyo/network.c
> +++ b/security/tomoyo/network.c
> @@ -505,6 +505,12 @@ static int tomoyo_check_inet_address(const struct sockaddr *addr,
>   {
>   	struct tomoyo_inet_addr_info *i = &address->inet;
>   
> +	/*
> +	 * Nothing more to do if valid length is too short to check
> +	 * address->sa_family.
> +	 */
> +	if (addr_len < offsetofend(struct sockaddr, sa_family))
> +		return 0;
>   	switch (addr->sa_family) {
>   	case AF_INET6:
>   		if (addr_len < SIN6_LEN_RFC2133)
> @@ -594,6 +600,12 @@ static int tomoyo_check_unix_address(struct sockaddr *addr,
>   {
>   	struct tomoyo_unix_addr_info *u = &address->unix0;
>   
> +	/*
> +	 * Nothing more to do if valid length is too short to check
> +	 * address->sa_family.
> +	 */
> +	if (addr_len < offsetofend(struct sockaddr, sa_family))
> +		return 0;
>   	if (addr->sa_family != AF_UNIX)
>   		return 0;
>   	u->addr = ((struct sockaddr_un *) addr)->sun_path;
