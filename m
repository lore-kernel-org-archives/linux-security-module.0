Return-Path: <SRS0=hpNi=QV=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAA7C43381
	for <linux-security-module@archiver.kernel.org>; Thu, 14 Feb 2019 19:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B377421900
	for <linux-security-module@archiver.kernel.org>; Thu, 14 Feb 2019 19:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="TTUpt8zL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfBNTAG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:00:06 -0500
Received: from uphb19pa12.eemsg.mail.mil ([214.24.26.86]:39996 "EHLO
        usfb19pa15.eemsg.mail.mil" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726129AbfBNTAF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 14 Feb 2019 14:00:05 -0500
X-EEMSG-check-017: 183231597|USFB19PA15_EEMSG_MP11.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by usfb19pa15.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Feb 2019 18:59:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1550170776; x=1581706776;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=JYXGhMzep3aojeWV32H6o061tT4o2RkAvldq8M8CM5Q=;
  b=TTUpt8zLWh0lSLGpgU8n3K8QGl3W8Iz+Imom0A9n+0kXQtDSpKQdx/qp
   iuBWFg8Wokh3MDgAKgaQXw/u7QyZu5VQ5oifII2bExu662KPG1yRIgnPt
   MAJ4rofL5iEJKsIsct1uhVLcZCDBfYRPBMCD+JdiD3U3OUaUEuEyUgUqk
   wFIn225AyrdG/N2Y65oTwYEj+Xr1jt7dXndJ9LJ/G8BG/9lJKBG3tIHli
   Oux41wfvBNL4sEX9n/dN/Fvt85mrxGvTGByhKrY42vyLrA41jrl/69M2c
   B607twIUuB+Td9+S8PcWGG6toRsLlF7Y04kWAdg7QPSotfMNMzQC3Q9ti
   A==;
X-IronPort-AV: E=Sophos;i="5.58,369,1544486400"; 
   d="scan'208";a="23946299"
IronPort-PHdr: =?us-ascii?q?9a23=3AUfaKWR1epRGALhNesmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesUIvvxwZ3uMQTl6Ol3ixeRBMOHs6IC07KempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffwZFiCChbb9uMR67sRjfus4KjIV4N60/0A?=
 =?us-ascii?q?HJonxGe+RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84TaFDAzQ9L2?=
 =?us-ascii?q?81/szrugLdQgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9QKsqUj?=
 =?us-ascii?q?q+8ahkVB7oiD8GNzEn9mHXltdwh79frB64uhBz35LYbISTOfVwZKPdec4RS3?=
 =?us-ascii?q?RHUMhfSidNBpqwYooKA+cHIO1WrZTyp0EWoBWjGwesCuPhxDxGiHD40qI10f?=
 =?us-ascii?q?guHw7d0Qw8HN8DqmjYoMn7OaoQV+2+0anGzS/Eb/NTwTrz9ZTIfQ45ofGMQ7?=
 =?us-ascii?q?1wd9fax1QqFwzfilWQrZLqPjOI3ekKqGiU8vFgWPmzi28ntw5xoj+vyt0qio?=
 =?us-ascii?q?nSnI0Z0F/E9SJnwIssI9CzVUB1YdmhEJRKtiGaMZN7QsA8TGFyviY11LkGtY?=
 =?us-ascii?q?S8fCgQx5Qr3xHfa/2bc4iI/xLsT/ydLit/hHJgYL6/nwy98VWkyuHlU8m011?=
 =?us-ascii?q?FKrjBbndXWqn8N0BnT586aQfV+5keswSuD2g/c5+1eIU04iLDXJ4Auz7IujJ?=
 =?us-ascii?q?YfrELOFTLslkrslq+ZbEAk9/Ct6+Tgf7rpuIeRN5RxigHiKqQundG/AfggPg?=
 =?us-ascii?q?gOQWeb/eO82aX//ULjWrVKj+A2krLDvJDGJcUUuq65AwhP3oYl9xm/FCup3M?=
 =?us-ascii?q?4dnXkGKFJJYBOHj473NFHSOP30EPiyjlu2nDpr2vzKJKPtD5rTInTZjbvtZb?=
 =?us-ascii?q?N95FRdyAo3w9Bf/ZVUCrQZLfLoR0Dxr8fVDgM5MgOow+bnD89x1oUFWW2VGK?=
 =?us-ascii?q?OZP6TSsUGQ6uI1P+aMfJMVuCr6K/U9/P7ilHk5lkUcfKazx5sXb264E+9mIk?=
 =?us-ascii?q?qDZ3rjn8kOEGgQsgokUezgkEeCXiJLZ3auQ6I84Sk2CJq8AofeQoCgm6SB0z?=
 =?us-ascii?q?2mHp1Sf2xGD1eMEXDyd4qaQfsDdCWSIsp5mDweSbehU5Mh1Q2ptALizbpoMP?=
 =?us-ascii?q?bU9TAGupL9z9V1+eLTmg8o9TBuDMSSzXuNT2dqkWMMXTM227p/oUNlwFeZza?=
 =?us-ascii?q?d4m+BYFcBU5/5RVgc6NJjcz/F1CtzrQQLOYMuGSEu8QtWnHTEwTss9w9oJY0?=
 =?us-ascii?q?lgBtWiig7M0jG0A78aibOLHoY48qHC0HjrIcZy1XLG2LMmj1k8TctFLXemib?=
 =?us-ascii?q?Jn9wjPG47JlF2UmLuweqQCwiHN8XyOwneUs0FGTgFwVKHFXXcRZkvKt9j54F?=
 =?us-ascii?q?3NT6O2A7Q9LgRB0dKCKrdNatDxjlVGWfbiONLAbGKtgGqwAA2Iyq2WYIrrfW?=
 =?us-ascii?q?Udxj/RB1IYnAwJ53aGKBA0Bj29rGLGEDxuCVXvblvs8Ol5s3O7TkE0zxyIb0?=
 =?us-ascii?q?1gzLe1/h8VhfqBS/Icx74EuT8hqyt1EVqn2NLWEdWA9EJde/B6aME0+lBZnV?=
 =?us-ascii?q?nUrQNwL9T0NOVkj0wXaQNpl1Ln0Rl6GsNajJ5u5Esj0Q46DKWfyl4JIyuRwJ?=
 =?us-ascii?q?TYIrTKLiz3+xe1Zujd3VSIg/iM/aJa0+g1s1XuukmSE0Mm93h2m41O32C0+o?=
 =?us-ascii?q?TBDA1UV4n4FEkw6U4p9PnhfiAh6taMhjVXOq6uv2qHgop3CQ=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2C3AQCLuWVc/wHyM5BkHQEBBQEHBQGBVAUBCwGBWSlng?=
 =?us-ascii?q?QMnhAaUC00BAQEBAQaBCC2JOJBWMgYBhEACg2MiNwYNAQMBAQEBAQECAWwcD?=
 =?us-ascii?q?II6KQGCZgEBAQECASMECwEFETAFCwkCDgoCAhUCDwICVwYBDAYCAQGCXz0Bg?=
 =?us-ascii?q?VoDCAUID45+m2F8M4QvAYEUhHWBC4s5F3iBB4ERJ4Jrgx4CgUt0AoIpglcCi?=
 =?us-ascii?q?WFWgVCFP5FoCYc6ixQGAheScy2KDYVDjjEigVYrCAIYCCEPgycJCoIVF4NLh?=
 =?us-ascii?q?RSFXSEDMAEBAQl5AQFgjCqCSwEB?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 14 Feb 2019 18:59:31 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x1EIxS4K025326;
        Thu, 14 Feb 2019 13:59:30 -0500
Subject: Re: [PATCH] NETWORKING: avoid use IPCB in cipso_v4_error
To:     Nazarov Sergey <s-nazarov@yandex.ru>,
        Paul Moore <paul@paul-moore.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>
References: <16659801547571984@sas1-890ba5c2334a.qloud-c.yandex.net>
 <CAHC9VhQD=itT7jE22bo0UF24gE56y1z29fZec-7y1Zumz38FfQ@mail.gmail.com>
 <1125571548681054@iva5-0acfc31d2b43.qloud-c.yandex.net>
 <CAHC9VhRC8BC9Ocs9FYVrwnWutWD4Dow_MjwpvowxmJd=NtVN5g@mail.gmail.com>
 <3499451548746609@myt4-929fb874f3f2.qloud-c.yandex.net>
 <CAHC9VhRXc=UAfNidPjYsG561_kc_j2CkD6Db=Kb=Gjyhk3ko6Q@mail.gmail.com>
 <3191601548853902@myt6-23299ba78d64.qloud-c.yandex.net>
 <CAHC9VhQcrnXmjcVw_ppwM-fGcwhJq9SafTnZKjgpQpxK0ie+Jw@mail.gmail.com>
 <11242361548940840@iva8-8d7a47df0521.qloud-c.yandex.net>
 <CAHC9VhSjtQRGBUHvx73eVg32NMm4UN4qqaOXFyB9BMSx0Bz7dQ@mail.gmail.com>
 <34948711549920080@myt1-06117f29c1ea.qloud-c.yandex.net>
 <CAHC9VhSDot+uNDi7ULoT7dry4FW9Jgp=NcqDh6TmA=z--kmqkA@mail.gmail.com>
 <6691891549984203@myt5-a323eb993ef7.qloud-c.yandex.net>
 <CAHC9VhQ4ooT-_iBoTiYgPV7oBV5RAgN1_HqDS2LGrGBY6erMmQ@mail.gmail.com>
 <258621550167251@sas1-46c84f197234.qloud-c.yandex.net>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <90946257-e667-dff1-b941-8d596636d1bf@tycho.nsa.gov>
Date:   Thu, 14 Feb 2019 13:59:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <258621550167251@sas1-46c84f197234.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 2/14/19 1:00 PM, Nazarov Sergey wrote:
> Hi, Paul!
> I've found the problem and testing it with some very specific custom lsm module. The test case was simple:
> standard TCP/IP client-server application, where server opens CIPSO labeled TCP socket, and client connecting
> to this socket with forbidden labels. After several connections kernel crashing with general memory protection or
> kernel cache inconsistent error.
> I think, the similar behaviour should be with selinux or smack in the same conditions. But I don't know them
> so good to reproduce situation.

For SELinux, you can use
https://github.com/SELinuxProject/selinux-testsuite

That includes testing of CIPSO, both connecting from a client with an 
authorized level and from a client with an unauthorized level.

Not sure about Smack; there were some tests in LTP but I don't know if 
they would exercise it.

> After applying patch, I haven't kernel crashes.
> But now I've made additional checks and found no response icmp packets. The ip_options_compile requires
> CAP_NET_RAW capability when CIPSO option compiling, if skb is NULL. I have no other ideas than returning to
> the early patch version with ip_options_compile modified. What do you think about that?


> 
> 14.02.2019, 00:42, "Paul Moore" <paul@paul-moore.com>:
>> On Tue, Feb 12, 2019 at 10:10 AM Nazarov Sergey <s-nazarov@yandex.ru> wrote:
>>>   Since cipso_v4_error might be called from different network stack layers, we can't safely use icmp_send there.
>>>   icmp_send copies IP options with ip_option_echo, which uses IPCB to take access to IP header compiled data.
>>>   But after commit 971f10ec ("tcp: better TCP_SKB_CB layout to reduce cache line misses"), IPCB can't be used
>>>   above IP layer.
>>>   This patch fixes the problem by creating in cipso_v4_error a local copy of compiled IP options and using it with
>>>   introduced __icmp_send function. This looks some overloaded, but in quite rare error conditions only.
>>>
>>>   The original discussion is here:
>>>   https://lore.kernel.org/linux-security-module/16659801547571984@sas1-890ba5c2334a.qloud-c.yandex.net/
>>>
>>>   Signed-off-by: Sergey Nazarov <s-nazarov@yandex.ru>
>>>   ---
>>>    include/net/icmp.h | 9 ++++++++-
>>>    net/ipv4/cipso_ipv4.c | 18 ++++++++++++++++--
>>>    net/ipv4/icmp.c | 7 ++++---
>>>    3 files changed, 28 insertions(+), 6 deletions(-)
>>
>> Hi Sergey,
>>
>> Thanks for your work on finding this and putting a fix together. As
>> we discussed previously, I think this looks good, but can you describe
>> the testing you did to verify that this works correctly?
>>
>>>   diff --git a/include/net/icmp.h b/include/net/icmp.h
>>>   index 6ac3a5b..e0f709d 100644
>>>   --- a/include/net/icmp.h
>>>   +++ b/include/net/icmp.h
>>>   @@ -22,6 +22,7 @@
>>>
>>>    #include <net/inet_sock.h>
>>>    #include <net/snmp.h>
>>>   +#include <net/ip.h>
>>>
>>>    struct icmp_err {
>>>      int errno;
>>>   @@ -39,7 +40,13 @@ struct icmp_err {
>>>    struct sk_buff;
>>>    struct net;
>>>
>>>   -void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info);
>>>   +void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
>>>   + const struct ip_options *opt);
>>>   +static inline void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info)
>>>   +{
>>>   + __icmp_send(skb_in, type, code, info, &IPCB(skb_in)->opt);
>>>   +}
>>>   +
>>>    int icmp_rcv(struct sk_buff *skb);
>>>    int icmp_err(struct sk_buff *skb, u32 info);
>>>    int icmp_init(void);
>>>   diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
>>>   index 777fa3b..234d12e 100644
>>>   --- a/net/ipv4/cipso_ipv4.c
>>>   +++ b/net/ipv4/cipso_ipv4.c
>>>   @@ -1735,13 +1735,27 @@ int cipso_v4_validate(const struct sk_buff *skb, unsigned char **option)
>>>     */
>>>    void cipso_v4_error(struct sk_buff *skb, int error, u32 gateway)
>>>    {
>>>   + unsigned char optbuf[sizeof(struct ip_options) + 40];
>>>   + struct ip_options *opt = (struct ip_options *)optbuf;
>>>   +
>>>           if (ip_hdr(skb)->protocol == IPPROTO_ICMP || error != -EACCES)
>>>                   return;
>>>
>>>   + /*
>>>   + * We might be called above the IP layer,
>>>   + * so we can not use icmp_send and IPCB here.
>>>   + */
>>>   +
>>>   + memset(opt, 0, sizeof(struct ip_options));
>>>   + opt->optlen = ip_hdr(skb)->ihl*4 - sizeof(struct iphdr);
>>>   + memcpy(opt->__data, (unsigned char *)&(ip_hdr(skb)[1]), opt->optlen);
>>>   + if (ip_options_compile(dev_net(skb->dev), opt, NULL))
>>>   + return;
>>>   +
>>>           if (gateway)
>>>   - icmp_send(skb, ICMP_DEST_UNREACH, ICMP_NET_ANO, 0);
>>>   + __icmp_send(skb, ICMP_DEST_UNREACH, ICMP_NET_ANO, 0, opt);
>>>           else
>>>   - icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_ANO, 0);
>>>   + __icmp_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_ANO, 0, opt);
>>>    }
>>>
>>>    /**
>>>   diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
>>>   index 065997f..3f24414 100644
>>>   --- a/net/ipv4/icmp.c
>>>   +++ b/net/ipv4/icmp.c
>>>   @@ -570,7 +570,8 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
>>>     * MUST reply to only the first fragment.
>>>     */
>>>
>>>   -void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info)
>>>   +void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
>>>   + const struct ip_options *opt)
>>>    {
>>>           struct iphdr *iph;
>>>           int room;
>>>   @@ -691,7 +692,7 @@ void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info)
>>>                                             iph->tos;
>>>           mark = IP4_REPLY_MARK(net, skb_in->mark);
>>>
>>>   - if (ip_options_echo(net, &icmp_param.replyopts.opt.opt, skb_in))
>>>   + if (__ip_options_echo(net, &icmp_param.replyopts.opt.opt, skb_in, opt))
>>>                   goto out_unlock;
>>>
>>>   @@ -742,7 +743,7 @@ void icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info)
>>>           local_bh_enable();
>>>    out:;
>>>    }
>>>   -EXPORT_SYMBOL(icmp_send);
>>>   +EXPORT_SYMBOL(__icmp_send);
>>>
>>>    static void icmp_socket_deliver(struct sk_buff *skb, u32 info)
>>>   --
>>
>> --
>> paul moore
>> www.paul-moore.com

