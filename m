Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA72FC55ABD
	for <linux-security-module@archiver.kernel.org>; Fri, 13 Nov 2020 16:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67EE32137B
	for <linux-security-module@archiver.kernel.org>; Fri, 13 Nov 2020 16:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tyfFxuZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgKMQgW (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 13 Nov 2020 11:36:22 -0500
Received: from sonic306-27.consmr.mail.ne1.yahoo.com ([66.163.189.89]:38356
        "EHLO sonic306-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726336AbgKMQgW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 13 Nov 2020 11:36:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605285381; bh=Y4+iCn724uI55i96dww3QZgjyryEiiZZoKaIY6eyEz4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=tyfFxuZpGpnsOCf+dnHq1uFJZT17rsDrffPz2jZdvEkZNi8quFL68wz508CB8qgzzctrqFm03sfSt7M725WYp9nD628nYvzFoUwjy8mbTUqSzrOhvkD9yHM/8e+3E6pfLYBJV6eowqXaA3tL1uxDnVqeqeuH0LXrrfa4Ow9xjph9yzPQUcW48GJsD6U1cKzlgNEab5O9D8fbPm5nHOpwxMO7vyjua61obQ5IJFBWW6MG4Dc24t3PcxS46Nbn0JPKubMD02TQ4Z5hj5czDOReJ+H4KscFP97bnPXZtEcqptYwFRxnmuf42mq0J3tTcz0q/FUYtwwTH0Cg7cU1zGYizQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1605285381; bh=rSpeutdKC3Tstm2tXBUlsitSE6EWXyizUTl+NkEvqiS=; h=Subject:To:From:Date:From:Subject; b=qPloahXMZJauMoZSrufDNY0Sl5pnghwtkcMwd4l5yjz8UxGk131mYzSV3dkB+Ja+REuhdroWsJqrtz4M2HXaHXABs5vgtRIMaudY4UxzgiXtvhcJL5sEO0EWIg0ECipK0rFqEeUWlN1Bt9iO0iWu+PuQ4nBS2CTLDqnwRnQVz30lBzaVzBazHFfG2VmLRhhR604Jhi5PeCn+ZvHO+X2XYmEFfSdNV8m8+9JWFAXXIp8Jru8gFqkdTyszJpHu+ljJeC4BtjYS93+ICNV9bYDplTHWAa2Xk38NZZLjRF/b8RQq+k0cgGAanc6Ig4pZvUo/yY1eIsJViUTc0htH0Uaedw==
X-YMail-OSG: sMmilzoVM1kRznCvWQTxkW2muEjxjVBt0Am8rnZMR231PemgS7_7hDX64PSeBPL
 kz06qJn2GjXvuFWR6zowZpuOnk5G91Re1bgJBHk0tDuOLRfSrahmCXe6_1BtSpdAgBYC_tcdU6T0
 LuVoMqN97miYbKzYoPoet97W6Rt8ER661.x4lusNpO_w6IU5EFoc1SZ8nPLxwSgBnEY6zKDc8OUq
 ibqiM0YcdgT33JZlO.O0azQT12VpMOXGLB.z6GMeHEkgzpI.FmhqPTkHp35p9iOdB9pMIWmQsOMQ
 gOKkxyn85LE64kxhp8bW9nWP0kMj8aTOvRKATs3X__36daocCvg8xWLZwgJL5ZXlKkeLrjkP69uj
 Mx1wISapFGk_G_Wp.Hnx_SHBsAQjRCUlbGYhdNwctsLFT0NMHpZYy8ss.xE1OZuwVYi69hXtAus3
 HgSbn5wRe8GTNzyemOw1KohrrqypJJvjdITgPgfZEkWfcjDzMvglt7nrXy6hW.GAmwDvQMSoOyr1
 RfkY_t_Sv4aOHR8AqnQ42TaMVf4PIu7FeeRkJZJzeltsorBfcbHj3X1yf9eKlMR3I6aju0T79h75
 s1sP6dDL.5xVhgjJRRwK_3TrjQixnNtVntT.l9lIFvZslDmeERENcF5NkX1Rmy5FiKQxsxXLIR0l
 H0TKeMgPi8jiLQlC1jl5kVhbYCB_1GLzGvfgwS7FROf8DpnMZGa47Ymgj3qwENXwJfDhz6ssis9Z
 CJFhxnGdywirH9kQqRk8PxQYBIsWkaTtEW56HYa4apeeplnZ0JGL6BFzD48xtiPon0ZCcDNtnCH_
 q.2Xr227HbEf4zr4rTYechrKhcNaRQswej5nRC3QBdGrcIZnqsQChSt0F9VXvC2D38IlTTCTOJEX
 AbY51TvhiQRc143B_WXpoHZLuivEi2zbIlyW.Wg3U0u10qilDZQ6OGclo4ikmTxzPgCwTGgYw_8n
 OJFcrp_BF5h8ggjqU0HrGk5lRlO_usGWGCUc0nXtwDpfEPYBKQ3IAMRItZY2jlnNGUQRUAfX507A
 lfxa2zqQdWhDypVfGdv5bB8iqPFlV8YxnFNlUP1NTvH9J1udRyDTLm8bPqFF98bWgJ6sOnWOv46_
 Gzo4jVLkmnQGatzNnYcI.VPsa2LrE_AnSafmnnymx482OW2rN2vURLtGlHuIz35XJ3L3dOfnPKMD
 Je4h1s_7ZPlzQfrvrXazFM_X7IFKhSzSDKRAPsaklJB9rb36Rcs_ztWwyi3X6NUnf.5o.xCiOIRr
 ulhtO55JpIEMnLgDmnFmrth_c95J9GDF_eqhjH3wk7KfNZsEb1KntKYwNM0RO.B8VRLchnkgxFo7
 Yp4HCDk.yH96d1PD7FDv2j1zS29714Cxdt9QSbnk9.6RYB0ajFPEvlPhlfntlyBjoTTh0KQEgZq3
 Gf2nqgm0czBgvRerTHQUSl50Q2SGIvHE0.skVR.ouka8wFWbOHA5m51cb4pUGKmLTMZW8MijvU2s
 jAQhVzuxKMdKZyNa1V6okfbaegubFz9FzmaYcQ8mEO5bwm.K_.A6aDFouw93gkIT.dLdLHhbMTT6
 .ia9H.JAcGRo_GOCTM4BskiPvrvxOWqd.5zRF73W_ynRUidvPRGBTq2tZVrOj.EQV.1rHTnm5pOz
 fQKPnqXb_R6N7EnnfniUXrYoxmDA2Jglet3LwC8OKvC6xPUzz5wj4KX1lpIK_UaFcwKfkkjlxDpJ
 njcIlHorZW_oGsjUH9QzozwXvEGOz5qtGanwD7VM7TV6D4qDtREVqLWzN5SJziDCwygdAw7qzwjO
 e9Mc__EEHI5XqioBuPJiT.S.qEWJ8uKNqO_B4L05JVHqSqr6k5gGCEWLMXdwfntKVEVMTOxtVeww
 A75zuyPMw4S8YK3drmQYTdkdppsrFfJJ31EqUWZcWKh6qv_d313qL3zHTJSNNtRh3AewDIWEig7_
 DbDR0Wi5N9sVLnTXe4K5h8knDDVITLcZbx17rR_5BIbLWQPkag32pOcM38LkFm4l7JYSm.48fhC9
 cL1TNArh0vwMJeqQtksFZfoySSCwhOVd2njKAbndnI47.ZzHOnPM.k0KfDVjrxxeDuEircJQ61tu
 naG_UcMUEI4dwhTFlSCoIsnIcgpSbl9RWcsySZ29LRLOmf6Dcx2FqbIBw5dZnb4hrOhjzcfIL_aS
 _pm3HU5TPprsud.JYel00PnYB9h6HGDNCwNei.oGq74ANrXxrb4lUy1Xh.FARYpU3QifXTJxDg_z
 pJZ.VrdHoLlffat2h1XpA5Ft8QUCsaAk1K4AKvpYzmanbM7oSSv8qWyIK.GiHDiOyfIadlVUF6bo
 WZaMdOepFcAdofsbLVaG2X2_dIiyfB3tgVDZ6WnN54tL.429l1Feb9PlCb.YfZQ5WLeO3DV88noN
 2FPsP3aQPgSePZqKGDvkjPeFeb2c2RlkVH1Fsqc1n7tW1y0sj27WTTqKQ4XufZnj1kaRXnKtQbiX
 ndn1fwSngifoRiiHUm5mnRyS1EBQOyIh3HOalbUHNa9E1Of5AHkNUviv7GDmkEQois1OTj_H_T7v
 EFGX9DiBZewYRNkBIJd81t.5nRgCzVwPUPMXkAF7nCpUiF68C1k.gw2ZvVjFp19dMDj1k1MVMWHj
 lKnfmzwq6T8euByMKkLmJ53mKsOXkGR8Ul_l_c7cgriNumHCozl_tn7kOy8misAhsdIFjqWCigEI
 76.A5h.q8CdCk9llwa8nMMFGsX4eiXY4zT68B3W_mO8ieKlXfsUtrn.MHY1Aaacp5E.WK6whNvjN
 IC7hCTHvaHRib41sdNCPK.jCtLCdtaCgAl3mqtlVdoIjTqKz81dtanzCNMK77M4FQmY6UPkakSqE
 38rbV4C6ZBTuH3Lw.mTB_a5PW3Hd8oUP02D.q328I8nSpWw9oOFAAMWxPJYVEuQ89hAmu_gPTDvH
 8Zqpyh2pIK82gVwJHgvBeVsYjTevpI980cYzLbQRlxMrjEaIAlZXOdBsxFYjXcZCZ2oMPkdO9ZFx
 kFgA.nG3iBiMSiXkeSGl6SNDf8Sk8ni2XePtbeO41TTmE.bHVlogOPr.rlSELGAhio4_zPRiZiEM
 8HQrm2w--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Fri, 13 Nov 2020 16:36:21 +0000
Received: by smtp420.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID fd4b06635296ae997c67ddb37194ffd6;
          Fri, 13 Nov 2020 16:36:17 +0000 (UTC)
Subject: Re: [PATCH] Smack: fix kernel-doc interface on functions
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <1605252419-64251-1-git-send-email-alex.shi@linux.alibaba.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <8f153b97-5f5a-3d47-ff9e-a3189f845f1d@schaufler-ca.com>
Date:   Fri, 13 Nov 2020 08:36:17 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <1605252419-64251-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.16944 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.8)
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 11/12/2020 11:26 PM, Alex Shi wrote:
> The are some kernel-doc interface issues:
> security/smack/smackfs.c:1950: warning: Function parameter or member
> 'list' not described in 'smk_parse_label_list'
> security/smack/smackfs.c:1950: warning: Excess function parameter
> 'private' description in 'smk_parse_label_list'
> security/smack/smackfs.c:1979: warning: Function parameter or member
> 'list' not described in 'smk_destroy_label_list'
> security/smack/smackfs.c:1979: warning: Excess function parameter 'head'
> description in 'smk_destroy_label_list'
> security/smack/smackfs.c:2141: warning: Function parameter or member
> 'count' not described in 'smk_read_logging'
> security/smack/smackfs.c:2141: warning: Excess function parameter 'cn'
> description in 'smk_read_logging'
> security/smack/smackfs.c:2278: warning: Function parameter or member
> 'format' not described in 'smk_user_access'
>
> Correct them in this patch.
>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-security-module@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Thanks. I'll take this through the Smack tree.

> ---
>  security/smack/smackfs.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
> index e567b4baf3a0..5d44b7d258ef 100644
> --- a/security/smack/smackfs.c
> +++ b/security/smack/smackfs.c
> @@ -1942,7 +1942,7 @@ static void smk_list_swap_rcu(struct list_head *public,
>   * smk_parse_label_list - parse list of Smack labels, separated by spaces
>   *
>   * @data: the string to parse
> - * @private: destination list
> + * @list: destination list
>   *
>   * Returns zero on success or error code, as appropriate
>   */
> @@ -1973,7 +1973,7 @@ static int smk_parse_label_list(char *data, struct list_head *list)
>  
>  /**
>   * smk_destroy_label_list - destroy a list of smack_known_list_elem
> - * @head: header pointer of the list to destroy
> + * @list: header pointer of the list to destroy
>   */
>  void smk_destroy_label_list(struct list_head *list)
>  {
> @@ -2131,7 +2131,7 @@ static const struct file_operations smk_unconfined_ops = {
>   * smk_read_logging - read() for /smack/logging
>   * @filp: file pointer, not actually used
>   * @buf: where to put the result
> - * @cn: maximum to send along
> + * @count: maximum to send along
>   * @ppos: where to start
>   *
>   * Returns number of bytes read or error code, as appropriate
> @@ -2272,6 +2272,7 @@ static const struct file_operations smk_load_self_ops = {
>   * @buf: data from user space
>   * @count: bytes sent
>   * @ppos: where to start - must be 0
> + * @format: /smack/load or /smack/load2 or /smack/change-rule format.
>   */
>  static ssize_t smk_user_access(struct file *file, const char __user *buf,
>  				size_t count, loff_t *ppos, int format)
