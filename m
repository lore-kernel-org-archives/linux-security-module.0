Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F66D3ACA40
	for <linux-security-module@vger.kernel.org>; Wed,  1 Jul 2026 21:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782942123; cv=none; b=XJGvxtrs1FCCDM0xAJr/61Ysgt0OZlmMiCTr6JZVMdS+28/YAlg8zP5D/RMKui4M6LN3SL5K9BDrK0VSolIu7WdfjT+EjGoQmU1DXDsf0Tp5s6pn8VfNA9I873LxDh8qq2kqtY4q1N3mz6PTfRmQBBLNM7GLLZWboyVqsyXhewc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782942123; c=relaxed/simple;
	bh=ONdhMY8s8sl/1GzSWOimUx70kBPD6YcnE7nc/TKGze0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O1MRauhmuQuOoku7hG/uWknn9lxLPMKQboRXyZ5YoYg/ldy30ZAYWzu9C4D22cTQgz1YMYfwVDJBEYkxiaskZTqCCowR5hOc0Tw79lsIt2itGj2rRaZ1+P4Y7lFHFO0nbeG/mJP2VQ9xgC6HDG0Dwdqx6kcjByNN0ovXpnT5DWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=VxHrgyP3; arc=none smtp.client-ip=66.163.188.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="VxHrgyP3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1782942114; bh=ONdhMY8s8sl/1GzSWOimUx70kBPD6YcnE7nc/TKGze0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=VxHrgyP3YWDawyyA6V+bCoCE8uMhDQKIFima+kbqcfVmXU1yE5qO320ehmVid6/qnXgQ8xSNzu0uAAfrGdNFKXfh2rnBrqfoW5Nury/c2tOMmEmEqBQJPDxZOKAU2vnBVqIBr/R4HaOLL3+1R48ilJOA33dU+2eyocXZcsnqJ4Xk7ZMHicFmtLziUC19DWfDVIG23DuDPYZJo2t2POMGkQCmHW/YBfpM6BKxzuruyHKtEuR4xuI8srZDzXWSORUB7ky/7B9+j/7kH8eYdu0F7qYIqetkEFb0jWWjhQSXJAXMx2OxkVy4S5aikbquijpYj0lwULyYuIH+LhxY+/UZoA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1782942114; bh=wvXyFs89ajCpKK4NRBmG/mfQ3TEVjMkOZsszXjEihKd=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=tj5LEeI+7U5Dgeo5cLoTuPl7oxiVvkMhx3GzRJvNHv2NAD2DaHyOD/TlXHB1Kj3xbDTzpD9qhWSf6sytBvCwHuY0X8talt8uEBjBuxVLVKvr8MMk4/IIsa0k+694z0dqNw/VyZrap2K9avMrN6AWk/cw5ZIjDtZgfcdfkqimRHs16uKtv6wAwzcL3gqCuwGuO3szK8Kj+ufjrDrMKHMbjkv7x/B4/xda0YSFa/oQOd1lC8reuql0DVYteRi+nQ9Qeu3+4oNsReVTdBjzXpK9V2OdOjEj1qU8W2MqE5zIEZAAWDD3MCFTU9C+c071tws7PxXMLPms+Dp0QqoWZTG9mA==
X-YMail-OSG: jj26vDoVM1m.jXlw468P0YqK.522FF8z2ThfBznRWJn4FUi5jOeIhbFntZWbKBt
 hM8EY6SA56G108CvP9MVs2.LcPuHsEwnqfz5rJ3IhHwYaNrIe003FoQNJtu.Oyxd_AZjbZiqMxOM
 qHpRBYgq_KDsYxxWoBsWR.qkHePU91rSqVPxvbMu50dI57vkmR71Do78G8FYpPPY1JZxmSjAbZM9
 0Gi7A0aq8Pjnn9Y1Ldf0SDAT7DlnKfQiVGgyaTEafFvTo2F6W5cxXj8WkeTUqA2w7Q5uotvKewqO
 NNGAQMGBnKdZGo9f4CQS2LB13aJCja9oY4sjASSoLYpzi_zXYwRRDqEcCsDVMC0Pwu4R.6Nj1YOo
 NbrAfryoGEMfnwodiJF6rzb.6atrokgd7aybFl4wRdc.3GdUkey4Gbls4DD42cgWKxYQ2Zu.uPZ3
 1v1Y6najkE8zxpSJlV799Jz.pJjucJc39PbOp4Kf2YckniYHSj8Rmi2cW33cFRDfYFrf050yhQPW
 tm_fYBC0tLkdCgsblMtQOJrUrjl7QhFkTPMkKlhrV9Ax41zpKyEGLAu720dq7qMMmQ3NKfhzNRWo
 NMqlD7GsYChk7WmddqSNgodTAaIVGbKtHCRLixSG88RvN6e_LGLqqpv6JaKKaMKiacCBJ89x1Xgh
 Gv7geGRVRYlc5aOZtM79GNrzk0hMEdTUee4814_o2jgKR9DYDUMWV6KAfjEi4lGv_qg5HfNGVPMD
 _0OITGreiX7uQtajrU8Knos6NcU_pSlSGApe3JReLctC6HSG31xp4vbv.s7oJ9sSCyFCbW9GJwfG
 B82zsFLkB_qunkLZMCeumiljBhbKCqn2GpzT7TuwocvzQ10JZzQ1JRGvhEZO6ILIyODkMdIHNov3
 F3gii0qLL92bbJKuW91Gvs6Xmwe_IYhWf58RRkShfrDwAH7c0GF1.H6uP_BtxKpnICOxuEeocYIq
 GMhn6PyVrvT6.AV.xx_aKlvPzOwMfj10kIQswnwiON75YDA_0_RyX_ciYnf2Vc2X.btt7Q4gBWDO
 6ePh.LQxFoUPVW.vL9tIt2hk2lHdGcdK1IJeou1l8Hrwby9gqNvG3jjcUajV6aunwGJ_tpFf1MOQ
 drGfOEWRUWl.d6syb9tKdwDey90nW87LndpPbnBw7BcSYcoNsTgmskM6McplQV2AMTlciEzhqVLQ
 jQKSoMoNznlWw6vFzuVMsRfoEm2AtqZ0os3UV5frtpFYTNUsnyLk1OFFcBPRdcjERdiwqqh7nU45
 QiNedQrGUrEChbCZ2phGVRJeZDwzLPAuRRwqzOJfnRwyuO5D0nGDGSNRKukYUn3sbtl3Hgkor17.
 VtW_Kre2DO31aJnpzMxog1YQ85G0RTpEwN3_aedgh3cZKWaIIK2PxQ.Go0VMnO3IHcQ8AbQ9nZ_o
 J5U2gkflIvbFk.5okLOLcxHK4vXn6JPpJI9Sjo7DhmV1e5GLquEkjcgPgtC2w_n.RRCo2uFbRZB5
 MbmzLMrBfBIQ023ceT38eEjUm8LbC79jxWvxWisTgd2gkLvWtBnMw8LOYTUVWKjucM0_Wt2QoH5E
 fstF2VxtQoOYuWIMpeTAHh41fTyqVb7LHCZYJ5MT8HtmOC.p6.3VEOiNumHOHtGp4pgBr_cylUiB
 NkDNDyVPYOJ9En613mhUrxWF2r8p2rcwNt3VLNYc.5NYSWEEVeWmYdqmUkA4Tjym5S_YTmlnL.L3
 jCnRP9Z0NfR8wubeWr2X_teMnukJV4z_yJRG7z93rKjJ9bnSKMg8nV0u6roQX60BV0dZA0Sdt3BC
 Tc7Z2Fl4NnCD9pVTgioZg1CyfshNZll9b6VVojJkZw32wI1GuKTxnlrj9uy9TGt1UVwW5GDM4LCe
 0d4xXv7M64a82G8xfJCfmTyzPjBEMtjk6anIEN1bAiAEPpwnKM1dDXppjqoqBWiIaijOBrLoOASV
 PhVZ4teRzQlQImYvdYtlo_2kUkTzmyHwnWQ0mWlMEk776nrq9iR233sUiblEY3hcNyhZNRMqej4t
 bvwXaLojbdI9X_RjGn3QEdckHmT.aydQRnlOao8ICcLJN9l_6eYTZXp8BBGl.gUTZX3JBUzJ2TJa
 yONjU5TaTaJG8rfSQVRlYN8zAFxLTdDoI.XlSn_W0ofXjhUpmAZ76vJ0zW.3EIjHOpSSqiZGwr_F
 PxPryPEnGnaO9m0jUj9iedP62z9KXadwgklWwgV.1yrm327pKMOtImYDvVBRVIi3kY4TAHKEFUfO
 tXcW4vuRRsxyxBlVz4r.amz_Af9fZZGH4lLNJ77CcH3sJf2LB8nYCsxV7BXmBcZ85JR_HQk9f9WI
 eWw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 65b2555f-ba57-404b-b211-4f7df9a05a57
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 1 Jul 2026 21:41:54 +0000
Received: by hermes--production-gq1-6dc558886b-tfbv4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 984b9385c4c6f433da7a05bd9bec98cc;
          Wed, 01 Jul 2026 21:41:52 +0000 (UTC)
Message-ID: <c9abd9ab-3379-47ab-ad41-79cec8f465c2@schaufler-ca.com>
Date: Wed, 1 Jul 2026 14:41:49 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/20] bpf: lsm: Add Landlock kfuncs
To: Paul Moore <paul@paul-moore.com>, Justin Suess <utilityemal77@gmail.com>
Cc: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, ast@kernel.org,
 daniel@iogearbox.net, kpsingh@kernel.org, john.fastabend@gmail.com,
 andrii@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
 kees@kernel.org, gnoack@google.com, jack@suse.cz, jmorris@namei.org,
 serge@hallyn.com, song@kernel.org, yonghong.song@linux.dev,
 martin.lau@linux.dev, m@maowtm.org, eddyz87@gmail.com, sdf@fomichev.me,
 skhan@linuxfoundation.org, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Frederick Lawler <fred@cloudflare.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
 <20260407200157.3874806-7-utilityemal77@gmail.com>
 <20260701.ze4eph1eKo7a@digikod.net>
 <CAHC9VhRfqSoM89WC6TdQHapUVQe8a18rW2c-F7+tu6EjM9EdCA@mail.gmail.com>
 <akUH13qbsEnJLgQu@zenbox>
 <CAHC9VhSjRcMr9+5dMkep_TPKduYdob-bZ73FLfXd_o2xiWwOSg@mail.gmail.com>
 <20260701.jei4Paej3zen@digikod.net>
 <CAHC9VhRzZVUz8icZ2RD9OVvscJdZW3ivPERJLEkNi5poBeguxw@mail.gmail.com>
 <20260701.oTeikequi3ee@digikod.net> <akVvkA3kmlv_POsF@zenbox>
 <CAHC9VhTQtHPFGqu58EaFqMobV3LCcTsdzYfxy568P8mU769TMg@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhTQtHPFGqu58EaFqMobV3LCcTsdzYfxy568P8mU769TMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26086 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/1/2026 1:02 PM, Paul Moore wrote:
> ...
>
>> Each LSM calls this once to register its sets. Because registration goes
>> through the framework, the framework gets to decide whether to actually
>> register them so you could, for example, run an LSM while explicitly
>> opting its BPF kfuncs out. (something that should be done at the LSM
>> framework level).
> I'm not opposed to the LSM supporting a set of kfuncs, see my comments
> in other threads, but we should treat these kfuncs just as we treat
> other LSM hooks today because that is what they are: LSM hooks that
> happened to be called from within a BPF program.

As someone who has been working to get the SELinux specific assumptions
out of the LSM framework for the past 15 years the notion of adding
Landlock specific interfaces makes me want to cry. Is it really that
difficult to understand that 5 or 10 years from now something is going
to come along that makes any LSM specific interface a nightmare? What
if there's an LSM that does what Landlock does, but does it better?
What if the Landlock sponsors decide to quit funding it? Or the maintainers
get bored?

I agree with Paul completely. Make the hooks available to any and all
LSMs, or don't make them at all.

