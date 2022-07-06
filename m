Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B95C433EF
	for <linux-security-module@archiver.kernel.org>; Wed,  6 Jul 2022 15:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbiGFPqo (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 6 Jul 2022 11:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbiGFPqa (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 6 Jul 2022 11:46:30 -0400
Received: from sonic304-27.consmr.mail.ne1.yahoo.com (sonic304-27.consmr.mail.ne1.yahoo.com [66.163.191.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37CD3206F
        for <linux-security-module@vger.kernel.org>; Wed,  6 Jul 2022 08:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1657121976; bh=WYni852wcphSZwUB4oLKMpJgMoNxgav+lOf3nZq2okc=; h=Date:Subject:To:References:From:Cc:In-Reply-To:From:Subject:Reply-To; b=IEl1r9w9wMaGGJIAmehh9r7jOeg18R0Uz0k3/Ie6+0VyAcEksuwOjT9t0PcF0EKhuR8SL2ycwTpejphzp9TWz52rAlvopim+tndqABAkw6cR1JjEJbEo/zS1svu/BYux0rDpGpLTJsaOoXfJLuRuGb4zPGKNxEQvgZ1onURRUFNg8al5IZ6KFQUZSPSVy2ZKj3Fykb4yPST4H5p7u7bfX78LnVwlCYS09NsiWIyB7cpxxla4bOrLOlPJMYWWgp9/6k+plRaoRJPAKLu+erJ+USfoG1Md+hBiFvR+F84uRUZ4xQZFZrAQ7AurU6AySMjCnDJc15cchqv5P01Gz0IPJQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1657121976; bh=T15pi4DZBHB6V+YmUEUWb6QbKbk+9WEwt/ov59GvnJ1=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=D5X/Y/+Oj3H/J3nwlEU2wXqSUlLBGHwaETXEZ1ZHTDpArVZ4MUBMl9Thbxp11AIBrACMwraKTR6YPLNvX7RVXadXLz+FsgD6LQTUSxXWSpHI6wnK5r4wsJ6+xyUv8EXDUy4od3gMPB/sJ65gTwKSefG5QfyPlyLsxRD3SCPwXe8veD4aghFrHMWXQe4CTQYEfbnmIWJ9k7JDyGI1EF8OxLOsldtwYNr4qbR6G4zMDOsdFdlEDRa5/uoqKEx2Gw9fy1l4zLx3CuAipr2k07lO/yp+Ikr0Kg2fRl2wy7AZaAJRq6GYDmovTO8y3vghpbhd+GLN3Y+oulHVQcbomsAs3g==
X-YMail-OSG: zyGwnOEVM1kevGQDcOXh2mnZ8ZCjhQ.6n7EJgIGmFxAQJn4wGfUMfBRuEPCbJM9
 4EiHMFpFnc2LEhYrEk174r51Jjyz_GFdULm265xu0LtFIdgawS88jTbCyW8tAM6zzu0APKLcdfBf
 98YhI.4q32pzbQTx5Zt7HExyNUFmk.w6BewRBrUwWudDqiNJEdZ1CSrRrnBR57wZ9JTfIUQ5ot2i
 f4J2iPWkGIVhj0meREWevHjvBQjfhaijRBsDWp22104.Xq_Wn6KsLHr5O1zkgbwfPN5_NVb6zHCK
 qlVeYealxrITYWx51LFbo80pDJOhhXYyfbg8kknpvZ2vpIuQGUe7NatwmLkbmJ_MDDii7RM3J2ME
 pXVw6EIplLFynuUDdlfWTt8bZUi3dXCNBwKkU.KqI3Y1FZuE4kP0OMj2m0B5C_zId1dbtsuCiaM7
 UmV2oqQTmWUr3qv0arZ8Jen2n1HFm.VTDpLAkaEdSiZBZ2IwQYcfL0TAttGEC3c4yM_5VS.ZaTtL
 oGnv8g0rInp6djioJ94AlSJHjhD3MaCk0DHlPHMU8SphEoWOzVh01oo5MJmBzbh_QBXazDUg1CQN
 bsBotmqqG9epGkS7cIIgnhRME0DB0ehYY_tWW0bTHhFFwmUYfon1Jy6ePA4C2NPFX4.g0kpcUN4k
 5svlPN9h71ejZoeWj..exc7BsqONgeecpL51KPr8qjjXqhp7bt9BHUBv13gR0OD6eKapMSXnMs0K
 ZgojKXEV.KHq7UNcxJGivB1hzn8PSEdZ6RtvKe9rPuj2GiNoc_on8DAFyUjOUGre01xGZfet_xOp
 mGycl7jT7t4fUWw15y7sFOZPEgAWcha52nrFqP7JSYJXcB7Vf9y25Bf16osWNzFSoBhDVb9Vk_rw
 kOys60ale.GT2J_ps_2w3Am2crS7eyNjfHPh8Iwxvk1juKmnot9oq2xwq5xxlnnp5M0r3TQHoXB3
 uE_24_R.vaVpxN3FyqEYFN6HzTx5h3F.WOYhhME1IG3cT3D7cnnrV4fU33B7XIfVLNaLJETGF6NE
 AFOjbYTtW0U3lB3mAgMmaiH5u7yJeI22exolsXQY5qHb4UBBNZOTiP9RyZmT.Q.7q.eq1gvgK2wy
 U0Ncq9yD9cnWegBFUCAKAcpo6fHQAOChnH14rTk6UwscuRoxUeP9PiKppOq3UpgRGgSor7p1IhVg
 FBD2aWz.mE0.ltrDL7DrTHTamPkUjDVADEqZ9MlAdpS7V7wYYqpfelVtKKIp7ccWd.Vn_PfoNfwT
 a3T7mJYqI3P0S6iCaw3VHFTVV6crFNBouoXYEZ86ZWN_TwodyH3RyzW4jAK6GzhdwyiMNCF3fcnj
 eUK8_aP.jg65UE.bpz8G8M.75mK_FE60BqKpoL8BTQxY6nQwJPEK1QUy_Tj1TxS8NcMw4XMbnmek
 xeovLAlPOGA20i.hUcijNkZEnddpjT2Pk1YDIpDR4HlwtNwiz1ZnuUUT3yJEvu1mH3CueX58w3aa
 dE1dgH4kob5l1MBuLFlwapgUVqVytT5iCvjmGDYE3VpcUuupuobMHMWmH32KzKW6OlYS5EArgqwh
 smW0SlPLWdydk3IvyThFotbWn43blY.hiw7kh51WlGrgmxEkqLeG6FXn5ClnzQ5fo6NRHlMYSUhN
 vOTrwXKGBzacQsd4efT2.hiLDzy33e7dlxQgvZisTY8Wp2MiCVCGB8SPE38L2l69rJRjB9_7C7Yn
 bpyDQOk5DQ.TUoPpX2L.t4BhE8YVMd9Ev7MU3G1SQJVeYihhUgBiW3Y9ZIs3tsMr5e7Oo.T6u1Xi
 ceP0RnEI8ABPqmhgYa9L3G.X2JUvzcvL8bOlvTA0nKmx2aWPCKX5VLHVGybwbxUvzE3xDCr2D6vQ
 34R7Za32zFQfuYY.9Ku4vWuF7aSvT2gG0G3jKECoz33AwaTvXjqkOaiPIyBwELwHGXAFC8hdUP1A
 Zv8r5S4_gBwE817n6eRROVte7QgWVqUfNF1FzcWjrZuFedVvDb7KkAh2kcE_S63x2TFe3Bn8Y3n8
 bE77ykhRCqOyI.aBhUejyu0bfWXkfgex7CuxcF9ZzGKcQKUh9QVSjaNYDQJs3KuU7XDyoJ9x5Pxl
 tkUt692vLUNmIJBg.D1Eo5dJwM4LWbQDx0dL4isAAPCcC_yfhV1.vrhDvc72FrnhXpHVTx5zStZo
 PyWvN6ctgSjtuXZprZHictJJf8WDiToo4X0xiohMow4BwKNAb6rO4uPzjHV5pnyD6tfabMr4repE
 tswzb8H7q6yAnMaBGPO8vQ.2WtilvVEGwGtIUeF8aDd47Ua8U5loVSGUCD3bOD9kQv_YgM6WrNQ9
 1J7ZZmHxRhp_Zlkmu5uM4XA--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Wed, 6 Jul 2022 15:39:36 +0000
Received: by hermes--production-gq1-56bb98dbc7-gxlbk (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1e646dbf6fa2f6407b6f7c705af4631c;
          Wed, 06 Jul 2022 15:39:35 +0000 (UTC)
Message-ID: <f871c6ad-0fa1-1c4a-bf7c-47070abce444@schaufler-ca.com>
Date:   Wed, 6 Jul 2022 08:39:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: LSM performance measurement
Content-Language: en-US
To:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
References: <CACE9dm-cNq+m04StHREnUj+r4Cf4z=dTaPN0odkYQSLb8KAmSw@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey@schaufler-ca.com
In-Reply-To: <CACE9dm-cNq+m04StHREnUj+r4Cf4z=dTaPN0odkYQSLb8KAmSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20381 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 7/6/2022 8:22 AM, Dmitry Kasatkin wrote:
> Hi,
>
> Could anybody suggest a good approach/test suite to measure LSMs
> runtime overheads?

I have used LMbench, ltp and kernel builds when checking the
overhead on the LSM stacking work. I have also tried timing the
SELinux, audit and Smack testsuites, but they all have built in
delays that make performance numbers questionable. Be sure to
include network throughput and latency measurements if you're
looking at SELinux and/or Smack. Also be sure that you have
meaningful policy loaded, that you're consistent with how IMA
is used, and that you know how your audit limits are configured.

