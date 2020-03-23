Return-Path: <SRS0=YXOF=5I=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444B9C43331
	for <linux-security-module@archiver.kernel.org>; Mon, 23 Mar 2020 21:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A16420753
	for <linux-security-module@archiver.kernel.org>; Mon, 23 Mar 2020 21:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gbDbj7vQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgCWV60 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:58:26 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com ([66.163.184.153]:37526
        "EHLO sonic309-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727022AbgCWV6Z (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 23 Mar 2020 17:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1585000703; bh=Zwo8zdOeFtKyfBNkeuV/UBIfJ7cavNPYnorQTSmeIYw=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=gbDbj7vQkCy6J5i/WoaZ9EmqRof/5Hzqg12L1or+MvnkZwqVZ7D91kMA7vosAmtxxZkojn7qKRM576s6C1AokEGIsORjUwqyOJ38VXgfvTCMmMmNmCH2ERUv0jQc5oPAHL2fwc/aPnN249DTLC7Q8x75ceLA7xBFoiJOhL0OcOxED+rA3IeGaHzGUTmSSYu9jSr5IhEFpdX7bp7AKHUf1MMjzN8CBk4P1lPUTq7IIe2QVbOA74cPsKKbuMwRJ0Q5KKFoKMLPRce/zgv0OVHqugldJJU58mYTkCFvyif965nkMc0hFq26ozY8YSSAkdJzJlqZeH6r0+mrYc5cgYtoRA==
X-YMail-OSG: hbPWaSEVM1lZrdRpoPzEZi9alEbTw7aSTZkVJW60PqdP76rGm__Ml4_2LWei1je
 sKY54q9Vtr9ZqihbfWztTskmuFMhcmimf0sNE3wDQ8heBAF4.3Qhsbk3tVI9wtI6aAqu7btoX4Db
 zDVtc7UxpUd5nghIzwuiLsOBk9gAnK28813eei.wQBstaiXXaRgg_3RO9ZdN_9VWRsAmcgUWEdB9
 ptifGXSvCIbgSy021Mm2u9Uz2iCTq9ZvijBG4MYhphctfg658TIyBIqkvM3os3WFtyGrc0Y2vvfC
 9sye2ryxurA9hQGG9Bh2LMyN5du3RI9fZNpTnWJv2LkWNZC7TqwnB5C9WZ6hKvSxiRNSyRXxXeV7
 vDGoZOI5gsnc3q_DvnCJnr2qKKl1kAnm.rHVxy_lSUd.eFyQSn_HtfEXstx4dmoRWfYvE2o3p6kC
 nhBvhjYLdGsmgs9K2nDd9Bsb8eX04ECAjuH_GpBWiaLzOl7hWqusNR9NmXcqJc4fGngu9pb6pxcV
 e2TZD.GdMxofp0isUtQtHaeJ1JByJL.Lf8yTzEnZGH_yu7OSEI_KHrvPgl8AugRoINQQyrRMFVJm
 d049uCQ_ZpMn2CMtFeZqbYWZbaI_Q0Cjz3AqdnKjuzpGXfWUIC8aS9XlhnvcyDEgHfYEGbfzhwXw
 IA6pVUfFbWzaoeUsXMndrvlSvHoXMOnDZrnv.gIkfDsoHPOsM95vqZzbcjCLaIDJc0NQvJAm4ZqV
 yfFTWJIYs4SZwCKMhwicPN_6.PgqcMbMWJHbqBNA37eqJb6snD6I_bMTQjJtyNZ812D5ixGV_BV2
 wWnGKSYuQsz73RsI3zrdtWqepDHCWvDPL7TmztpXcaSyAy7.pshcps8rKL2dopJm3xLMFsum7XiY
 n7hfWZfxcVL9V95SLJYMVllu3RNA68V0lwvrgYE74ijlp6.3MUaIcptKfotEjLaPeqENpXompNgC
 EV6jt3NVGTG8MRo629SrcC2stUVuwxjlxwQWXVeYGpDzDP10Oz.iORinWW.MjAZDfTQw8yq2mK0O
 aEHhlAdwEpIdAX7QqEN6mAmNHhG_vCj.orvSLM4g8zWUrcZf_yCoNPU9GSmvurv5MFl7hMExJFdJ
 sKPf2RGQ3GGXgIpM1m8TEJocWRurBH77XTkdC5z2a77W8Z.YLaN10Lfx58pCiwEwauERdP7yUZXQ
 _oh5x5OQA9BOJHnRP.7QSVvuBrJII9JtOzeOADpjyFdNpfQECBqxNceDpPwcwvX51vRvwI2O2wp_
 lVGcWzcXO5ReHb51YEgcYd6QtEDTF3rVmyGVcojQbI44phuG1b6Ut8zNPcOlwFkqt6FTJokxmx4Q
 UamU3gp6698fa6cZ1gP2gV3hPAicG8G2P0RfpcW9tpO38VJiojGnQQ2xBVG3ljvjNn285UhLat5n
 Cb.PgCsFz451p4mHkrOL_CfKyOhE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Mon, 23 Mar 2020 21:58:23 +0000
Received: by smtp423.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5f9da4f7c6a75b975e6d43dca24a7324;
          Mon, 23 Mar 2020 21:58:19 +0000 (UTC)
Subject: Re: [PATCH bpf-next v5 5/7] bpf: lsm: Initialize the BPF LSM hooks
To:     Kees Cook <keescook@chromium.org>
Cc:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-6-kpsingh@chromium.org>
 <202003231237.F654B379@keescook>
 <0655d820-4c42-cf9a-23d3-82dc4fdeeceb@schaufler-ca.com>
 <202003231354.1454ED92EC@keescook>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <a9a7e251-9813-7d37-34d1-c50db2273569@schaufler-ca.com>
Date:   Mon, 23 Mar 2020 14:58:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <202003231354.1454ED92EC@keescook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.15518 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_242)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 3/23/2020 2:44 PM, Kees Cook wrote:
> On Mon, Mar 23, 2020 at 01:47:29PM -0700, Casey Schaufler wrote:
>> On 3/23/2020 12:44 PM, Kees Cook wrote:
>>> On Mon, Mar 23, 2020 at 05:44:13PM +0100, KP Singh wrote:
>>>> +/* Some LSM hooks do not have 0 as their default return values. Ove=
rride the
>>>> + * __weak definitons generated by default for these hooks
>>> If you wanted to avoid this, couldn't you make the default return val=
ue
>>> part of lsm_hooks.h?
>>>
>>> e.g.:
>>>
>>> LSM_HOOK(int, -EOPNOTSUPP, inode_getsecurity, struct inode *inode,
>>> 	 const char *name, void **buffer, bool alloc)
>> If you're going to do that you'll have to keep lsm_hooks.h and securit=
y.c
>> default values in sync somehow. Note that the four functions you've ca=
lled
>> out won't be using call_int_hook() after the next round of stacking. I=
'm not
>> nixing the idea, I just don't want the default return for the security=
_
>> functions defined in two places.
> Yeah, I actually went looking for this after I sent the email, realizin=
g
> that the defaults were also used in security.c. I've been pondering how=

> to keep them from being duplicated. I'm working on some ideas.
>
> The four are:
>
> inode_getsecurity
> inode_setsecurity
> task_prctl
> xfrm_state_pol_flow_match
>
> None of these are already just calling call_int_hook(), but I assume
> they'll need further tweaks in the coming stacking.
>
> To leave things as open-code-able as possible while still benefiting
> from the macro consolidation, how about something like this:
>
> lsm_hook_names.h:
>
> LSM_HOOK(int, -EOPNOTSUPP, inode_getsecurity,
> 	 struct inode *inode, const char *name, void **buffer, bool alloc)
>
> ...
>
> security.c:
>
> #define LSM_RET_DEFAULT_void(DEFAULT, NAME)	/* */
> #define LSM_RET_DEFAULT_int(DEFAULT, NAME)
> 	static const int NAME#_default =3D (DEFAULT);
>
> #define LSM_HOOK(RET, DEFAULT, NAME, ...)	\
> 	LSM_RET_DEFAULT_#RET(DEFAULT, NAME)
> #include <linux/lsm_hook_names.h>
> #undef LSM_HOOK
> ...
>
> Then -EOPNOTSUPP is available as "inode_getsecurity_default":
>
> int security_inode_getsecurity(struct inode *inode, const char *name,
> 			       void **buffer, bool alloc)
> {
>         struct security_hook_list *hp;
>         int rc;
>
>         if (unlikely(IS_PRIVATE(inode)))
>                 return inode_getsecurity_default;
>         /*
>          * Only one module will provide an attribute with a given name.=

>          */
>         hlist_for_each_entry(hp, &security_hook_heads.inode_getsecurity=
, list) {
>                 rc =3D hp->hook.inode_getsecurity(inode, name, buffer, =
alloc);
>                 if (rc !=3D inode_getsecurity_default)
>                         return rc;
>         }
>         return inode_getsecurity_default;
> }
>
>
> On the other hand, it's only 4 non-default return codes, so maybe the
> sync burden isn't very high?

That's not too terrible, I suppose. What would you be thinking for
the calls that do use call_int_hook()?

	rc =3D call_int_hook(something, something_default, goodnesses);

or embedded in the macro:

	rc =3D call_int_hook(something, goodnesses);



