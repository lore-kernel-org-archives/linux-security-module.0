Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA79C07E95
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Jul 2021 17:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E78460FE9
	for <linux-security-module@archiver.kernel.org>; Tue, 20 Jul 2021 17:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhGTQz4 (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 20 Jul 2021 12:55:56 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:41764
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231735AbhGTQzh (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 20 Jul 2021 12:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626802575; bh=/n4LHbi3giDTHUJ42v1q1asZS5RAbQcZRXb2VVdslD4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=Wgt/xpFV5tuefVsymw7gPCjaSZtzPh/sF21v0n2h/EkocXYSTiGNaeXGvA66rn7ARC+507F/sQr32BO3cAauKBWJO8h/oLZwgh4kDoEo7hY6YTKXAh1yZ4Cp4wFO3BPDgWS7KKk68HvRBsI5DZyLcxxHggECgMnNf54wTMCS8j5KUqJvsrU/5SZqHOQqBtp+jBqtX9l0nj+t5P0tIegrHnJMdSnYZiLbjDo8mo/pF6WJo8QDzULddx6EpvvwhWhhbUHMz/VMStnFU0Bd4Wo5fAwXLwuJlYmzXrfdwM9MENxVLSwtpBl2U+UJrqFPvsP9g/p1j1luWGl3vDOgOkOxKg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1626802575; bh=uUX4AZucpnuNia28nvRAdRggvtAF3TeXJP+RZySznpx=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=e+blWEEH4e+rkogNHcD7P2K+pfITUFG4wDT9gVFDhyRvgJA9VZj8hdiqC5jyevBdqSIud0LbG0+tUmWs/f15rmxHaoApNbZ0Xw/9Ntj3tiQGdk7bt/4tCzNGmvzGipSZBmu1zR+cTb7XYamI4Jngo5ehaji/aY5dIMt9FfSyU8cga7na56mbXKXD/AgzPfLQ3mjGCYTlhb+OuvV/ZGdn1bEKH2MLoUD/OmAsw/0FGI9BZp/4myL6pKIv+87HeV41z9vL0V3rpeshNQmjlLTye7qgRniSoTt/LhkxMLeVrllUfJnLoQx10flNKklTm2v+RW92b+EtfREBLbSF9G4nZg==
X-YMail-OSG: 8zvGT34VM1nnj.d4yp7rCGAKoTsoO0d8jCWlYqi305uCFc7MTeGWkMJdPkiC340
 NJ6YQNIM7xByqQPsd0lKAtZhzUCKTxh68wM2ThYOCUKYhZIiYYm6wvTUPBmV27hsXmd.fNSfHoG_
 0Uz7lSImZ2.8H87CxzCqujjfIEPZsrhAGWphDdCkW1yvDHxql9feVvAaYKgq7ifQRtEyNHyjgQou
 r1ShJcPyUiVLOIhecIKXWpa.SYuZo8CQonKX6pCHTp1_wjp_RXLP1dPFmQ5w1gQoHZRslwZlcWTX
 B8.4jFM2WCG28ZgP3xMIk9_zDlyjvGRheGSYxDMYT3cuS_tDOLEe0wsU_WLk5rPbujVxkDqs3_Cu
 LYSFHezQ0GAPpFZ130SvVty_CTn.MHapgtZaHhWdD_yRD19l4a7jTqAyxsXRAGXcBIEAyxG68nVH
 AWYt7X.jhHSZhlxRCjvJb2D6SFtv1qZdDDPnM9I_J647i54MFWDh55.eXwDtDroDYwMoY_p7F68n
 gIkar097HstOegYYJZN9f3cSoyHgqTXkLsAAMOq.mhKvMd0XQopMqoQ7wAWczpJtO4H2UDke9iJz
 IthtrSh_Bnm4cwvff_5pr32wRp2TVXSzoJm0SSgLrmdMkcbjoWFwvDHqlPW0m8Az6Lk26W7Fst85
 Mq_gcfYuO4543moBZHzq6K83bqtyLnuchQnSwNGVczLjOUixiTUXEQOFWRKtyS1Zr.Xxe17ee8kJ
 j_5fLO5mOa5q9a5UbiYTrajqLXpdMKvhgWwCB2ZpBV93JiCX1D_vMHFVhdFhlmlNNUwa0CIv1kft
 G2YpdTPZyEwii7g.O3DWIq0CREe3ZR4kR0253KtAU2YmdRZpCfFaq_iLd.3VqO_PQp6R0BbtzHY2
 UoG0Jgdut6LIMFQ5Pqh6ndFXgVSvLvaR7t0AmscN23t7Oum8zxIYsp8LvmNDYezEE2oEm4Lj3Btv
 AWESKzPLLLz_XKpT6_27_ipufqbrRL.Y6JpmYDuu8pPlQRThSsR4NwRbTM.vzhVtqgeUVEofSeuh
 1Gn1iatSXIKYEPVPS_2GtN93Dy.hsAUNtghO96OTMbp3ivq9WceYuZ8tQyrgQUzoLfbrUZ8ZiZ2K
 l1Pbn12Fh9WJCeCkXckKY7m_BMwdxJNHKWb1GfpBIZhHrM0rnj91O1k4ZJUkrutkln39.kvQHuuF
 rFSiact9UN.EXrarbs7jZyjISYV80eKMpbhEOuQDozkFjgG_QVSPsRhgBLKnxJh6suttvY80mwUi
 fiK0ffSLkYskSlOXTZr.rHjqXyUNUGidTMhDpdaSU2Z1KSOW0cBab5lZNpyDwB5K4DipFUNmzYLa
 uCe6bV89kF5HRQS10ArlUztAxznFVGCc4MrcNHVDqinBbW3V8fhmd9gXQ_xEWrz8hW7aV4ppgKs0
 .t.RjP9_uRp4fjAm3Be.Go2L63DawZfCf6IQknWZ5mSlYgTfrd16o6_7nm5j39CyzpdALa5uPVMQ
 aD3_8JJCq2qjGBA9ICjm591pjS8BgiJ8N4TwcIPpM3tBYPeVQxpHtSTReIexuGcY5lN93p.pVUzL
 y_LUP5v2l_KR_OqwE1Q7cYy8fu6bGYJJbOS.zPjkJTn6Wy6fd8A.RnqGfJaFci4yAg7CNFfPQWG4
 5oziB7gC.YglMawaUwTwjuu5PoOD._JNsRHxS90zMhxSrdvhg8LgGMorS_K.1Sa7Xg2_apdtEPAY
 _vkX.spkQyp7GxHGXqDaCcqGS4Mze_cpq27h1htu0e.d1JJiBX9v76SSrJvWUJ_Od8h47RTfMgBp
 0r2j4B54MQaavkRT7TxD2sWWFp3OWV24gotUIrz5HPjmalkY9eFquwVekr9ae5QFZXDgmQXkE2ik
 1DG2uTo3ZlhS8aXS7Wz.jG2gcahV8yQnHME7ur95N9PjfmVeTMAOe1KdpGiure2nhkYPiCeyGiHs
 SEP4jnRYBmKbIvl3D1nbqZKWSPBggRGH5SPIJDYCDs7JZrAynww5.xh1Bu_s67b_VZaiWEUdB5sR
 mhXcriulO37WjU30Q27y2qyBLWtlSZUpOxZtV_HvXBR_K3m7hfCSdLywXMTGg_p7T5O6lRHVB1f4
 L_BMyU532O_2qvF91lT04LW_1T.lfbawyKpotOXTgNBjnRrnWJCUnbN9tXrJ3QFu2W3mAxbP7Pv4
 U9wiPZchb5t33Hm_sJjddEfhoKrYJOEwyaE3YcFAM4YNneyISPl3ewUPZP8Mo3BNiuojOk1.fxRd
 ZpoNH5q0aKpISvxU.KtkLZQf69_VEbOU1EXs4WNG9ACdckVh4rGMmAHS9atuRrXWaC4LyBK2ydci
 aq4dLW.u..FaA_UrJmsBNPkkSYcj81BIuvkCNG8E6gVt0TIk3Q1lhH.dWQs0oSF0YI2aKOR7Cj7O
 1Eu5LHnru21Of.tlLf2x.y.RObGshizFJcWTqsXfoWJpKOQ.FhZMD4ihaUhwAqDulQydFDqZm_af
 V48A7OIg06yy2AXEP3NhNzBF_HjJat9J1IF3dxUfEeqFYgbsnXQXQAuIkJ59TYHFwETsp65o25LF
 a4o9WvYGHG5OYG99lKw7.17e2I.XFU9OYmoqV.gTnDVwM1FhXlA4.wxjm_K7rSl9BVifc0ILRYCn
 qDvnArCtgq5yO7OHkg2q.t.ttUaiaM9.FmlmtmiO_EEyD0Bid54L4lhGfPNWMBzEHxNgB3sO.5dB
 LuPrX3RIxJ0cF96wH6tMAZq8XY2nLh.TB6idkfpRBsNrip28gE0YJ78y0Wjj4pURnEY89esDPC2D
 kTFLMGPNh0mpqYC.T7fEAiX9.csVUDIE47hKQn7ylPSiE6MS65GLGtjagfOgQIfxa9ZgmYAC2KQ3
 .ILQJTpdV_twjvIAYKBP0hiadYf_djkS7YXEuBXzZeGY-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 20 Jul 2021 17:36:15 +0000
Received: by kubenode540.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 5e3fa3b560ad2290259806a07b8a0230;
          Tue, 20 Jul 2021 17:36:13 +0000 (UTC)
Subject: Re: [PATCH] smack: mark 'smack_enabled' global variable as __initdata
To:     Austin Kim <austindh.kim@gmail.com>, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210629134144.GA1168@raspberrypi>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <bb96cce2-f7b7-0441-40cf-05dd8754635d@schaufler-ca.com>
Date:   Tue, 20 Jul 2021 10:36:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210629134144.GA1168@raspberrypi>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.18469 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 6/29/2021 6:41 AM, Austin Kim wrote:
> From: Austin Kim <austin.kim@lge.com>
>
> Mark 'smack_enabled' as __initdata
> since it is only used during initialization code.
>
> Signed-off-by: Austin Kim <austin.kim@lge.com>

Added to Smack next.

> ---
>  security/smack/smack.h     | 2 +-
>  security/smack/smack_lsm.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/security/smack/smack.h b/security/smack/smack.h
> index c3cfbdf4944a..99c3422596ab 100644
> --- a/security/smack/smack.h
> +++ b/security/smack/smack.h
> @@ -302,7 +302,7 @@ int smack_populate_secattr(struct smack_known *skp);
>  /*
>   * Shared data.
>   */
> -extern int smack_enabled;
> +extern int smack_enabled __initdata;
>  extern int smack_cipso_direct;
>  extern int smack_cipso_mapped;
>  extern struct smack_known *smack_net_ambient;
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index 223a6da0e6dc..cacbe7518519 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -54,7 +54,7 @@
>  static DEFINE_MUTEX(smack_ipv6_lock);
>  static LIST_HEAD(smk_ipv6_port_list);
>  struct kmem_cache *smack_rule_cache;
> -int smack_enabled;
> +int smack_enabled __initdata;
>  
>  #define A(s) {"smack"#s, sizeof("smack"#s) - 1, Opt_##s}
>  static struct {
