Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FF1C433FE
	for <linux-security-module@archiver.kernel.org>; Mon,  7 Nov 2022 19:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbiKGS77 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiKGS75 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 7 Nov 2022 13:59:57 -0500
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC6128E37
        for <linux-security-module@vger.kernel.org>; Mon,  7 Nov 2022 10:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1667847591; bh=xkKz+zxj6VEW5xPvuGaiZR4Gf90RBWkomUoVTYhA3Ks=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=sWbNhh686aZCl3Q2koUXfzSret5agiyh/FXVckEcS2QUE+RaIUJgdE/YtUqFMuah0GibDQa3p+DMk9vjd/Al1CXLgQFY9zJTROuxjlqP/A/4V8SpQLvNGNC86tbfcW0B86J5mwnA4C7qVl9T5dYA1yZQ4IXswU5ZPFYEE3EU/C8Ds5zKtfUmIBbLGIiujmPIFxJhdGx+Iwct0lps6B1ZP1Pv0z9oOHF7sOfEAUEc/+v2zpXb5sFZ5ac5m6bSTJT+YfsNmoT0K915rC1DrPVawH8zk3KRU30mfOzy1lGlvJ1oULU+bknUt6QCQWKi3TA4yqnD/pEXYspD3f5x5vvG3w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1667847591; bh=L0tNKQTxAQdIg/3P0ZyGVljnq0GQTUMdtp97+RM36pw=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=fMuJui23gGCyHVSTysG9pI+qNE+ypPHZ02tJ1ZyTOQa7G+q2Nci+94DhfPmuBgQQiA2TYsR8UJhZSgCcnXw4FzfC0668k7UU66n97G4EK4cXprqfrNlmabGnZairbUh5QGiU1tFlxX6V6BT7bIEBTkhYoaR3mhr7U7Eg0IkOITINoayMObd3Jo8KyxJBetu1Y9UYSbAUHNEmUiGWY84cXE2bSrJTBUq/NUTDJAIwVwHfEe3T2h7w5zgzorCM315b95lA9bnSEP+hpmzwBh8UHpmHk3+RY9+cdNPyhfE4OLsKJrGqpuZ5lnHqhTK5QkUKRQnewopTFwc+AK5JUOStLQ==
X-YMail-OSG: GAYbo7YVM1k1XUVHZGoQ3EpWKV3lBWwMhstc_IfvlXQpnBHXZoYF3YIQwsGcFzv
 sXgDgUezxBo0c9BDbn.6GKGfBRPJoxSwWoC2HnaKDCJismFFHubiDChKgGZMN7yPyqzKGmafGmsC
 pmeX._RPTHwyQGWL41MbnanNr7ELaqTZGXZ7nnXf8JhtkskhaQlAirCkMGT8uecpR946weEO4Qkt
 yANnsI6uZ3U19ow66.w6G7ahPdINx086f_99d0k6ZOTISkYd4WhFY08mrbZOHszjcKCLWYhE4GWe
 31wtw1mRZdOH6bLs_Xs4y1Og1wW9J.1BsiO_tJoHaZzEigf5mgHGfARI29nRhB9j7gp1DiYSJBXV
 rsDZKeGLn24ccib4yIk_BUZ46Lmabgsd6ERtj0W.mICSp.HMHtAeOFPO4dTd3y9j5gEt9NdWJo9p
 ZK6nbZZjrEgpjzpoNBvG5DCgAsOt46b283e2vrqxNoZk8731a05Cf32ijV8Knznju5BjvQeJX44v
 D0UtURkj4is4ooowyXjFj09C.BcPpejysiB4ojoa02_M5JVshCJJ9m9ip9IuJoodW7olEtTTrKTN
 ZHKBh4_A_WrqTfs.ewKrwYk1A3OXxmcGwj7SN8SDMq49ymX6aqFVVlauBhkO4jpGwo1xpXI3CeC0
 vYpFzaA65VM0Ks5B0nJYvMxdSWXonnuVPehr_xN1apQ53C03vtLnJ6dF.NZIUr2P54XIvzITgcXZ
 ezByqMM7BvIsbrxqYbgtR8blSXZxumV2gdq.p_GzR9eizuX8mmL5waX2s5.5ttUOFd4C0fw1Fuee
 DYGnSocE.H1GCIea1.t7BS_1IUvJi.s.ME02oMwh4j46FrCjWSj7Ne8evv7ODApkrn7UIONgRY_Q
 bYxwnCHA8IHmsGAFbbNOv3YNbaPtW5hO17Uuz8Ami3foa47dvCRb5rs2UL2N4L.g9oDERVuQRQ5d
 XPMT0rWNULlbud42Nq_SJzgLuT6YarsCzRfQ8095fdRm52OlqV9wDrKWdwPOLYkFQWuicV7WD00Y
 XxEHjDfVboxGuuSdUaKXSwGCk.PNFqdv9_AwPalZHa6ol1SZ6FdMPDmWnIAZggLab2.6vjInPdgh
 l7yOjfFd5EjFFhBk3m9wUgr4_4Hw6_gEhaXk7wmZ6OJtvK9ZXybleGiTnbkI1VlvDTdeUhWFbnUi
 bComAp6CldjHm85F2oTKxd2sKVH7gQyDaa_w7xWUBauLA1DHFwpt0F_RueROXWO_PavspLvKoB1Q
 nQUZSR.tl7iDhQrW4qacuNUAhrvR7f9iHAoPiwn5YlT0cYDYNZWzkINKkRoe7GfIogjsVsUTLRGn
 k9QLj8atGfvJjt_6sNLoZSZq92fvPeYqlwjJHYXFqluaarImOW0bk8Mp3sRQG3hzVpCSXP64Q8Wb
 TbfcMVcyDIPIcYUBypl7.9AJ5JPgBS8g8FieVdUIvbo9b6eijkxZcS7EkFt2ZObSDT9RMYSB2NmI
 ThBCmZ1BbSyfqFL7E_FyBS0hpRccHon1tpviT6UIzkfRMUUvqyhYCa3PyFKzkJcfievErupEoFZY
 u3Su37QrNXCTaFgi0F7TyZ97T01tRntI1ffjSf1Qlinflt6emAIMw5GGpdOYBO9KzfUwrBfEA48C
 fFG_GhBUaqTrYeezX2pfVhZeU.VmaCuN1EkRptRSePobhMs3WSIqpbiH0KGl1Wxy4Xxutl2Sk4on
 XcyTc85oni.kQOgjm9f9kOhxz7YsN78Q2bUfleJifyzlElsRdZP.cvRDYHIPvt9tAEWQuVgGqKDh
 LHajUS2MqK.BOdNqk.g7jqIfK_b7YSntytOXVd7G0GJ8XfifU05SQzyU1NcP30_mwNyeQCbnRQwZ
 6uf6K.TejRWcEgLztKbinafnaWdNG1Nc8_yGL1RhULmv2kkGpwBmnSSIvXxCl1SmNun4GEmK4JfP
 YLUDPoHhaC6mI4w9W4Qtr3oWW_T_hHjE0PTRWwxOTk1laodt922PV8ncD5jDi2i6if7symAMWriz
 FY1v_Giz.0t2_az_NPzztZNu.ZBTbS70r7jdGmAUqwSujZdDRMSG4yZRQWO1FsLkEhinKMhAv2m2
 _OCVkoT3NEk6bJ00uBMa5k22D7hoSpqZZDf5J0f.9QNUwFxdACeoAy7cFcm9WzJmHGzYcrfqStDW
 N.jfsiK7lVsJZ1oG4BtwjMVA_U5bbFjHKi9KzpfkouAKIMB2qGo4hZVrvYg7VeYl6K8xbJ7Wq0L9
 vfMx0JTXpOZ_q0b78S9h2eYGd4eknprkbo0HN_HrxoNdhHgPISJy4BILTb5IP0kM1vZdbDXlHUGS
 5jfyx02pqxOw-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Mon, 7 Nov 2022 18:59:51 +0000
Received: by hermes--production-bf1-5878955b5f-xc4c6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 97baa2576d935fdf4c6833d0291be37d;
          Mon, 07 Nov 2022 18:59:47 +0000 (UTC)
Message-ID: <4ead148f-1629-22ec-91f3-44c71f70fce4@schaufler-ca.com>
Date:   Mon, 7 Nov 2022 10:59:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 04/10] CaitSith: Add header file.
Content-Language: en-US
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-security-module@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <kees@kernel.org>, casey@schaufler-ca.com
References: <20221102171025.126961-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20221102171025.126961-4-penguin-kernel@I-love.SAKURA.ne.jp>
 <ef5fa206-4e7f-3c23-07d4-8591c4315d20@schaufler-ca.com>
 <20221105024345.GA15957@mail.hallyn.com>
 <5d31873f-f477-ef5a-591f-6f0195f258a8@I-love.SAKURA.ne.jp>
 <20221105234614.GA23523@mail.hallyn.com>
 <52fdbbe4-cad5-6cd0-9574-2e5efb88a478@I-love.SAKURA.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <52fdbbe4-cad5-6cd0-9574-2e5efb88a478@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20826 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 11/5/2022 5:56 PM, Tetsuo Handa wrote:
> On 2022/11/06 8:46, Serge E. Hallyn wrote:
>> On Sat, Nov 05, 2022 at 01:05:44PM +0900, Tetsuo Handa wrote:
>>> On 2022/11/05 11:43, Serge E. Hallyn wrote:
>>>> On Wed, Nov 02, 2022 at 10:57:48AM -0700, Casey Schaufler wrote:
>>>>> On 11/2/2022 10:10 AM, Tetsuo Handa wrote:
>>>>>> The main point of this submission is to demonstrate how an LSM module
>>>>>> which can be loaded using /sbin/insmod can work, and to provide
>>>>>> consideration points for making changes for LSM stacking in a way that
>>>>>> will not lock out LSM modules which can be loaded using /sbin/insmod .
>>>>> CaitSith could readily be done as an in-tree LSM. The implementation
>>>>> of loadable module infrastructure is unnecessary.
>>>> Sorry, I'm getting confused.  But in-tree and loadable are not related,
>>>> right?
>>> Very much related. My goal is to get CaitSith in-tree as a loadable LSM module
>>> which can be loaded using /sbin/insmod .
>> Great.  I support that.  But the sentence
> Thank you.
>
>>>>> CaitSith could readily be done as an in-tree LSM. The implementation
>>>>> of loadable module infrastructure is unnecessary.
>> suggests that because CaitSith could be done in-tree, it doesn't need
>> to be loadable.  I'm saying that is a non sequitur.  It sounded like
>> that setence was meant to say "Because CaitSith could be in-tree, it
>> doesn't need to be =m.  Only out of tree modules need to be loadable."
> Unfortunately, I don't think that my intended Linux distributor (namely, Red Hat)
> will support LSMs other than SELinux.

I also doubt that even if you came up with a 100% perfect implementation
of loadable module support it would be accepted upstream. If you somehow
got it upstream I really, really think it would be required to be optional.
There's no way Redhat would enable loadable module support if were available.
I am perfectly willing to be corrected if I've made a statement here that
isn't true, but I'll bet a refreshing beverage on it.

>
>   https://bugzilla.redhat.com/show_bug.cgi?id=542986
>
> Therefore, not only out of tree modules but also in-tree modules which cannot be
> enabled by Linux distributors need to be implemented as loadable kernel modules.

Today you cannot use SELinux and AppArmor together on Redhat. Someday
"soon ;)" you won't be allowed to run them together on Redhat. If there's
market demand (I'm not holding my breath) it could happen in the future.
But that's up to Redhat to decide. I don't see Redhat as the customer for
LSM improvements. They are happy with what they have.

You have to take a different approach. Find a distribution that does want
loadable modules. You'll need a viable implementation to convince them to
help with the effort. Even then, you'll have a tough row to hoe.


