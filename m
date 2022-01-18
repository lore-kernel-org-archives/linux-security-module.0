Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAB1C4332F
	for <linux-security-module@archiver.kernel.org>; Tue, 18 Jan 2022 15:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346031AbiARPCJ (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Tue, 18 Jan 2022 10:02:09 -0500
Received: from sonic316-26.consmr.mail.ne1.yahoo.com ([66.163.187.152]:38060
        "EHLO sonic316-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345839AbiARPBS (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 18 Jan 2022 10:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1642518077; bh=26QAYvXgTAOsFn5g4e72n3EfJG/SMYDXUglW4TkoQwU=; h=Date:Subject:To:References:From:Cc:In-Reply-To:From:Subject:Reply-To; b=HmaF6+ZaIchgVDqenml6XUQRjytM6+br3BoQLMxrkMnDUi8bmM5pCLMx5xlNOesc5Ahdi2nxrLvaUbtzsZqd5UK4QYxqQC1ytGKAgvqK3FV0iFgKtIU41J/hIb7zKh5zLc1b4rOnEpPrbM2qcPimG0fciUbSNWEcYcOnn77MT+1y6LBmmSDcPaNSxRAsHAgJpdQZVBL5/T5F3wRj3EE504Q/lUBYtRqF5Pr1n7vn7WZtiu+tbjBJuaCXk3TY57l4FemsIIF/E1zZdWsYU6faoBYmr8qkyyDdlOjA6hJ1pp5FLv6XZOgRMBqQOHT7cjgpgRV5WeFC7k+sb0IxEM8+Fg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1642518077; bh=IERN5+3XpLmVvgnQOSHlCGGdF/tIUUL7BOP+LH5EGjC=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=HbvTE7chEOy+1gM0Z9fSXau7IkK1ujRaHE1XOEfCgI5In1SuzMvOrPHvdx/k/eUjYn/nBo3aXYKFR3r4vuMTA1vCBZALriTjY4CMHoaVD7zFKScky3Z9AcOwr6gGLEtsnaikdL6l+KIup0GIawC+fKj+QcNv7Dt7BkdtCz9nBGN6cmDMu/cOXEfd+qpWMlv90Q1CrVpZaE2cWhjZohQonAKDJpoZkPk6N5ZShxFTIWXbO96uIwkp7FS/4PgfLZWVjO+YdfJfqbR7UGgKNoF6y7mgpVhl4AEQh/RDlmIqlYJa99vbBUl/XOgmVurgrBbZ4ABsj7CkftWIPoE5EV6p2g==
X-YMail-OSG: 8CJTPYMVM1lWWONqC0tN5a.U3gsNVR3xWOo66xew5iaS8RacW3uIivGVhCaT_FM
 ob3eUVHUdAsdny1GF0rl1p4qJXOesl5yX761exIUVnh2R9VnObp.MVMs_UwARnaZ59jBJiJ_PKbk
 VLcVZUnHu0fclrAFq.U59ekRRmYy7UW.1tps28661nR0KhyTrwyMxhKBCf_gH.Ut4HiluuNPoFqx
 QMoJeFUmT_F2lDXBcuIQjNHBu0NXc_MwMO9iZiJqs1Iua7uTQnsZpdiqZ.7OuuC23fAKBNnGbhpC
 JD5qSmjU45Q7ilATCe7qV9lmj.GbVwAiEn6IANSSMmDMxD_WUytvDFnsn16b1GQED4Der4.RIYVu
 1fGyILyAXSbgXciMw.cj0tj7Rt0aPkC.HiE4Grvo8JJVA4jap68qbbp2mlpNr1WCE21rDTKl7aKJ
 dy8.DhNRFf73aAKZ0UWQzfh6r4_y6pNmnQA0U_wIIqln1WIHjU1LuL0GmJDBHlt4mhBxa7o42r0T
 A5q7MXcwYSqPzlDmIQXgcV4gWK8Iu4lX.ZAaHOs78O37RfCq_YNrTXD8._3Azku4PRUiBazQXtQB
 hKCrbtkbwzYxyxHnCiqcL.VVZeIElwKh0yC9nVGdpD4ip8OwTPp5EYFa5wDCf4LzpMsA1efQWrPe
 in4tlOEwVaXbQSBNjtNSecYg2NjHT3QeDZGV9HEJm94EONt1qh4rnAvX.H6bUUxDMY05RTblqgE2
 mcpbbU03zn50f56WaF9F8jD9ykYM0xEbM6pVYQJ.bz5DBtJemiKhM4pavKJXT2WE14zHN0pN3v9n
 9_j8iHZmRCh7Mj.bfr3UGKufjUwH9TvpeOPTeHolmgj.70Hlt3xr0SmJN5MQGON5wYCroqz5vITv
 nFj86LEToHTXLwmIAr0XvXQjRN4xd7hG_SDN5a.kEpHIiocSyVOc7Hff3rHfq9B_fNwwBnvQc81v
 uMDz1ZPaxucapTra5xc3StrBBWwXkrE381N8Ip_cjPfYlN5l9NLzqYiv3XCmDmudjFynqarhIk1C
 cO9QAquvKpVtfZve1BWvQN6y48pMRbrcLr.OZyCzedcMR4KOCHEe2n0MKcLaZlZQRKlf7_eAn_2P
 HwZ4wKM79erpY5rbNSE5li9U6LzKmkhem2_cJauENPYJWwPfY_y7z_eUf_QPmp9xB40fujoAH3_7
 .Rv.eWPK0oRQ3Qeh3KI89BPly1wRfodG5jYbWf72TDIhKgOC0IeONMOLlUsdXHcnTe6a1Df78WOl
 hxAsoDU_873Fcfwya_aYKuvikEpTk1xOwX7QgxDKrJrFOtQzviqgJULEDEt.1PHdxWVxrSNviwRJ
 E3_cc.OrTwac2ee73LmMM053IQPxeoM5zq5sWPFRs1n97s4IRFVjERHGTxexw1H7HY3661l9JXr3
 ETSCSfKzuHXklmyWC3DmMae00PIakihKyeYuCMbeg8ZymmniFUOSBNb45xfWxk_k3xspsV1wR0vM
 WcYCpw2gv4AJLnM5LjYBY5UJ0iqtWS17J3WGkuVwQDo2DiWuXqBNozhXjcDOedPqD.FMpz0fmt3_
 IlZ8Ab3H1fhIeLeuL_QXI8W2Ng5rKSOEV0LLDhZN6NudR1GnWPfOEzRY4w8ZxMogyPq1OdpZk4eC
 spYEti.L410oz033WZfyfvLU4OAErki7gRnIcLNhOxzWox_8frVkFQfapdt2hlUniZFk30qIEs6f
 xVV9aUDzMmu27v6.blQuH.yVWxZOmwKGKSBfWSWhx75dBGEFTjwUVJCp1wThQH6oRY2GoIhY4Zgb
 8c_Qt8KDyWOqq8L1QckIo2SdA6wUeupN9GkpW9t16uxph0h4Yy7SlD4xTs6y6zJjXmNDtdMHitwq
 kHIo6xjER7ydj6QIsh.5ZYyAj0jWmyEzw.3T090QM3rbIOCywVuHWgRr_qojE3tmCp9qhzTI4Sp6
 nxIsGTvWN5es.sG9KRJe7.JKl99znDeISYdX7mvXqO6w1ipTnQJGTg1ma4xxNs8w93uS72u2WpzT
 VQB3pxXqHJEy_R4QXWbUvqZOv7URbdZNS2unpGSgZXICdBUPJ5MDBRH5iaBCeTN.O9PExv9Ebu8T
 GO4TZtGMQvMllFSAZmkZU_rsYJ.pIpXrspCsIgR.2Gwh9JdZ12en3I4YQLdwfAyaIB6gG6XBY_8U
 _gv2uKkFA5YrMzqJslcbo5EGez.cBHP3B8zscN3y4J_wVU7rQwEiU6SnXYakPvSAiBsfC6IhEGCh
 4Q6m3
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 18 Jan 2022 15:01:17 +0000
Received: by kubenode513.mail-prod1.omega.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID ff7cc82b505993e5481c4f01cbf9d160;
          Tue, 18 Jan 2022 15:01:16 +0000 (UTC)
Message-ID: <bceace8d-b5ad-11a5-c1aa-9b156bb092b3@schaufler-ca.com>
Date:   Tue, 18 Jan 2022 07:01:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Why is there an alignment from cred->security?
Content-Language: en-US
To:     Denis Obrezkov <denisobrezkov@gmail.com>,
        linux-security-module@vger.kernel.org
References: <720c8d15-8951-3f47-60b8-7d2d8649ce6a@gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <720c8d15-8951-3f47-60b8-7d2d8649ce6a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19594 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 1/18/2022 3:33 AM, Denis Obrezkov wrote:
> I am digging through the SMACK code. There are the lines:
>
> static inline struct task_smack *smack_cred(const struct cred *cred)
> {
>          return cred->security + smack_blob_sizes.lbs_cred;
> }
>
> and smack_blob_sizes are defined as:
>
> struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
>          .lbs_cred = sizeof(struct task_smack),
>          .lbs_file = sizeof(struct smack_known *),
>          .lbs_inode = sizeof(struct inode_smack),
>          .lbs_ipc = sizeof(struct smack_known *),
>          .lbs_msg_msg = sizeof(struct smack_known *),
> };
>
> So, basically, to get a struct we take the size of the struct as an
> offset for cred->security, right? I can't understand why. So, we have
> the following memory layout:
>
> |_________(zeroes)__________|_____task_smack content____|
> ^                           ^                           ^
> cred->security     cred->security +              cred->security +
>                   sizeof(struct task_smack)   2*sizeof(struct task_smack)
>
> Do I misunderstand something?

There may be more than one security module that uses the credential
security blob. The lbs_cred value will be 0 if only Smack is using
the credential blob. If another security module is also using the
blob that value will reflect where in the blob the Smack data resides.
See security/security.c for the details.

