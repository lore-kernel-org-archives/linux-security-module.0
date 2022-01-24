Return-Path: <linux-security-module-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA4CC433F5
	for <linux-security-module@archiver.kernel.org>; Mon, 24 Jan 2022 17:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241243AbiAXRXG (ORCPT
        <rfc822;linux-security-module@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:23:06 -0500
Received: from sonic304-27.consmr.mail.ne1.yahoo.com ([66.163.191.153]:37443
        "EHLO sonic304-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244445AbiAXRXF (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 24 Jan 2022 12:23:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643044985; bh=EyOmU4NaXi6IT4rk2jrAcdUpoj0kvGUcZjbF4rkrDds=; h=Date:Subject:To:References:From:Cc:In-Reply-To:From:Subject:Reply-To; b=A/BymfdTD7mhFsdm7SEQkvq19G88Ev5pTtr5xvus28yiSsCHfk9EfTa8e8g3xoyvLozY0YV5/vm9kGldtm5A2GsvCXBhEQBKFi9ZlWTiAYYbAnCOP6idesyvqDwNF6+klUkNPJ3g1Hihk2QxtaObC+rUntuuJlZfbdC8yHdAuY90uWedNd+0wsyZT3jX6I1VJqntxUeNJGM9Cjk+L4gl0v7Kb/dUVJG6/rrp4A/VJkYd458CyKgXtNkkIwaSVN/Cfw7yJIUK2GXK0Q5kCI3dPBKpLJK//YmPFL6weUGl4O4YNc6dsSxrhPhaTx9Nt11jlRR3g2qgfTrcubP/HaKKSQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1643044985; bh=KRtiGD/v6bhwakP4RhKdGp5VcsXa/9qOCK9r4FtkD5V=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=HaiwtBFQ44WFwg4yRXRwCFvCjgqjtgTGsyanvKmF7NyYc0jKQ4aqdz9riv44zGAipXdH5YXNOdKj/D6x8eAMlY/tKhMAP7riF0FbhsOpzwQdYPU4w2ftBZBu+KZ8OigY+5688SBzZyyWiFCQImH3cLpNOFYL0E8SOTUjZiOd3CauPrLBauIR/Q/lF+VA1eqkldKGiz3QoeUXaXSdtCeXH6sBmm9HY1HArtMiiPYRwizbj1reC2sT+zVKznZAHCGaLgsETbHN1v06/WTH5T+oFKnGKs49Dbf4IFYtQ52Y7wmpOyf4ALIt1hB/NDIts3GgnNfCwjOmVdgcShKb9lLHBw==
X-YMail-OSG: NvwaC.cVM1nfMvv8AepF5h3DYxXKP88T_2loiD6wpIt1DX.UKcinzoZnCWiwy7m
 gb7kFHwPosV79QPAvPUh4HHJSt6H6BIMA2rqZdhixY7NzQ_eGPYGkkCeg6kYdgAY_p1yLCoooZs0
 Z_fxLAGpZsHoNCCindnKf50Zu_LthJPgsUNhJ0jCVkaVBbXSHmomNe7o7MNBsgZRUv3BGntdqAT3
 TKAgMcdzwIZSz7RrallbXdJb0sBSyfF_pultedeqAR_gB0Pv7oxuqfFPzp.A3M4dIdJWq9Ajw0cO
 H41jZvwpxPSNzlRd8_0DpU5rVaN2ztqv1_AFe2QrCpgpUv_AhbU9aK26H6sLcm45RstMd6lG5Mqe
 hVyKHRrLuZ.1P32nQ1oaLgHVUugyasry2RZqcJ850L_NCEei1c8qG9yJpp26AyaxpUcfDrAU7dho
 gybNJYTxMBwgrupKKx.d.AIydhdQ9xkwKTqcShxrVzGmquR4CWjCgJHf4K5AUhqM.AkrwZs5xbr1
 D538elzCpofVFoORTTBrce9mP.768y6AeTe79LLTPlHCHmWAopiB8eZPwooheDb2vaxKGtaROWIi
 XwOjHY9Jmduu_XM4swhCDTR6oytpjeqXEreEZv0P54ApteHtTD9DhGSdTBfDy9o3FwzuSD7p.6M9
 3TQmu6V2RWRNyVbAH4_HCs1UfH_gWADoG8t9uGudSfJLfVcX6mCd3BcRCmiyDg2IN2iiI0k.phpv
 4uAIBXYIqRAaaPrLt.u.QJMRdxRkhfl1PS99UZxsylLZm.dghMDnl7CBZdePXDcouicrUYUwomkX
 N_gNPBQ45D9.4ZrlRyIiDqXtm_yb8CI_EtJZg3n0ExEkJeeb0zGQHKu87n6aLPVPgS6hpItMJfB6
 N2FU3fP2LuLDg5KvwxcbRjuyNBmr.HmIBJilWhypQaC7VwzdOrvhheqytS9PRRF0pQffo9rRMHVt
 CTydI6_jzSpTPzORA0OMc4c98m92N1xbpDVGAZVe1dU0sA6oc5iKrlv_1Z1jzcVKF6c3Gn.kbOKf
 BN0i_MUck4eB7aFpQku_V76E3g74Jyl7tItFZO4wXSBeHq.Lx.xb2WdKY.C6h7bwfbBOQEAjKuaE
 AxapObnlMzDvtaveNOjIXmyhbrRwjSrqqW0VzGKZXd6hixGoBYWNzu.R.piii72lproRNne9pkjg
 bNv6gHWbh6PkX.5blLDoUOoipXfLh6_uGls2600ROPA0k0kiba5gJU1GRYuCQHI8kMp4jmDl11f3
 pc5D5.rKwvhq78Po0hTT.29XJuh2oCa4RAL_8k0Fyl2kk7jcS7eG6h96Xmme8jTzJD2_LQ9UmzgB
 w7lXty3370yvF_a69vl3SbNZ118Z6NTYfWRWbIbXDytn1T2KOG1Gx3RujSpjD2SBqcHWfXIBg9Lh
 1iTsikyN2yGUIQ.VXl4z9OSblMB5YbEezu208nmnG5iDbrl1u6xJP2Im160Ul_AtqdGCGhR8zBSN
 NOgDCwVMtYWLK.IvzKMpmGi5FmVHBRQNfQLA9is1p2ReUM2f.5sGuj6CKPIcYIGrlXqzFryb6tPT
 Gg4wmfNgQCQC2kJNr2f._wzMFK0mvK1Ps_l4f1eELdysuJno1WzBXSZTx7FiSLLU9sD.smBaxAP1
 fRT4O92LeO1CjDpB29BPt9aBB0zDPlb3rOPywiS.Y6L1kG_7Q58VD66mdl4KEaeZl4nF_nWeGQ1z
 CkHBhreGTlghuWMesDWBoX1BT6boNm.oSZ8QxJfhieR3IEiUoSAKwAPFNJQSn5jmhMTxb.2fhn_z
 sNhbTqXwoS.rhVbqRJPr1.l9vZOasNx5wwqVvbltvJttSgr_hNpFdvrGTXrof51k1s_nk01fTLcF
 oXwy15vpIiGUURWPx6WMEKyCdm6gJsGHgwkyf9XZtPJT6.njVp8J1G1kL39tu.fpyHy4al5Y90TS
 AsIx2c0qIUY3RDcj9AEG2Czjabhmpb3YxAxR919H3Mz0W6p33D7kHhDGINu9kurB.YmfsXlp_lFR
 lPKyWclfH.usEXywiIAVeskBL4NBaiPc.oXLpMBHDRNzPb1sJmUZhxBRQRcAoFL2be3r1GSFjr_m
 _rYAjylR3o0vy5YiNvjM3b97q66SBdz7AxTIe.iNRtOxs0y1R7GeUKeUEthrUF_7N7uD7Czn188Z
 eDMrwUTBtHGE2n9rKdvDh50uaff3Fo2fJ678ApYiv5by7uKGZ3TOre0nSXwnyATFq4HvjM9IJbes
 icdHT4rQX1WyJe89igVvlEKEozIVOnDlniCnqkomadV5UP2PCAxs2q3lvd_U-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Mon, 24 Jan 2022 17:23:05 +0000
Received: by kubenode532.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 62e268a0da2188161ebcedfbf152e101;
          Mon, 24 Jan 2022 17:23:01 +0000 (UTC)
Message-ID: <82883631-9eb1-2660-afe3-e7308ef1ed45@schaufler-ca.com>
Date:   Mon, 24 Jan 2022 09:23:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Custom LSM: getting a null pointer dereference when trying to
 access a task security blob
Content-Language: en-US
To:     Denis Obrezkov <denisobrezkov@gmail.com>,
        linux-security-module@vger.kernel.org
References: <c4cbfdb3-f904-b587-d407-268650e6565d@gmail.com>
 <028166ec-0921-977e-8990-4134b5920cad@schaufler-ca.com>
 <882d62bb-1cc2-0019-cc8c-cdacea31e8d3@gmail.com>
 <15530231-a608-8299-7dd1-a8b0155e5e29@gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <15530231-a608-8299-7dd1-a8b0155e5e29@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19615 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
Precedence: bulk
List-ID: <linux-security-module.vger.kernel.org>

On 1/24/2022 1:56 AM, Denis Obrezkov wrote:
> It seems I didn't implement cred_prepare and it was crucial.

Smack uses a global list for a number of reasons, one of
which is that you need to hang the rules off of something.
Also, lifetime management of the data can be tricky. Finally,
if every instance of the label "IAmALabel" is stored in the
same place you never have to do a strcmp() to determine if
two labels match.

I'm curious about the value provided by KeyLock.

>
> On 23.01.22 20:58, Denibs Obrezkov wrote:
>
>> I have two hypotheses. First is that my keylock_known_system is not
>> visible to other tasks (though it is initialized in a global scope of my
>> .c file). Second is that I didn't implement some crucial hooks and a new
>> task is created without a label. I have implemented those hooks:
>>
>>
>> static struct security_hook_list keylock_hooks[] __lsm_ro_after_init = {
>>          LSM_HOOK_INIT(inode_alloc_security, keylock_inode_alloc_security),
>>          LSM_HOOK_INIT(inode_init_security, keylock_inode_init_security),
>>          LSM_HOOK_INIT(task_to_inode, keylock_task_to_inode),
>>          LSM_HOOK_INIT(cred_transfer, keylock_cred_transfer),
>>          LSM_HOOK_INIT(cred_alloc_blank, keylock_cred_alloc_blank),
>>
>> };
>>
>>
>> And I initialized my KeyLock LSM in a way similar to that of SMACK.
>>
>> --
>> Regards, Denis Obrezkov
