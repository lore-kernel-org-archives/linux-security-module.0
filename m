Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3991ACED9
	for <linux-security-module@vger.kernel.org>; Mon, 16 Jun 2025 18:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750098990; cv=none; b=jZAUtH/NjY1j/vOaPcFDsGa5ukTc453oBFdhEb9vQGawQzCUFXVkE9lylRLdbABfQ++wDXL0k0WNUM7RJFXCcrXefoFHup0Q4A8Ff6HohxPwyebcAT497o2BMp0EkNAF94aK7lOncPoSgikDbdS8Kej0v94wVze1FSsNjqGgPGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750098990; c=relaxed/simple;
	bh=4D/Hz9vAgMG1taDcObWcJ5/b+dxMILNk+x4sNQDgczc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MtxnzmJ2VajFgOn3Uko7Og4baZctSRvpZOHu1DnGszVuQweqC52fSDoDIedVVgaVsf4ogcnXBnfiTM7YwgB36xqke6vdNVSPrzzeYD0yyQeM9EKtIoJUb5yewbmzBb3FwCxWNQFeNMnLlQz51DwgeH5Xa2tG8FguA5NTJUlTNnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Ij04C1eC; arc=none smtp.client-ip=66.163.189.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ij04C1eC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750098987; bh=4D/Hz9vAgMG1taDcObWcJ5/b+dxMILNk+x4sNQDgczc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Ij04C1eC9mJqxv/t4TSHYYNmtBxVBl4n6Juy6BcbOVsUYLfxmEANQAIwQTK0ZROAv9REHnPwPjPE0ow/F87hxckFDAtO3L6KkDcRnGjGqynL4Ti6oALejFNkTQvoXV+sLkCFJVezpRSil0iv0U4JR/21pDE9L/gHpvWn+2C2j1awiQn0jR2v3VefsmQBizI4yi3872hgLzRKwqRJqQds86cGWkxdfqSTf4Nw4y7obO5OOsorilkIdk9qNDrMe36T99fPjQ3X25BVj7ztoibv6vSyZ2imZmrOigz9UO2Lg0OmBTGLsguV2JpE8hUH06k9cyaROTxzp08R+leHP7mVYQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1750098987; bh=ccAH0Q5DuB0CrfGEpXQAEzSAmzPiMLW9pvCelfM2NyV=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=FZ7eJc0ISBDnmSzaSiXw3CzlFGl6Q5FOl8+NxfaYia+jlD6nE8h6Z2yXFl8ZR8bOXP1ZZTCc+AI7H2Ov+BF9jJmXDq1EVANu0gU89V/mb4S+HKoqk4yOY49betK1c18a89K95sT9LcHaD1Vet6wLSF8VCNUjKVnQcA2MFpDMcnCBFHpwKGqZSYq6eK1hKMWGPalJar9Zu7RV34cRliKFul4TuK/593Z3/GlGs47LTPZU624zbZqDIPQuFf2MEi1427jC3T9OoDYeLA5SF3xXkeDibSXMpyipltsrUddLVOIpX9rCLAyCbsdOtPofT3n+pFGhA/OsbrCHnzWNWhbgBA==
X-YMail-OSG: RfYCN3oVM1kQRgaE7u.lE.z06FrN43FiBWCk6gfmU2CMNxvKj8yrIYPuHbzEnTz
 40UOmp6FchJmpH0WOE_SY3ARnm77CMkVPzI8nU1YQC5G4.lcKzi2rbMe959zaZbXWtU1d0AcH5Ex
 SNXNzTwJoTxhaIXL4DuIh5XgyqzbS7qmt7Kd8IGhMS_okw_GqDrgbgZK8cU8CVIQ_b2G4rZmve5y
 nkRGBrwVQDG2ffkPrhJ4011hTP5vzzu3kYqqRMOQ3ZOEYnfzD2NeS_CXIKyWb7.80RAR5nDmmxU0
 M3J7dvg989YtG9P336myAFmEOZK4HzYMMpSXwvi38rg40CjPN3vK29eOaL48mlmMWl3vEB.tT0fl
 t0diMrEbeVPcatWFhaLqjX8lNO1MhApAw0bHV9xnCEpQjaZFMSQA4QjgGjI2sRf_3clxv3s_qnKs
 iRi6skvX1W9SbWeg8GB7ytEsEs4qkJ9nr.8eVP2cAeXqiFxj6.tnAdJ5dWwKClT6fhDcT1EHKNzH
 DbxdwzwOZgsiWp2xA4EZGm1_2GDK0YXIeAC0V8WOJYl365iuaD2ySgc0yCqoeVpAMQFEqMXfmOR1
 7fs7xdKtAp7gNuJJdAdISeaDBJqDmsdeLui59OvFqDhuZSQ9A7Mv5EtK7CSQkc0G5dXlm7pJuA_W
 KYvZFtx4Prf1NMH4fzcbKfqxqXKlmHLA2BP7SXFQzB4pOxytE5hrC_h1vzB60JEkfC97I5o9XCWY
 kv5aWW4SJFVjjiKzWPc5fT1d0TELWpMXZ_07MOIx3GbMQWfeCrZJzU6G47PRnmMGgeAQ67ERmrEn
 9PPHN8Cxwrl8FrYnaOr905TfYt0i6jW81yQf_.IqTY16X2gK6ZmCcUITv.bXEVMJR5zpPJ3rR6C5
 Ie3RHivzqh3bfJ24KA_.dR3GcJTrh.4GK4vLZ7kObfP44QqM71BoL3vQmt0.hTN8RLpFccLBocpP
 hfz28zN5Ba_UBXdzfPligik.RTB2C8nKM2T9dPrVAE18n9.OVd_kslV_z7pZJrz.dd_FpxvnYegB
 amWlEL8OXZuLWXBwasb3gEK848jXB.rCPfKRr69vIAXqQSy4sVfO1N12OHoPLfMfvQBG5VJBPhnN
 dRmG06zf4Xdgok1NMDO2.vF9ttCZlmDTZZJOsq7sGKCX3.4WH3WUlcT3zt9QgVvwUtDW1i9l3l0Q
 kXexa9ZHNgHofyAKicUUKvTslDfbEPFPtSKK.wjIbshpzgVAtt.evls78.cs6WYiw6z73tOyluQB
 2ZAibZMM.UrP4POBshxqPONfMSPClriwJbs71PrGwR0_AxFsTN0D619Mo2raWhyVu66DnSsHiWiB
 BuL2yIc76qG1pdxYh5tvPnajRfH.pvJ5j06bO1NYsf4tIPsji5dOyG1p_vNX7QTSoXqRkemHKGrz
 Rem_IYylzeb7lPHrFbznVDgzpirvEtLbTMy8u9ma5Lo6Axvu_1sAkKQREz0dMZ5N8BmsHHNhjGFw
 HTXhx7aLYujrqKtTRWh.HAqrYDZu_8RfClBYkefFZir.lMhGtPWxfyv4ywuJFr0abhtLb8ZbOrXw
 _QCuuslvJWUEi9Qe8yupt1fRSZyxZMmDJaTu_dYBfmD7V.2zOmXvq1XcppE.WTd8iOziFRIqtf0d
 kj.ViSF70emxTZM6ynFn9DpE0XzFoISSl_jB07KZrZaTPLeByIgrAgA3JszriJQOM3jATffVekh2
 njHtQawKuFZ_HXMsax0Z5rHJ04uJYaqUf0ur66Kh518G9YfrrH8SNO5_slI5xOEWQD6cU5dxzFsf
 mJa0EhlmvQm27AZRdCombckIetN6tPeCGIC1F3tOBmb6eDa9vu6jYtiHA3avpm6FKV3AWmuX.3Ao
 cxjVpmWTHl95OteNG2Uv_3MJTb5hwyqGbeuBJYWbyub1YI3etQYhpW9gly76lgNAIzXmHZFwX.ew
 nNYQ4GDC9J3RxW81HNaA9.uZcQnkT3.4dIUoFNwxU2s_7_1JKprDOk.35XK4p2rIYEFqi0uS2OYr
 DDC38x1XZeeXB_21yxBmF7undK8Y9VKol17gfI5FardsjwwXbM.jvBcSG7LiZac_6T6m0u.FHzi3
 VCS6vRbLEcIzT_LUWG5Q3OtF8gDMaiyQjuAJ4twkda51syDxmvQTFsySpQy3PeYn3yrarsOPslAj
 IRUOxZSNvy.XkUrc3s1rzpf6.Rr.vniculX_KweSpfihBt0cbS_22N7cQ7w9x78L8UnoLuNkcDs1
 YiWTtGlv66FTGR6h2cNTfOAhISLlBrrLE9xxHL4LU
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 394c31d5-b10b-42d8-b6bd-616dcabf68f2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 16 Jun 2025 18:36:27 +0000
Received: by hermes--production-gq1-74d64bb7d7-grhph (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 83fe4fcb80247122022037b3560098d2;
          Mon, 16 Jun 2025 18:36:26 +0000 (UTC)
Message-ID: <a5d3daf3-d8a2-47b3-be84-74fe2965afed@schaufler-ca.com>
Date: Mon, 16 Jun 2025 11:36:25 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] smack: fix bug: invalid label of unix socket file
To: Konstantin Andreev <andreev@swemel.ru>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: linux-security-module@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250616010745.800386-1-andreev@swemel.ru>
 <20250616010745.800386-6-andreev@swemel.ru>
 <147eb5a5c06ed28eec9cf33a877cfb200e9a6103.camel@huaweicloud.com>
 <df5f6bdd-b7f7-47df-8fc7-a5aa32e2f92a@swemel.ru>
 <38c13fcb-2ed5-4b17-850e-b57562321683@schaufler-ca.com>
 <8e6b065b-8c98-4977-8c7d-f335c16e99f7@swemel.ru>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <8e6b065b-8c98-4977-8c7d-f335c16e99f7@swemel.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24021 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 6/16/2025 10:53 AM, Konstantin Andreev wrote:
> Casey Schaufler, 16 Jun 2025 10:11:55 -0700:
>> On 6/16/2025 4:46 AM, Konstantin Andreev wrote:
>>> Roberto Sassu, 16 Jun 2025 11:05:11 +0200:
>>>> On Mon, 2025-06-16 at 04:07 +0300, Konstantin Andreev wrote:
>>>>>
>>>>> [irrelevant portion of the message deleted]
>>>>>
>>>>> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
>>>>> index fb23254c8a54..1b41ae053966 100644
>>>>> --- a/security/smack/smack_lsm.c
>>>>> +++ b/security/smack/smack_lsm.c
>>>>> @@ -1021,6 +1021,16 @@ static int smack_inode_init_security(struct
>>>>> inode *inode, struct inode *dir,
>>>>>        bool trans_cred;
>>>>>        bool trans_rule;
>>>>>    +    /*
>>>>> +     * UNIX domain sockets use lower level socket data. Let
>>>>> +     * UDS inode have fixed * label to keep
>>>>> smack_inode_permission() calm
>>>>> +     * when called from unix_find_bsd()
>>>>> +     */
>>>>> +    if (S_ISSOCK(inode->i_mode)) {
>>>>> +        /* forced label, no need to save to xattrs */
>>>>> +        issp->smk_inode = &smack_known_star;
>>>>> +        goto instant_inode;
>>>>
>>>> Maybe you could also set SMK_INODE_INSTANT here and just return.
>>>
>>> Certainly.
>>>
>>> But I personally avoid duplication even of small cleanups
>>> and avoid multiple returns at the price of few gotos.
>>
>> I generally prefer
>>
>>     if (xyzzy)
>>         return -ESOMETHING;
>>
>> to
>>
>>     if (xyzzy)
>>         goto err_out;
>>     ...
>> err_out:
>>     return -ESOMETHING;
>>
>> I grew up in the era of "gotos considered harmful". When
>> err_out does more than just return a goto is fine, but a goto
>> that has nothing but a return is unnecessary and adds code that
>> needn't be there.
>
> Got it. There is one line more than just return here:
>
> | instant_inode:
> |    issp->smk_flags |= (SMK_INODE_INSTANT | transflag);
> |    return rc;
> | }

Leave it as is. I haven't tried out the changes yet,
and will review more fully once I've verified they work
correctly.

>
> What would you prefer in this case, leave it at that or convert to
>
> | if (S_ISSOCK(inode->i_mode)) {
> |    /* forced label, no need to save to xattrs */
> |    issp->smk_inode = &smack_known_star;
> |    // goto instant_inode; // <<<< to be removed
> |    issp->smk_flags |= SMK_INODE_INSTANT;
> |    return 0;
> | }
>
>
> [the rest of the message deleted]
>
