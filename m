Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15EBC433F5
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Sep 2021 16:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FD4B61019
	for <linux-security-module@archiver.kernel.org>; Fri, 17 Sep 2021 16:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbhIQQdd (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Fri, 17 Sep 2021 12:33:33 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com ([66.163.187.38]:42270
        "EHLO sonic308-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232906AbhIQQdd (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 17 Sep 2021 12:33:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1631896330; bh=4A1ZHj2+WnLoZCwXh917BlyMu0V1duP1YFcW7lWT+Rc=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=dJKM3MsPHz+CIf4BUKg76uFV9DwYsr51MwXnyyf7WndEno6diXwvtGlKsGYDi/14UwNprGIB6TBmu79yA0VFSMZGEWl/j/Sx3vjYJjdUYIG7zp6zmAbZszrqN5mtH3BtCygfqOeM/hdfFsSMQShBBJuGrOQqUgWQBxZfmFOYKExv2goz+jMkZf/FT0kkUgTYgYFn5vDCZ7BA7CWTHkXN6OhsqRBMaoiz4hoGic3F1BshbyvIK1NC9Y0Gz64qjGGi6rOEQxnaSZRGbHe/WTgKSA7PqKhtWh1vTHXLQDKFh7JhMNdEp0OVDXIZgFmwx1xcoXv33OxzDCNBp4f5E4Zz0w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1631896330; bh=nDu4SDi7NuRbcnkkFMWCF7p/zZ2faZLTcebbCBXv76a=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=GTdcWMReJepwVjR/QH4YSoBEfYcQ0D3xlVC9zD8G0Uf/BFY6Jbbg9U4WrF0KJ+T4gYxMyIrUO+QVHjM81QV2ZDlDQWa8COwlWt7BgStn7bUlA7mTV9Q+APqyzZSEeuneQE3bKJUKg9Ec2MPk0Eo83rcfk88gqLB70PNj2ItnrFb761NkQo6Q0Sx7aLTxPhht/eP4rgstBqtXZbckO95BkZFYrCABVRK+YhaN6EmSV78hlZWQ1wB5erZ+r8GBaduwUnQveBjSLmCsuctV5CstwoL29+19Ug0OSBAEKyJsJ4IWH+enF+aSf0CWEoYtZke4x/9N2eQiLKHtPVa45i9djA==
X-YMail-OSG: DRhfd3QVM1mvUHkBJwjlxy2oG_NO_.4GtRLPl6q8153URF8m.j_j7GGNReiryMH
 4T1jWHHku.cIFYBypXyNClVnGZ_X7zJvwc5OSu7MmUQA24IKCpz8130pVRFVyIPK6rEWPOEEXgal
 oEj4RiDHnhOmT2HMkKgWXhR6Yu0GcPeQh06cqlGnQvk8uX6Tcrpbggym62xFpLHfxJYj9YeJ4xZ1
 aVMUod9AYghAYQf5ggCF9Y5eGj2A9YJLr4qZ4BSoXU7lsYs7D_nOCThYAphS64Wv56QdFQIdgFix
 3Hokqjmjjl9oyxXwDSNCRC6Hut93ESkt.GjEBKcE8vdZc_ZzEF9Ca49d5N4euJhd1E7RtyJ94fUM
 hPJfzgOoEgUyzifAaVZd4fn3J2bGeECMljW5064_uB2fs7HL5c2Oy9OA_XLzp0POpTXUyysjvQNm
 Ck2cttKR9a.aZDw_dVgXgOlqx5IQA0ILk09O9us2k9uHC7QIkx0lRztB4btOGvYT6RsF7ZVWx0y5
 iMPC2k9.pebOXMQB9n1WEAJC_IBvw_JhbRjmALG379LWDxxiCmYS3PuwMVVH9vvBjcgnFozlldsb
 W_iphH.HZWgzD7irhcLUJZQ5ISqqCh1galH_TkOaBG3Zgpams7tRqKeLoVMHKu1stJsCSm.w0XDT
 oinUgZLyyiWcQUf5b3KQaRytRv0xOqOZWY3KjXjdVo9eYK2i9xi5CLAgkUEAB8o2ueKdCs4XJUw6
 LxRMy.t61oBOZEMTAL9UdOCPkPZyejKyBKDUOwy.PkehkvuvGeDVZ5nZbgCcygtXJvaYTmaavRJH
 zVmqZpp9AlxMXwS8hkJhmB5EOuJwNLIyfKESATLTJPznbrVf5wJrVXXIQCTgArHWJAAs.BJwqi7J
 t.IAIUZOs7qVW76vYDTZk1VxeIYU_H1RkMDBsdGLNgZOGLBT9f9uePw4UqL609XLZknJrz46AtZT
 6ecqLiXB4jR6Xnb3CrALe5DZc9qPOEAoyuSBB25TorLjaxGv2_U2LmBTJcQ2_YhShkMutO6rS7Rq
 w.w_Rz8JyWbjD0ryBv9.VelerVJI6up0z1X3zYbMHPSQoDtxgKhysjNAsHrTNR88UBVQT2bEyNbB
 b8DO5hLG5D62ecFecwZtKMYBSTdTaYMVWuy22sKwyEg6VC5BVMPLtpKM9ziWAweIu5.p1FckwS.u
 P6Fx8eJZZxAfdotvTzIIbtlhEfU4S8lcDLKP.X9cNajfjuLY1DnmuVpJSTlKXtdr8rs4.EEdhZfV
 5ecC5HmpCcr99ysbsuP0GLM6_sckzFxAtUeo09mt3FNHJ7Pw0siF5XUDmATrFZWpFJB52sR_y9CI
 VSz_BJe.ydtl2Fl1UbMLpARClpDH5fJ5xb.Oqua_fsB7K._tqfX_9gI5WRRbyHvIAHXlEqa434.B
 nvCYhRcM7_9xCsMSb78m1uCAPY1m3QmMUuX7QB491Hc7Igfl2.x6UN5ko_oa8H1pD8uo8Jwix_.b
 34eZT90A.QgM1zO607eiALDqnkH0qOxStJV4cnG8K7LkSbTHPQ7c8qGn0eqkR88LibJR4kGYLoAU
 peqtRcbYhAE836yPvNn.nmgj4LE_6devZa1_idyreomMif0ybQZepGGZNOYMMaNUpo2Vy_Tcddt3
 Bkh2o7YmLYO7xaBOqAQah.9T53lnplVABfBJ2SKgG0GNFHwqh1yP5MdC4x.h7StY.yajhC6lUwZk
 7Z.A_IMwEDhHS0Ogip374iVHHQUekubnHSsA0N4OG.fPX2adq0Pzq0WQ.0AtxtNwZAyS1nVcHkx3
 W3nIVILyDoQaLx_Sp6ZBhs2604zoSQH1d.F8mptJaRdmCRvAVIHXRgIEpyldXbwYtB6buqmxFGIN
 PuT.YleZ2c9YMXTY9KJbgvUzKgxxkB3dUauhLd_LA.tzWT8lfuAPmORsAXnFLSWeyQjNpWkqVY3v
 Ss4lfMwxx_1aiwLTrx93Wky8cMW1BR._4U4hVNydmCDzyJhMNz_M_z0X2ox8WDNKE0.gmGWxWlIr
 vML5gT4nONGMGDd7Dk5gsx6RlFWZhLrdafIDLh8Mdk2SNzbc4HxCqHav2fxXCPDFZJzBUDclA52o
 b_0M8aHjBP9_Xst01pbMxYhEyIZkuPjgwBddNUD2wkoammfp3zzCCwle5bM1ML9vQoMWMfDIIczr
 fhzZdi8jkO628rhtmzhKDm4rtK2qYysL9ffaKWVICDyuuKMw7D_SQkrMF7eDejvgCHxW9m2oOxoC
 5soofK7PSwOwCdShg_x4QPJoFLZ8bh0mp_TeJ3dfUNYiONQgSoRpIkZ8rBRSdv2jpZ_Pqj4m4cXv
 uLyIW0Q--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Fri, 17 Sep 2021 16:32:10 +0000
Received: by kubenode507.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 31ab93786ddcb06000890cfbabd38e5b;
          Fri, 17 Sep 2021 16:32:09 +0000 (UTC)
Subject: Re: [PATCH 1/1] Smack:- Use overlay inode label in
 smack_inode_copy_up()
To:     Vishal Goel <vishal.goel@samsung.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     a.sahrawat@samsung.com, v.narang@samsung.com,
        Casey Schaufler <casey@schaufler-ca.com>
References: <CGME20210917073827epcas5p11a811c82ba4c748de3923a62f51250ed@epcas5p1.samsung.com>
 <1631864294-25794-1-git-send-email-vishal.goel@samsung.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <12b65513-3f70-7d77-d8b7-8aae82c9041a@schaufler-ca.com>
Date:   Fri, 17 Sep 2021 09:32:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1631864294-25794-1-git-send-email-vishal.goel@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.19013 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 9/17/2021 12:38 AM, Vishal Goel wrote:
> Currently in "smack_inode_copy_up()" function, process label is
> changed with the label on parent inode. Due to which,
> process is assigned directory label and whatever file or directory
> created by the process are also getting directory label
> which is wrong label.
>
> Changes has been done to use label of overlay inode instead
> of parent inode.

Do you have a test case for this change?

>
> Signed-off-by: Vishal Goel <vishal.goel@samsung.com>
> ---
>  security/smack/smack_lsm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index cacbe7518..91e50e5cb 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -4634,7 +4634,7 @@ static int smack_inode_copy_up(struct dentry *dentry, struct cred **new)
>  	/*
>  	 * Get label from overlay inode and set it in create_sid
>  	 */
> -	isp = smack_inode(d_inode(dentry->d_parent));
> +	isp = smack_inode(d_inode(dentry));
>  	skp = isp->smk_inode;
>  	tsp->smk_task = skp;
>  	*new = new_creds;
