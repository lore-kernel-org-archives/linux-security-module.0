Return-Path: <SRS0=1co8=32=vger.kernel.org=linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008D2C35247
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Feb 2020 02:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07DA20702
	for <linux-security-module@archiver.kernel.org>; Thu,  6 Feb 2020 02:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Y9dh+j/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgBFCHN (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 5 Feb 2020 21:07:13 -0500
Received: from sonic301-36.consmr.mail.ne1.yahoo.com ([66.163.184.205]:38395
        "EHLO sonic301-36.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727415AbgBFCHM (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 5 Feb 2020 21:07:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1580954831; bh=TIVFsp+NPXGZBaGxmOvC9Zeza+LF8Vbe406NKWUfT5E=; h=To:Cc:From:Subject:Date:References:From:Subject; b=Y9dh+j/hJ7Ti5uWZvfIXvJRwUBhiXfhk9BqmgeXQ6UL+b4Jn8RKD5Pm1v/GxSkcVOVOh4d9UwhqbC6nIccrGWkrJ4Z04Vmi65L+KVIokCTMyNb0EsI9U8wDKFyzw4JSc8QZ1Td7JxhXPSz8oJBwqoETQSp2eP0UiAprf60PTIh5gWJkwC0h0l1eWFaCrrA17trY991+O6v0sl3QYAIRdtUV+NoYQw0zCZ4FHVxrzLkUcfpA2fGVyzYzJMK/XrBIB8Smxc6moTeJoC4VlsZwPX+VOc/9Y1a96Ss+5U5B16AIQuylnG3w1Cja0xmPRcaK8OKkB2sAqfNkSd3ENw82Yzw==
X-YMail-OSG: IqrvWj4VM1kVB8uKEFMSKc0Tk9t0Y9k6rHmfcAyDGNpT8l_1Qx9ohkwobsCPQsy
 2Z0NfO5QXMEYqRAdsurImYJo.psCh5aP8CG0a_.g6q5dlU8LDZGR6u8U_hUMy_QKDM7OOq4RuQBE
 FKHf6tEa7zuVtM7eiE.K8ZyzuJZs7Tx4Y.sN_i5M6dIEUR9VW4DpILev1qxjsb7UmngaO2HLQyou
 hamNHt10I2qIeJM7b2J0D15u.4l6ZrYR65AS2fjSUlK9j_69IPsvXG1xV5b23e3ewRX3ksuWqvIr
 7ZklzXl6H3eui260EkXpYBBeCsyN6SlaMD8mxjLVaUShmQzQ80BsVZJM5b3ZNCdFUHTmd7QI7N.t
 rlkp0u2CFQ..EBdjgYmZ9aXKDe6citFXailOXk7orYj7lzO.GLE_.8d291MpPZ29WRywKAIswr4U
 y2liY7JAYZTPuppuE5srRABu9nWjX1Al1WJVSurBYa3U15bpAri0jdhqq7H_Bsvjha8O7hPMJLPV
 t35JOE2KLRzs39JPNY_x4P8fX63ZlGHL1oHMorrxv4Gm.P0nOIbdDYEIPJePsd_JkBw9.GgsbCpL
 4fB4uorAmqJRiX6azRfExmIZz83C_u4Xyxxq8VS_EVZGhE_bEkKBT7ilzxij.Z512p7Av7AFQEkL
 KfHrc1nXywlGHecKioiS08zEndqTb5Ew1cMR7BfS40PMmBk8gCHCxZTK7NCBSvTZU81hA6fiho7M
 7IINzKYDMol2k8H.NyTtPeXrIsFSq7ZQXpp0iFCVV5EPJDtwqVofUjPuCWbBDr_iD27haRxHtTrr
 sKd6dyRw.hEDKk9_2985ochRqT.vxikzQYCYZKJXwMTHVaze_mxwhGpiJ4KlaQTta13yTpyabGj4
 LirN8Noq.QeZMBe9zdGfBw4BAv5i9OL7qv7pVKN3UmbHcpcYelosKgHOS.PNgaNnOcrFQPsbZcug
 OJuboGYS08HV3DWEiPnKNn2QXRQkW50l4j3WoqCn9evxmcxDbiBs.2LXI0so6v.FGYTV4XPtrYt.
 yD3TvYqJIstWHaGecysh85WiFFlPvFJyX8I5dsafn2y_Z.sKb8w8YQxVL.kc2NA15dcaDiz0wjUX
 n3Wnr_xnxun0adpBMQfZh1c6zko9kpKPcpiEMEghUl1Hr8cFaT2K42ng1CEtARVeQEfim71MmvBb
 IZEuZPMVUGXlwXGLHwNP8sQ0fS0TARGclHrGI7ntjsalchkoHB3sqYErp5fwz30u.TfdlbrOfV3z
 5iBg5BbCZuH2hNkmz52AP0F2UlOvu8b6Gf105xOp3LtKF2XW1XppxXomWnoBJxBg1b02XNzH8D2E
 fyrLrLqsNj1oDOkeaR_763WMH0Mq6lvWginmU3tnvSQT7NjZeuhPVI36zb_7WjM64WzUY0y7wwhc
 zRBuN6RbFUiedSV3stoQVM.rHR9i5W4tL65ZAAWoNQga.xgYWpQFbaaATtmi_
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Thu, 6 Feb 2020 02:07:11 +0000
Received: by smtp421.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID eb9d602dab41df94d54fff88437dd822;
          Thu, 06 Feb 2020 02:07:10 +0000 (UTC)
To:     Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: [GIT PULL] Smack patch for v5.6
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 mQINBFzV9HABEAC/mmv3jeJyF7lR7QhILYg1+PeBLIMZv7KCzBSc/4ZZipoWdmr77Lel/RxQ
 1PrNx0UaM5r6Hj9lJmJ9eg4s/TUBSP67mTx+tsZ1RhG78/WFf9aBe8MSXxY5cu7IUwo0J/CG
 vdSqACKyYPV5eoTJmnMxalu8/oVUHyPnKF3eMGgE0mKOFBUMsb2pLS/enE4QyxhcZ26jeeS6
 3BaqDl1aTXGowM5BHyn7s9LEU38x/y2ffdqBjd3au2YOlvZ+XUkzoclSVfSR29bomZVVyhMB
 h1jTmX4Ac9QjpwsxihT8KNGvOM5CeCjQyWcW/g8LfWTzOVF9lzbx6IfEZDDoDem4+ZiPsAXC
 SWKBKil3npdbgb8MARPes2DpuhVm8yfkJEQQmuLYv8GPiJbwHQVLZGQAPBZSAc7IidD2zbf9
 XAw1/SJGe1poxOMfuSBsfKxv9ba2i8hUR+PH7gWwkMQaQ97B1yXYxVEkpG8Y4MfE5Vd3bjJU
 kvQ/tOBUCw5zwyIRC9+7zr1zYi/3hk+OG8OryZ5kpILBNCo+aePeAJ44znrySarUqS69tuXd
 a3lMPHUJJpUpIwSKQ5UuYYkWlWwENEWSefpakFAIwY4YIBkzoJ/t+XJHE1HTaJnRk6SWpeDf
 CreF3+LouP4njyeLEjVIMzaEpwROsw++BX5i5vTXJB+4UApTAQARAQABtChDYXNleSBTY2hh
 dWZsZXIgPGNhc2V5QHNjaGF1Zmxlci1jYS5jb20+iQJUBBMBCAA+FiEEC+9tH1YyUwIQzUIe
 OKUVfIxDyBEFAlzV9HACGwMFCRLMAwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQOKUV
 fIxDyBG6ag/6AiRl8yof47YOEVHlrmewbpnlBTaYNfJ5cZflNRKRX6t4bp1B2YV1whlDTpiL
 vNOwFkh+ZE0eI5M4x8Gw2Oiok+4Q5liA9PHTozQYF+Ia+qdL5EehfbLGoEBqklpGvG3h8JsO
 7SvONJuFDgvab/U/UriDYycJwzwKZuhVtK9EMpnTtUDyP3DY+Q8h7MWsniNBLVXnh4yBIEJg
 SSgDn3COpZoFTPGKE+rIzioo/GJe8CTa2g+ZggJiY/myWTS3quG0FMvwvNYvZ4I2g6uxSl7n
 bZVqAZgqwoTAv1HSXIAn9muwZUJL03qo25PFi2gQmX15BgJKQcV5RL0GHFHRThDS3IyadOgK
 P2j78P8SddTN73EmsG5OoyzwZAxXfck9A512BfVESqapHurRu2qvMoUkQaW/2yCeRQwGTsFj
 /rr0lnOBkyC6wCmPSKXe3dT2mnD5KnCkjn7KxLqexKt4itGjJz4/ynD/qh+gL7IPbifrQtVH
 JI7cr0fI6Tl8V6efurk5RjtELsAlSR6fKV7hClfeDEgLpigHXGyVOsynXLr59uE+g/+InVic
 jKueTq7LzFd0BiduXGO5HbGyRKw4MG5DNQvC//85EWmFUnDlD3WHz7Hicg95D+2IjD2ZVXJy
 x3LTfKWdC8bU8am1fi+d6tVEFAe/KbUfe+stXkgmfB7pxqW5Ag0EXNX0cAEQAPIEYtPebJzT
 wHpKLu1/j4jQcke06Kmu5RNuj1pEje7kX5IKzQSs+CPH0NbSNGvrA4dNGcuDUTNHgb5Be9hF
 zVqRCEvF2j7BFbrGe9jqMBWHuWheQM8RRoa2UMwQ704mRvKr4sNPh01nKT52ASbWpBPYG3/t
 WbYaqfgtRmCxBnqdOx5mBJIBh9Q38i63DjQgdNcsTx2qS7HFuFyNef5LCf3jogcbmZGxG/b7
 yF4OwmGsVc8ufvlKo5A9Wm+tnRjLr/9Mn9vl5Xa/tQDoPxz26+aWz7j1in7UFzAarcvqzsdM
 Em6S7uT+qy5jcqyuipuenDKYF/yNOVSNnsiFyQTFqCPCpFihOnuaWqfmdeUOQHCSo8fD4aRF
 emsuxqcsq0Jp2ODq73DOTsdFxX2ESXYoFt3Oy7QmIxeEgiHBzdKU2bruIB5OVaZ4zWF+jusM
 Uh+jh+44w9DZkDNjxRAA5CxPlmBIn1OOYt1tsphrHg1cH1fDLK/pDjsJZkiH8EIjhckOtGSb
 aoUUMMJ85nVhN1EbU/A3DkWCVFEA//Vu1+BckbSbJKE7Hl6WdW19BXOZ7v3jo1q6lWwcFYth
 esJfk3ZPPJXuBokrFH8kqnEQ9W2QgrjDX3et2WwZFLOoOCItWxT0/1QO4ikcef/E7HXQf/ij
 Dxf9HG2o5hOlMIAkJq/uLNMvABEBAAGJAjwEGAEIACYWIQQL720fVjJTAhDNQh44pRV8jEPI
 EQUCXNX0cAIbDAUJEswDAAAKCRA4pRV8jEPIEWkzEACKFUnpp+wIVHpckMfBqN8BE5dUbWJc
 GyQ7wXWajLtlPdw1nNw0Wrv+ob2RCT7qQlUo6GRLcvj9Fn5tR4hBvR6D3m8aR0AGHbcC62cq
 I7LjaSDP5j/em4oVL2SMgNTrXgE2w33JMGjAx9oBzkxmKUqprhJomPwmfDHMJ0t7y39Da724
 oLPTkQDpJL1kuraM9TC5NyLe1+MyIxqM/8NujoJbWeQUgGjn9uxQAil7o/xSCjrWCP3kZDID
 vd5ZaHpdl8e1mTExQoKr4EWgaMjmD/a3hZ/j3KfTVNpM2cLfD/QwTMaC2fkK8ExMsz+rUl1H
 icmcmpptCwOSgwSpPY1Zfio6HvEJp7gmDwMgozMfwQuT9oxyFTxn1X3rn1IoYQF3P8gsziY5
 qtTxy2RrgqQFm/hr8gM78RhP54UPltIE96VywviFzDZehMvuwzW//fxysIoK97Y/KBZZOQs+
 /T+Bw80Pwk/dqQ8UmIt2ffHEgwCTbkSm711BejapWCfklxkMZDp16mkxSt2qZovboVjXnfuq
 wQ1QL4o4t1hviM7LyoflsCLnQFJh6RSBhBpKQinMJl/z0A6NYDkQi6vEGMDBWX/M2vk9Jvwa
 v0cEBfY3Z5oFgkh7BUORsu1V+Hn0fR/Lqq/Pyq+nTR26WzGDkolLsDr3IH0TiAVH5ZuPxyz6
 abzjfg==
Message-ID: <7300e604-6fb5-16b1-4e1b-dfae7b494853@schaufler-ca.com>
Date:   Wed, 5 Feb 2020 18:07:09 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
References: <7300e604-6fb5-16b1-4e1b-dfae7b494853.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.15185 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: owner-linux-security-module@vger.kernel.org
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

Apologies for the late pull request. Testing on the originating
configuration was unfortunately delayed.
One fix for an obscure error found using an old version of
ping(1) that did not use IPv6 sockets in the documented way.

The following changes since commit d5226fa6dbae0569ee43ecfc08bdcd6770fc4755:

  Linux 5.5 (2020-01-26 16:23:03 -0800)

are available in the Git repository at:

  https://github.com/cschaufler/smack-next tags/Smack-for-5.6

for you to fetch changes up to 87fbfffcc89b92a4281b0aa53bd06af714087889:

  broken ping to ipv6 linklocal addresses on debian buster (2020-02-05 14:16:27 -0800)

----------------------------------------------------------------
Smack change for Linux 5.6

----------------------------------------------------------------
Casey Schaufler (1):
      broken ping to ipv6 linklocal addresses on debian buster

 security/smack/smack_lsm.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

