Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E82C5519F
	for <linux-security-module@archiver.kernel.org>; Wed, 18 Nov 2020 21:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3D71246AD
	for <linux-security-module@archiver.kernel.org>; Wed, 18 Nov 2020 21:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WQ9Phpz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgKRVZn (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Wed, 18 Nov 2020 16:25:43 -0500
Received: from sonic303-9.consmr.mail.bf2.yahoo.com ([74.6.131.48]:44683 "EHLO
        sonic303-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725879AbgKRVZn (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 18 Nov 2020 16:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605734742; bh=bioqQLs4FnPXT54uPLtO9DQWvWLtuU1wvgs6Ela/2NQ=; h=To:References:Cc:From:Subject:Date:In-Reply-To:From:Subject; b=WQ9Phpz9M7ruo9tMNkjS64y6dtX7DvOWjWBPCfhx9F4Ejd0EHcE0AR8bXSXk83oDxrvpZlYR8qsVAci20258WqzMHCuNgl8yfQrGmOmR0STzEKslzC0aVIN9eelQ3zdhJ4mhvsXG9mU6JbFRn6fPvCK8dtc6nExN6DcGAWWNouCkNSyfgBz6u7SDygKMf9V0IYNMvoh28eu64jbWNDzcJ5A4OaUIO1CacTMLX4R/aIR7FiycUWhZmg2VhVxJhAEuTVti1UKBvZt+GUBH+br5JvyIfquzG9lqewBG2FQCsqcio5Zm7zCBsqpJe7LGHlVZExJVUdUUmFp1yvdKfTFlPw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605734742; bh=g+pWJ8WwyI1ICMTLr26VYhf2Z34zQlrRkLza44Rwkcr=; h=To:From:Subject:Date:From:Subject; b=KsmHOF29C9ANmPzlN0Hlhm6QvonBXmCySgy6n2md2Ygnu1sLMn2U6ZTGSoSIzlTny6gopwQTX2TrRPSMndAEzPInGT2Y3fxUdigkz2HhPL3LEbFsfDtq8fATEjdw35gF90MSm3ku3Ffxlwj7ozCXUe6Z/+KGdpVxPi4suiY734xl92ieP3mPnl2ogyegxn2cXR3grLbPHLmxLKc/hz01IJ6b6a2dag9tSCSNb7yinz/qrwmoXPJNCYViAaEOAav5rucFZZID38wU7Pf2J/Iuf48LznJRwpHTX9HPteo6U0E4FEL5l6/XpRknQnmEZ8G45Fg8CC8wYnauxgfn+WydyQ==
X-YMail-OSG: qxOpfZgVM1mXPrB.DMXPDg0AY7LMNe37lAOylC17yJDSj4LhawGa9Hti35dbf68
 O2SNwTx.yXQbW7fWyUlxpZ9izMNUSkgzg.y7RnWKau.I_WKeLOoZ1rAmkvyS8rE8100CReGyxC3R
 tnmlkNIHBVCgyurpH2BJX7uaaIECyBbBhe3Dq1ptFz9r14UGeosj_HkA3CyHdfR440jLREDXoODl
 LYuMC7RwX7s3BCZScRnQ02H_uVzlNKNp8LfV2MYgwEtI5SoDswVEbZrA1R_OQiusJngF7gwo_3qG
 VniqFKDNzVT_hOFZpJ8Gfk8FrYZpO2F6IECQRBjFjvOvG5_DMBHsqhrUXldlG3BVIr0HSMOKAzIy
 wlUZZJgGoFDbBt6Y1pn7aQhfN762_bvIWTR3k6n_zs3Ycy47M8Wf.L.oo0BdHURHDLq1BaLrrelR
 M9R.dd2tkPub6Q8PEb9OrYOwPJTAHR1yPFBxxSB2Nny2dMYtJ1WXhtBNhCl4gRkXxmP6QrA_1zlJ
 Ec1dPAvH0wT_JyCb6UMbygjoEa2Q2tStPklKcp9HwvuvAkTQSwAmjiRg9q0zRFPTU3vYlThbujaj
 ZtlePWOVEY.7AsYrkb89frDE8DRm0hsiE2T2ImBPrBUX.amLI6VCXVKyG10NNM7he6B_qxgKwhU3
 id6OsQb6F0YMDnqETCy8dbviezOc1D0Uq8C7eCRaX97v9GN70RsD845n9ohy2TBwM5zj7XLlh2MW
 p16bLXsuVdYwQffljCebMFNvjzU1cPO3.O6.MUj_NWvX4O8L.yQC.TIxBsnUt27wRkF_OGgLpH9G
 wmVKLR1Hi31TEckxSEyPwpEuMAwHH64InI6XsyA9lzryNzm49c0iwz2VgSsLcfMHbBLUip4shnlW
 V3hZlJjjoer0YBnQ4vfLaMGSRq7sdzZXU9.0OqefW.15sdbSbF6Eh7ZYsCFDnmW5.MKWdF0L95U6
 OgA8mh.zG3dXD7KCBvrWd1_7nxBTOeKPe.kJNa5mc_WZJmYCRNWvShWo3ytSMfpJZq5df_DEqme4
 sLbF7K36_jw1WfjlitRcoTjpoHFIeS9Q5Fm8SW8rvqw5y8oLE2IdcDXH09alzM2AvJyDhGy.p9p0
 W6AfgV0AjOpsdHZCCz6Ne0oLVzo7e4bGPqBPRYwKcX703s6hVuJ2b_I8YqyVSy1929TtAqpGs5R0
 xSnRJW_JmdYu1zo4oXZEWsCJg2bKAZO7PMHndOu3KY30FBWdd.vkeaBQ8DWhclmPd6BjbWIGdz9C
 qO4pvzLhMJDuXAIphR1gTzBRc.DUCfBqsaobmupD..R9MqzOOU_i2KRct7b.hdSwjoQPmifFvFC0
 1f8LxqoUEHzepEE9GVZ8FAbtwDEBr5dv9m51l4mKM00XG5ycM_oKoZcVyEBtsvPwDcXac4K9HIpR
 h7G3Q4sVfWFB9FjO6G1DWdszuKHaqAtHhon8Fy.Llu1hOxCnwW1Wy4Sn1rFja7962hw4SptcmYio
 9mHZH4WZ8dEzXwi.aYk_N3oIYLCNCtiiDIxk.VQdFiBz2kKswF6TmIgjDVygd2YTi_Jpb5m_2bMq
 1sWCL_49Ou2vxyiNVsvUsxYLDCLCmQ2elf9XoF1jDHMapGhX0psTl8HVrQFGAeM5EkgOLOeklDma
 3IkyjGjqsUP8LFlZrM1H1JJ9FHfJxZS9sRRdkR6.wbf3wHCxctu1o_pGFqddEb5J3sX2rCDR9Sem
 9pSdhavyjtOHm0GkccSQ8.WuD7Y2av9ftz70Eg6SHsbvsUv2EcfgVBMt05P.cG09c465vTGfs65b
 fbZKyoRn1mzMJ7c_GCR7XoFlD0g0flb1KUVJ3qlb8aZfTeb29wllx8nTEUvGekKbqXEeiZRVccI1
 t_ssfIuULR6rAHG0dPCGjmbUB4myTQclJYMr_h71xiuRzdATyF5gF90WfVyewZ_7MSKmDIHUEwiq
 OuAlYQKlrVL3LoynJP1dwLL1PLrilcZvLkDFvXampZ3pntCkd7BxfENSgG0.BCxXnlfO_RU.K.r8
 _mPPY4NMwK9_xAH4uN0rUF2BK8esWouoYTCgRuEy5NWZPgtpz6fxCUaOZrJDDFzVgDidIL.Gptec
 sXjCkgR9o2HC8aL1xb3N2iyy.RI..EhNLv5zFrZVloJ7hWsRYmtPyg9ioJ06kctGOJ5egTmJ4huv
 mqe3bc32O6.UTbSZ1aXtxOjSKhU2WET535ZJTc8MVwYFyRhfitCyleZoHlZaZ1GbVroTqeZ58OmB
 VLXGSYHR65nUjsthBeZBQwwyIxMaLs_.kuRATpJd2t0mr7Q1QhuO9isG39HG.MZZvF_OijU.OrxG
 G_4D7RjtBAAYLTIQl4u06INwUWvlUUTipgcHDaTodl6XU8OUn4UtNbWKngtN3P_NE5miKtcF6fny
 BPbk6uwbVjNYpcO84FeO9AvXiybFP43xeObpetS2CvCwru6dWrEbcARYUhlZV.lrz_SiFc4.q5wo
 KyNtF9ycJBks9xqDnx69s0kiGZ7OzErybz9.JgNnSZsXmRF.GTcZfhiC_GMsE7Qw3SjKjdrUyXeh
 _KIyZ1prCtgZY9cM7Zrt2Iy4NqlgVL.R07dl9_5UAoQy0CJlFhonuLa0WGYbuvzAhYCJIsl.Q2WT
 0G0Jw1ebXwCaCr8.N4R4ZQaLBzxpepbPG3BR..83rIEo8dFEUZ7tx5r71EG6KSyPvpJybLv.yci3
 sIOicpE9t6f3xiXFRHZm1WVeaSoYyc1bQ4asXDj4YtPHbfzacqRfNkpxE1NKPJ4Zwk.PsYq0dPKk
 nxK64WzmqGIvAWxUDNSp5zdLMppfHE9Kimp9HJr8w_p0K_RjG43kL9zeKea8kQQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Wed, 18 Nov 2020 21:25:42 +0000
Received: by smtp403.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 0570a634525de8507934b2aae41d0407;
          Wed, 18 Nov 2020 21:25:40 +0000 (UTC)
To:     Martin Kelly <martin.kelly@crowdstrike.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
References: <2bf667b20edc407786778c00b0c375b5@casmbox08.crowdstrike.sys>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Question about security_file_open contract
Message-ID: <593aa790-010d-61d8-a150-92e4b2db0086@schaufler-ca.com>
Date:   Wed, 18 Nov 2020 13:25:38 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <2bf667b20edc407786778c00b0c375b5@casmbox08.crowdstrike.sys>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.16944 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 11/18/2020 12:44 PM, Martin Kelly wrote:
> Hi,
>
> I'm debugging a thorny problem and want to verify my understanding abou=
t the
> expected contract between LSM and kernel drivers. Specifically, I'm hit=
ting
> an issue in which the following occurs:
>
> - A process exits, calling task_exit().
> - exit_fs() is called, setting current->fs =3D NULL.
> - Next, exit_task_work() is called, which calls fput().
> - In response to the fput(), the filesystem opens a file to update some=

> metadata, calling dentry_open().

Which process do you expect the file to be opened for? As you
point out, current is being torn down. What is your kernel driver
doing that led you to think this was a good idea?


> - dentry_open() calls security_file_open(), calling into the LSM. The L=
SM
> crashes because it assumes it's called from process context and thus
> current->fs is not NULL.

Right. Without a valid process context it's impossible to make
access control decisions.

>
> I'm trying to figure out exactly what the contract is here. Is it safe =
for
> an LSM to assume current->fs should be non-NULL when security_file_open=
 is
> called?  More generally, is it safe for an LSM to assume that
> security_file_open will always be called from process context? In other=

> words, is the LSM at fault here or the driver?

The driver. If you want to open files directly from the driver,
as opposed to from a process, you need a valid kernel context.

> Thanks,
> Martin

