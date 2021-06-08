Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51091C47082
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Jun 2021 17:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38E806128E
	for <linux-security-module@archiver.kernel.org>; Tue,  8 Jun 2021 17:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbhFHRkc (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 8 Jun 2021 13:40:32 -0400
Received: from sonic311-30.consmr.mail.ne1.yahoo.com ([66.163.188.211]:36159
        "EHLO sonic311-30.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232246AbhFHRkb (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 8 Jun 2021 13:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623173918; bh=rDp2In91oW0Qcavu6jkVkKdnWgTHGDN5u8KyjdK+sQ8=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=MU1QZ8t3O4WoGtL++7J7OF9v96f2r1FQfXIssfTlsJQvq3gOd00Wpx6iyGEhFxTZnt0m7a0DfuaCGplnLIgMXTlMW6kNdlTXOvo/hElHM1EcNc2lXpsHe8QWPd8WVRfuEa79L9w/EOipcZL9e1LTJEfQ31IJf1t7M1atY0hTJw1xyvadxdvKPjyOC1RFzrPgZ+cVxickFQZ31yPlbT1CY6f2oTXp9yeElDzh290AUb9oHHmseiEoaAowSjiwkQfnwgpKlBehEkjTvmxfjq/9AVhITJmEK5wrYIQJDcMiC6AoTqn2lBZlKOsm1z7kt4hUKaXSa9DOZNAGkMpdAqXI1w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1623173918; bh=F06JX5DJRZ6gOieKlkozBvQUXlEpm3A/xyQ0rQqRx2D=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=Q8ahxsj8VoawQw84vlGYI502xMjtfdDk6s5LPJwF5Z2xnJBrvWSbY0Gx4sWFkyawOVtcshFdLI2mOmIvhIYLa0Qbd8qxuY8hpYz+GVa7SpZWteImwnJsziYeujJjPWY9Dsy0k8yiOHNrj1qtnkxvKXDCwaWME54xMllzmDLEK90yvoao4y1EXmzeAC5kll0Pe9t7pIc/OwLngNu76iI8NxfkChub5kxBgr9/5O0/U/PQ6DZ8wNZyY6HTdZ6WjWmNQEdRQ4Jpq/vEqUH65xvCefC9eiFISYrzNv8FnqTN8JBZkjiPwDY2qRJLP8d6lzGII9v0jMSo7Ni0OymX56zILQ==
X-YMail-OSG: cmugGqcVM1kdsFJR0CUe7G_aJBP79dNR90hYm9EaEtFuBZ6c7BKT2q74hx7Ahof
 jnuwLkizN642OiLUJklctgpylnyza2tlhPVQS1tweIzVsm3RPTwhepMHG767hf0wwAYzxrgxqche
 KI_4h7v7IqM_19PCtM400_4xXu9hW7JWtUG_mVR6rrpqHzp9n6zHudvVjHK0uVxNda6nbyuuCeji
 cos03gM7ZX2jewgJez2H9jQzxFMzoGRKaA1v6E_HIuG3wPLGRNlD4ML1ynjQJz_jXW9uDgdf6i.I
 GmvSztElxJFL4w06fjcy8D.l.OpEHOCQdci6tzbpYg3650ZwlOxi6Uak6x05AuIgNn7B3gcjzHWv
 vHMRm2GTU3gFgIbAAvBBY9jcOma9ZHudo7s1iSy8R78NdLMsdTfikUC5oOzvg45IraHVEoKOMnI0
 EaVxnF9u2GxgHTNxZ6DHloI67rytvCmV.tbSARUmQ9KEY8C7pZqmtNBdZTIVqqiDmmSGoccKOhvp
 Add_Bd70vR95a1y5XDrkHVM6CzuqZK4n9FrQ7DQsTxSvNPhwfXcYu9_.3rdGwr9cxV2kYl0DxAw8
 peYdQ2ztWgrsqZZ7du5oDVWQPGkPaRz9OY3uFkkzZWNFrl._UvTwEvROF_UGgFPtTPpk_dH8nBPs
 uZZ.O6vuSFYpg9hlSiMwGKMCqy8slYyCsYP6t.la9jq1VhPscQTAMPqW4BkQcamjI3IOlg6SMD9f
 ZHUqLV3fMZVBRmnaG.TL9oe5bjGofxwR7ikYXGTLRBQ64WAbCeNRt_RH6aVQQ7SfJdEbcGpLUQRM
 XbK.QcksU.wBR9pNLF_prCdivLUR90ZibZESPbQU5oNHgqj5Udvvq94fTozdZ6BMqhzkIXvrr5Gb
 _Su0e5NFlAFERPk6.1PmVsTp56uX1bTEphM2aT.wEphfwjkZH53_G3grJSEbdeGJhS5yODki47Xc
 nVab6U6XZXNPigKYUwq4Xny32F0WjX94EqPzrvYYOZqiKSVCpqrk_l5nXfZGyj6TiiuoyrJ70rk0
 .q1KW6UqhA_DkXpQZU5mrcPIwObCNq9sVRmCxuc4GAggKVmZyzEP5ES0wA0HWEoqm..6RI6d0pei
 KZ6n8Agx5ZSc8X1qYoBbvmnByXosG25mw6lwE7bdv1xGFN5yWgBeOsJblrIVv9xkN6MLULuYoT0c
 Ny8GTGFq2JIvXy8JozGN_amxn.WIADI6e2A2Um_FcvYjdeF2.SSAEBXA2HmhAwh.UgaNrAVuRTlG
 e3mAURZMQThwk7_O3t16GOYVAgi0qxI1.nu6CIfE7P38w4Q_K_aZsY26fpcuIYP4hiJsFrxo2NZa
 mK3KaUrmU2TZumvOOASItOkVTdUXLKrAVm5Xrk4jRwKPPQUngf.ElVJfRCJDcrh8YhKrbu1q7_NU
 dk9EPxzBH0MMjiTX1HlD.C89B.pURg2ofnaYmsVpTVaB3CvHXamSUVY.i_cArismJs5lGh0wdn72
 NRJLJ2cxMEB4V1MOfuE.aowKYV9GWjeUIw0enCpx1wZhvM_0mC3GjY8Jej7j9gHUbojtqTMgIVJV
 Hfqbgv57T4tS1eRF92gGKTwpY4Mby2eM1U8MbqlaiEjI_T848ezn5IUyu2ds9YPZim.VkhpooVFg
 jGY1LxHscsGEWic57tZK_XSeFdLLXVAcSpzlNwXjXsIMTUHMRVf1_6vt2.kQY7r4Fttjbg0EWDWz
 kSzlCm5gE9yq62cg6brHihoRY8FS_0SYQbd2.tKqnddXxgc_htQ0a4Y9RnwETQ8Gdv33slQvfve3
 EcfP89cESml3KvB92hAxPA9Ao9ZFeIbsS1foSvvpvuhHQEvC0bAaJQQ3Yeh06BJyuCZ9y9d30MYn
 joPMkN3q3lIQKxElqnefU71Zv6gYKEt_wGonHthMxkq_n5HE7gbg1jU_wB0O6xgHhc41Sj2DzNKg
 wDOkkW4cKuaL0zsEpY_5cDBnQ8P4VwEnDkY45.lzP26rSLfVtQHnxRnGYOQUtQ5_4tQhtlvy5Hf3
 gt.rQpIu.fCN0kVV74fMoZr6q6H37r8Zm.URq_l3Y4OF26oYmmvJy0NNHf8h7GCu9SguGfVDMLlT
 Ic_irGhFcpXyapfph0SNzrZFZ.0MDPYoSmQJwecewnWtNhIWzkk20UROVSu6K5qU5C3XxikbUnCS
 klwubQRJeShYBOGzcB9ZW3nNqiLUaKHI.js_592UMzYAiFggwgO_9J3xyef2_lXkyKgeeRnBjHa1
 pkhYyX30jtpY_9EqvHRQnSVDW0kdYwbforREiobwlplMesnLngOBqmVQiH7d5nCqxTlnQ4xzlZ_l
 R2MHAGT5DqCRhq84jAcNup2u3ckpFIPgWCJIFz_RtV5ww6adhhTOBVTTpWI4xhk..tCvs1pXtXSZ
 1WdtYqZ1J2Z2teJhi.BoDUqp6NvvrUv7tXyIZ0kYWc.aQ7SHnFxNYM9kiYV92qgiGNkS98bJVC0I
 nh1y06YNG3K.aznBHkw8JDkUBRMcfuVdpQDQQmGXfVB9YXWltxZpi_a8B6tr0NNj7phRKH5kU9gR
 ZWIF9iAvpForsM8pewou2NxXMHxtzi_1ewTc.6dFGJFckmEnX7JduDHOABnpuWsTPR19myYVPZka
 Zc7QBf2RZUSgtDADx0rC4oUBTVF.ILcOHc8yROnMgeKNlgmUB4JHT0HhyO24uCf_E4i94y9kO9Zz
 Gj8yuc_21eYNlh81daj0QSEuM9GGso0UtxkpcM1qfGKTatLTa3P4PRBwwZEcPliiYqf38roembCA
 O_0LK2kWsvjmfw3V1AkDf3UK4OAw1kFO_ruuvCpxcPMnBA8uoGhY6ov1czN4qVKfSPd_2d3Y-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 8 Jun 2021 17:38:38 +0000
Received: by kubenode588.mail-prod1.omega.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 25ed10d87090b9e61b9ca9fee2b57cb6;
          Tue, 08 Jun 2021 17:38:33 +0000 (UTC)
Subject: Re: [PATCH -next] Smack: fix doc warning
To:     ChenXiaoSong <chenxiaosong2@huawei.com>, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, Casey Schaufler <casey@schaufler-ca.com>
References: <20210607035201.289393-1-chenxiaosong2@huawei.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <66f899ac-1456-f0ba-2199-e9924c9dfc58@schaufler-ca.com>
Date:   Tue, 8 Jun 2021 10:38:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210607035201.289393-1-chenxiaosong2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.18368 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 6/6/2021 8:52 PM, ChenXiaoSong wrote:
> Fix gcc W=1 warning:
>
> security/smack/smack_access.c:342: warning: Function parameter or member 'ad' not described in 'smack_log'
> security/smack/smack_access.c:403: warning: Function parameter or member 'skp' not described in 'smk_insert_entry'
> security/smack/smack_access.c:487: warning: Function parameter or member 'level' not described in 'smk_netlbl_mls'
> security/smack/smack_access.c:487: warning: Function parameter or member 'len' not described in 'smk_netlbl_mls'
>
> Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>

Added to smack-next. Thank you.

> ---
>  security/smack/smack_access.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/security/smack/smack_access.c b/security/smack/smack_access.c
> index efe2406a3960..1f391f6a3d47 100644
> --- a/security/smack/smack_access.c
> +++ b/security/smack/smack_access.c
> @@ -332,7 +332,7 @@ static void smack_log_callback(struct audit_buffer *ab, void *a)
>   *  @object_label  : smack label of the object being accessed
>   *  @request: requested permissions
>   *  @result: result from smk_access
> - *  @a:  auxiliary audit data
> + *  @ad:  auxiliary audit data
>   *
>   * Audit the granting or denial of permissions in accordance
>   * with the policy.
> @@ -396,6 +396,7 @@ struct hlist_head smack_known_hash[SMACK_HASH_SLOTS];
>  
>  /**
>   * smk_insert_entry - insert a smack label into a hash map,
> + * @skp: smack label
>   *
>   * this function must be called under smack_known_lock
>   */
> @@ -476,8 +477,10 @@ char *smk_parse_smack(const char *string, int len)
>  
>  /**
>   * smk_netlbl_mls - convert a catset to netlabel mls categories
> + * @level: MLS sensitivity level
>   * @catset: the Smack categories
>   * @sap: where to put the netlabel categories
> + * @len: number of bytes for the levels in a CIPSO IP option
>   *
>   * Allocates and fills attr.mls
>   * Returns 0 on success, error code on failure.
