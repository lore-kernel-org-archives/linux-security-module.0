Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70790FC0C
	for <linux-security-module@vger.kernel.org>; Sat, 28 Sep 2024 00:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727483315; cv=none; b=S5y4fNWDATS39pZ93XWmnEXnHRuM9JsT5gNxtUrFmcglcSGvnDHbShmNxb1Ae0PF/iaHNUAhSt9M/ltmN3K2rAnjbaohcmd2ln/fvTY9p4wJfaxfzg5VWDUY9cf2J1bykGukb1ecXSSnHABVxfpEhyxS+9CuVa3yarfbBogLLpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727483315; c=relaxed/simple;
	bh=9h0tqDT99isRIdjfPg8yZJ6E0kiKx1ikTQgEqGB4kLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BmhGCDYHMcEJ7RoWutj1SVt07RQvWMcl3HL1S43FBXt5imLN09dcAjSAaaTCjgnUmUAbdUlO0Dk7I6mNtt5xC7FtHkUAuVB5LZugsXhbjssmwuN7SQwK5d907TWl3LjUpM5t7wDZSXT1ZCjudyUrZetVvG9BtbfzPlkkjqVlMis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=HiC6mJjt; arc=none smtp.client-ip=66.163.189.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="HiC6mJjt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1727483312; bh=OB6FzDzFiQOcm8twiCpfgUJ8TuUwAyP31fPrEm7k3tA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=HiC6mJjtQdmuHYPAKjXT4wXwMZh9Lm2LcocEItIbCoTw1jm5d00hcKBnT5jWDAyKSOGQFFHdoNSuiZSUKlOxo5/HLclSpzjlSP4+aa0ytZXoZB8WDboCSl3X7uaTZbzsFbtDHaIRCEdxoYguT7CMghmd7upRYY5DGKp7uyutDqNVwkVWZMVjPIfLn+NIYEYBvkYFMBkGaNy8vVzlHXmx7d3u2DdT3zg1OXE5XttojWR1vzFtGcEXuY+nSJw2H58+RdPCZeqO2cIjJXhyERV6jO4Sa7rE3/5vK+oDTwWMbhvD64fvbSTNHY/NDuSML08sxBxau/4xnz9CV6it/uir1Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1727483312; bh=9fdH3MpCxTT9USnhPKahXZIxhta6x4SQ1xjWVedFm9z=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=kwZa1PVCU90PRl8301KN0cLPstk3Lb/ZIccWu0a/40aKVlSrTGwf14ZJ4VUCytR6DV50yBRlox8fMItzudyHd1NXatFkMrFS7grhgT5KHsjKvsLqoSr2Dk3ZaHXVk8CuhpWJouS831IVqRj1ExJ+Nwt4jlYC/HPoWIse9aqmUCGjuq8KVpJQa3GHIb5Nri0CxMgTdj9oJAefUsirNvU3BVA9w1x4FCswM84OcFZRUHFaHlBDLRysityRal+cq5ZZuNpDfnYTkjZYPvyfNO77qklcHpXuCRG6CfRQbGafWbRdJCUyBZmvfNLh9iPWz6ELhqzwRUUWrF081MPKMrliYQ==
X-YMail-OSG: RovtmDUVM1nZogDJFuQNqannt5lkxe29f.m2L3PRZF84dui2.uJYAU22aedj8zP
 ssXyqfVtbvCiq9J_bVqAH8G03X23NvyWPEWAbmqhYYcs6piqHurwSC3S3RG326rrvnuHSGm22FlO
 Qnkxl6OjToK8TRuTxdZNPHpuEZDgatFvZUhPA4SVMDE4DTocqlrIYa5Yq5co5o..gFhLiYpkxcCm
 ipJoieUXHtcQj9g.6fqxkoZBM3mmX2uEK9QtcODkrdSC0VH2uSqMgn1KXf1MNBez_5P03_WWTPnd
 cEJO1X12RPL4cctEicL1gn5umLIUgCITu0kQdaF0SzO4EiKP53OIclh41qcHjaqxim_d24r7AQ_6
 tBilpV6XQ1go2NvhfmsU8fxQmn2dpZz1KpMnN129c7EIWxJJm96Flpd_h_39m_8kbCJatwReZ6xx
 VLS4sYbcWl6TcaUJrE0rfIosAjwU9fAhLSjQ4XMCs_gEqGr_3Tm507MJx_YaHp6YMHGnIHD0VngQ
 g4aYEEADtRdqiYrFBeYuPxNcmVLXmZc87XMSkDM_Q78aVdXTIEcqEbutGTuw8bQbPdFvQUqVBZsn
 7vZ1n6r2XSeQJ7B5jylGK15veAW3AzHrEI3h4SSwiYG.ycEtLU_X8KkowXevqVLrHhA9J4txYw96
 l.Vhh82SiF2VIz6UznYQ0JslxMHu7v4w_o7k6lq3U_7_dTwZYR..xboK.TFgQAOEuuaPedJBSv.N
 eFh7yJtjFEhF1HSsyn2aKnqY8ayyXBWfVtPu7I7xXClUJlqOp1wxWNO2jH7pJ0VLxg.MBX7..y.4
 0zAxho3dRoTQfXwKHxEZLOFIupBmFbRqdKSi8bCPK8XCu3K1IrR65HjVm6Fe1mgn2YJl9PN7L1AB
 AFUkCM4TXQ2JlAHbQxl9yatjD3XHYRbkzDna23AWWSgk1t0DWQIjd7S5dH7yO.hOh6LJ4pSMrrxc
 loH8WAEnZr3LTANygI_C.J81_jXMu3aOlX_zV0TXC9VWct71_txmf23LYE45_zj1oMqHrpjO4zBN
 nii0vnKnqW.41.9KgIVch7qvPIKF5yKM1Im35Nd97vgYi60tCpi20HzHDA8ZNPkJGlJx658kwAVX
 9qe_ap7L8lGvd3LuY1iL67BgeDYXWBlAB1j5I.U_5uTzy0M6eHPmvwmAy6tp1T4ryTpWRbhN_sWp
 uPnwV3ljEzFc0SbrMFfv8SN6SUWgCmFTkoVj7QXrFUoa5zoDKdjzyIYNEp.CzK4hChr.UYhQn2Hz
 JZPaommchxxKbtDLN3IVeKQilxwRKSqxtpi94vSUlihgdf2dBc6ETqfjLysUgttOacxR9QJ.e_cq
 7IN3mCh5tIyXVwyNjn9VWKY2S675HIn5diJhvdl26d6oaWqxg0pgCRqBmxFuH42.1oQZuA9sZlSz
 SFFRxtXGilz8rSs808VWRkbsqwIfPYIG06tFwqpySVweAikDBLvpYcvywYEG2kiGxwm8QWYlepz4
 wQyclA384YvQrXcxHe6yYvbzUrLPlL5jjJloOGZpbd_Q0A4nVgXogdZohZb9UpzEf5YwdQZBGwho
 H_WxHxsJgdkZUEFqrKvSBfNGEcD16d74DXfHpuU5iOWuRdfihhC3cHpwfuzpKZLwSKrUvzSU6qy9
 sdgAiyXqNdMziOaK_bbJBe.Eq87cmIR6hwPHhQL8bHwVGYHkuxcy68Lmv86dIap4Qook8OnTQiee
 lPE5WrBrdWK87ARfJqHBbOdondblAvmqAwZRUQ7suTGezv1XpWyWj7.glC2xw1irdYDRhZFwQN02
 LyCIQws4hKH9fJKi5okgiiOjiUgcF_GAJOC1Lqtrebshy46K4joBmq1Pchn9Zz7rbBn.hYW8Tnq3
 qfpmq6NFUZ.6OyZHoWhCOFWVBENi3wRLNLjBkhvPIY0cHj1cAzIniJdLK.xrHu_da.PMuYyA8TNf
 AcQ.neowvv5QuuUXbWmuRXDiKKnEuzqK26xXI5r.s.r5UTus57MJ_QuuyVenOlrunGPkAI0Zb7oF
 AwDWrk_qPpZh7IShAENt9WhH7OzVwZrjZiVQZ40WvhDajoY.FTiRi2tcNoxG4JnGqWGdSDHYTRh2
 VnsQc9uqbdM2.g1v2W7NKxznXQFZ2cfggoAW2mRCX1qZqb6aERdXbGbBw6kvvkAaVlZr1eryQ6nJ
 kCXoqlp3LPaCqWNzNSOdWu.N0uZlyJlBfROE81s.BUkWRorQa7HW2sDzYP1HVx.UVExpCiJwblRo
 P2a_cE1s3g4hSXLXHyTaNmC8cK0zP9nZUB8T1d.RbevUAqLDb64QmfZiKCiB3HeX5Dy2L4jeQ.WS
 uxo8UCqHq3EuPofcb8_BKuXFirEZNRA--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 7842d67b-c5b7-42b8-b432-b8b880acff22
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Sat, 28 Sep 2024 00:28:32 +0000
Received: by hermes--production-gq1-5d95dc458-7jxgc (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 509cb58d9dad00d249880876ac0f8bb8;
          Sat, 28 Sep 2024 00:18:21 +0000 (UTC)
Message-ID: <d477ba9b-8a95-4e95-8fc6-4e6d77141fb4@schaufler-ca.com>
Date: Fri, 27 Sep 2024 17:18:19 -0700
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
 <b79caa6f-41b9-4169-bb8e-9417611db455@schaufler-ca.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <b79caa6f-41b9-4169-bb8e-9417611db455@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22645 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 9/23/2024 9:15 AM, Casey Schaufler wrote:
> On 9/23/2024 5:06 AM, Paul Moore wrote:
>> On Mon, Sep 23, 2024 at 5:02 AM syzbot
>> <syzbot+listfc277c7cb94932601d96@syzkaller.appspotmail.com> wrote:
>>> Hello lsm maintainers/developers,
>>>
>>> This is a 31-day syzbot report for the lsm subsystem.
>>> All related reports/information can be found at:
>>> https://syzkaller.appspot.com/upstream/s/lsm
>>>
>>> During the period, 0 new issues were detected and 0 were fixed.
>>> In total, 4 issues are still open and 27 have been fixed so far.
>>>
>>> Some of the still happening issues:
>>>
>>> Ref Crashes Repro Title
>>> <1> 306     No    INFO: task hung in process_measurement (2)
>>>                   https://syzkaller.appspot.com/bug?extid=1de5a37cb85a2d536330
>> Mimi, Roberto,
>>
>> Any chance this is this related in any way to this report:
>>
>> https://lore.kernel.org/linux-security-module/CALAgD-4hkHVcCq2ycdwnA2hYDBMqijLUOfZgvf1WfFpU-8+42w@mail.gmail.com/
>>
>> Looking at the syzkaller dashboard for this issue, it looks like it
>> may have been present for some time, just difficult to reproduce
>> reliably (although it does appear to be occurring more often
>> recently).  Any ideas about a root cause?
>>
>>> <2> 9       No    general protection fault in smack_inode_permission
>>>                   https://syzkaller.appspot.com/bug?extid=4ac565a7081cc43bb185
>> Casey?
> Looks like an xattr or mount problem in JFS. I will have a look at it.

There's a private inode check in SELinux that didn't make it into Smack.
Looks like that should be in the infrastructure instead of the individual
modules. I have a patch in process.

>
>>> <3> 3       Yes   WARNING in current_check_refer_path
>>>                   https://syzkaller.appspot.com/bug?extid=34b68f850391452207df
>> Based on the discussion over the summer I believe the consensus was
>> that this is a bcachefs/VFS bug, reassigning to bcachefs (or trying to
>> anyway).
>>
>> https://lore.kernel.org/all/000000000000a65b35061cffca61@google.com/
>>
