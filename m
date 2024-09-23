Received: from sonic306-26.consmr.mail.ne1.yahoo.com (sonic306-26.consmr.mail.ne1.yahoo.com [66.163.189.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5F819E98D
	for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2024 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727108136; cv=none; b=G5ALcEiWYWvsnPi9wd8oKZ+cfgyLgRebgdLWP/yU2JrJ9v4LvDl2nVQYPzhDh/bJtdwytOcC1Jv4Ewm54C8lJFd1vRAjp0OLJ25xjha2EHE/m6ngY/5GcnfMU9a2Jx0a96QrbfIyb2FPWFJuYoL+INFwxamWRCYaEM822QREWjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727108136; c=relaxed/simple;
	bh=G0480Rie+Gi+rIglkvuKDHJpvtVnMKe16bmCcw361/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5Ob5XTE4dScCsibVP9U7fO3XkhdxfnL+HJpRgCk0vbHRy1rDP0+0DLnz6vTq+BH4tbRn7C7uu7oo+H7qeUAVzCx/9UZNvZf7BsTJfRes+BonPARcCCf+/4v99RNLXdfbIjFqyF2DJWarUtQBWfSKucPpbSHu5zCYPRwUWZnoJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=izDGiurK; arc=none smtp.client-ip=66.163.189.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="izDGiurK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1727108127; bh=DNMxuq/K1hCCONqZHLvEpcLINFMRMBzcVPQ9MvFiMlo=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=izDGiurKdsitBJeo9i/M3gnVpNXgkuoTW2UDVpXAM6XR7mXZ0p3XV0xdNzu18lGw4L5pEBGsjL5z0js7vOjODmYL5IC72PQD5JXj52U/r3BpuwP48Sc+uZhLYtGtehM4M1OEE68DXRsgkHir9tPETs0VZyHKlBtPS7/p1Z7vHM7IsbOM7RmgioouQuydqlyONTSTysi0GIib1MAYOodSTgkpCKaJjkbvQhqWF0JQ/bKXuYmSBgmvMW8sz3JWJ4Ew7Hrvrng46dYbgwksmO6vt07N9XyraMJbr9ifCk9wYLKSAq/H3LlmEz0TTr1qPXDXC0V04aGO4GJQfOiuHXd6yg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1727108127; bh=/s9x1h14ocaLcd4eutMEh79DHX4t3vRS/Ie2gC3i2Y2=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Z9CXMVVag8jzolUb379BiGkCoEjSKibwJuelKQmdFVjI5+2cnFbkfvT1onDQlwDfECrnLmHHiLj697kDf+b6okYauak40of8Eybdo9n2cOOUjNqbvdd14pF8Fm5jUQ+6AuK9KlHN+8CS7aLsGFZAiXX2MoYZgsR/u5O7rmfhm0uIOG6pifmz74dBjezAJa24TPZ/TgDRCC3rQIKM/n+kS+Aaz1NAuQycnMXzDnlp/QC+HFUphmNEMrRBPPwL+zXvc2YL9N0UMYdR26XGmM/+FHZ3Rrj4kk4CPnzkT5I0JGDsWA4pGNcYsKnysmX2H1I0ObEw9NXTlmYP8b7wdH4AgQ==
X-YMail-OSG: sIV2KDgVM1ml3eVWk3iFe1dmKpJNvjM1GXGpayuYYCbipD3LyEEZnf63FkN4SKD
 10tx.EuKR19cBIb0uaNufIMdh66sFo_6VdoqKUxxDBvXccafFBmEGBqL25viKxqw7KS5tYdSIQpn
 wXbqFTvqx5MW3tXFv8coJURW3jo.Bm4GK7IpeOZmJpJy8I9MlVIKD1MG8LMvgJzGmJNEUZ3DHqNA
 FkEtMK0KKnC3Jzhf5FcLZtHZG1rBv7HssC33Wm2b6gRQChs9O1BpMUfAs1Uc_SW1OPJJFTp10sUF
 pUSEvYbTpNzXcWuqSDLAFQA07eIiheT0a4aT6GkRMI2jB28BMUQMNNABuV0oFHYzr7UT9gI3uGv7
 TXfxO34IGhqXgiEnkcLKXnefPBJ0z0QBKmYpuQKHYE57h7Yt5aSENH9fIW2CP.aQwSepbBDLdWtv
 H_h6lojl4wAkJ7L5IifOQ6cR8pNdnfQuvGX5LF1yP7gjJa7_oawxmm01jiaTmsEbVJFKkI15ewfk
 U2bwOqcnWd8ztqTm8c5vL.w0buvtkIL5NU16QD9y_GacqaxfIoxJ_yWJhUzpwmBzIceL6y7bxA5a
 J6VSYYiIyfAV_7k1sdaAoYsbfzUkUokRufmfajhTytfLeO1V5fYaIP1TZnfN54qq3BMSj_Bz8aXJ
 .500iDko4_fSwsDesolEyvu.b9SK2zp03wWtDT1AMTLLstyX6oAJu0BPbCBSQ0ouWyqERY2dOS5v
 0S24q7eI7NKYvdf_AzwXynj2qQQPs_wGNvW16Pm3NikAPedlSA8u0yFO1PmQjWC38N17lTXZaXCg
 oH2AT5Vzgja4rPEyZvpj0cCTNgzXN.dqNTAR7gpJ.jn7gE6HePPHz7qo4vxzq6jQp9UENzJ8.nrw
 QR.1A5byDwadnoLU.Y1Nn8rPANQRhOVpERk3S1bOOQfEQ.OS5hLWz13AwSfnZejJ5WUsXoPdMoB.
 3rKFfrRvKVS_NiGZV0Ceqvy5S_0JWgEbaSlEf4Fsj61oVbqnV8GZCtzb0vYR4R0Q0J6_LfrcNcZC
 DkiwfmzoZtmZ9vMjUxARZ0Hf3noU27CZem9_Pwo2Enh9WZfe3.pc7BdiVASmZumK1.YSxLNIVSZb
 q0gXoLd_ggYutsxWuiq7V2uALsqooTqxFnn_zxThqfSnN5PbHLUtPu8Z07fT9hJecQvQNBsVjMUe
 wLjeaN2viI.Tf6OtaXTg7ks18cCIYwBCtWUmsSCVafMQD2b.5IEjI3UB6CztjrgDX4_gEF80wDdJ
 fAMkatptVyA7gEX6sx42YZV8KuG.iJ_uh1_ZyRIFxwdhDQ9aXAYHJIXpDbiDhVy7kwTIyXRc.5ul
 GVjD99hOUeqIm.Vyvrgfd2R2k8oKPMcMbzLL4aAF1uua5cpY08jTVzxNxobGokxrd.JoBCNGu8Bu
 lLngKidbWWKzgqGkf1W5iPdQ2553N3F0ykJFWlwkTAPbYRr_ZxwcdAdPiMU2leF.7eTOjsIG7ndQ
 Bx.TlbUIL8AER89kSLsStGJD9nv8gPinMgAe6288r4pNDv3.tYT97XbIXctC5hpypLEiV0rnkWk3
 JLQK9uVVwzY9BcxE2yG8FMWZdKPSAabnqN5eY0W6uCv1DjUyvKMQDvhEk0mBPMx4TntTQGpv0F.3
 YYXmxcev8s1WY6AFVdPDX6PBYbiHn8u.423FSH08jV61ZC_tJAq6Md1CPJ3L5srJP0hvKUDtlPEx
 c07Op02t6hqAWCwa0vYH.TbYanpeEY9OyZcPPBaIXuOWCE4Pqs1KXukNP9_i_FbJxTj4jf10OqrP
 oXJ1EmAfR6DKTi92Mc75SZUlhni3dT1aQJpOsoKYpBLzNmReMq0uuBcfkroKnXTKFF7MSpKjOXRA
 RmT6GVwz9NO.7SlJywsfN41hZoqjebAdoCsw46aEIjJjhTXCwbW377c.wutO0WEPr90eKo_5sErv
 kyjVVCHMdQwGpfR8HJjtJe9L6H_.bY9M5rEoM0ER1iEf1gSQGx4CJJ3gV6yYnbyWFrTcY9gJDovF
 3vEkOufJh8YoREi4xSIW1R7YLpPXJoaXplilmlCEO.cDEjdDrdBR2I_lBPJ1_6c87s6bDkOqlQoh
 B4TvByuVauSyveCahtFyRHOsbPZkj.uJhtBBEpnmIb8CTY8OEVr1ta3jtuldvF7alJBMf0DMwjw2
 a05w3HmDyJtivm36SHmkGbLfE.S5Cw_9z1FgH13iJpXTXSJ2sCLdNO.94NylizjEfMjmLFJA0vJk
 2kyJpUHeuOlXtO1oSlOwR6zB1Aty4Qis738Xvo56PdWI2pq6vzBVI2y0y8KpSsjyzGr6L9hgWAFp
 LoDhfBN71vQJpsQwVn.KSiZlF6XhbvRESteE-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: ebc9fdd3-4942-48ae-bd11-f7ccf871bebb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Mon, 23 Sep 2024 16:15:27 +0000
Received: by hermes--production-gq1-5d95dc458-m8nfd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d165a4c3c0de4d74f5447a93c9ebe163;
          Mon, 23 Sep 2024 16:15:24 +0000 (UTC)
Message-ID: <b79caa6f-41b9-4169-bb8e-9417611db455@schaufler-ca.com>
Date: Mon, 23 Sep 2024 09:15:23 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] Monthly lsm report (Sep 2024)
To: Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 syzbot <syzbot+listfc277c7cb94932601d96@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, Casey Schaufler <casey@schaufler-ca.com>
References: <66f12e9e.050a0220.3eed3.0009.GAE@google.com>
 <CAHC9VhTxCzWvM+j8=J08JVs=1cwk9rtBSS7qFBkdm-_neAwkJQ@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTxCzWvM+j8=J08JVs=1cwk9rtBSS7qFBkdm-_neAwkJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo


On 9/23/2024 5:06 AM, Paul Moore wrote:
> On Mon, Sep 23, 2024 at 5:02 AM syzbot
> <syzbot+listfc277c7cb94932601d96@syzkaller.appspotmail.com> wrote:
>> Hello lsm maintainers/developers,
>>
>> This is a 31-day syzbot report for the lsm subsystem.
>> All related reports/information can be found at:
>> https://syzkaller.appspot.com/upstream/s/lsm
>>
>> During the period, 0 new issues were detected and 0 were fixed.
>> In total, 4 issues are still open and 27 have been fixed so far.
>>
>> Some of the still happening issues:
>>
>> Ref Crashes Repro Title
>> <1> 306     No    INFO: task hung in process_measurement (2)
>>                   https://syzkaller.appspot.com/bug?extid=1de5a37cb85a2d536330
> Mimi, Roberto,
>
> Any chance this is this related in any way to this report:
>
> https://lore.kernel.org/linux-security-module/CALAgD-4hkHVcCq2ycdwnA2hYDBMqijLUOfZgvf1WfFpU-8+42w@mail.gmail.com/
>
> Looking at the syzkaller dashboard for this issue, it looks like it
> may have been present for some time, just difficult to reproduce
> reliably (although it does appear to be occurring more often
> recently).  Any ideas about a root cause?
>
>> <2> 9       No    general protection fault in smack_inode_permission
>>                   https://syzkaller.appspot.com/bug?extid=4ac565a7081cc43bb185
> Casey?

Looks like an xattr or mount problem in JFS. I will have a look at it.

>
>> <3> 3       Yes   WARNING in current_check_refer_path
>>                   https://syzkaller.appspot.com/bug?extid=34b68f850391452207df
> Based on the discussion over the summer I believe the consensus was
> that this is a bcachefs/VFS bug, reassigning to bcachefs (or trying to
> anyway).
>
> https://lore.kernel.org/all/000000000000a65b35061cffca61@google.com/
>
