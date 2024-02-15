Received: from sonic315-27.consmr.mail.ne1.yahoo.com (sonic315-27.consmr.mail.ne1.yahoo.com [66.163.190.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871A48BF8
	for <linux-security-module@vger.kernel.org>; Thu, 15 Feb 2024 00:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707956001; cv=none; b=SHFdxwMdBYyJiF+tLqsiQSP5UX54pkELwSr1VIi+J909j28UaLvA0AwYf8a5yQLsolmYyQVPUVhJpMRxHugrISNwWEBowNwn9ZXtCDh46NaEwPYxide/847MICedTr4UOeDdNQG+qge1bnA251BK0iKLb+Qkckp4qkAECBGtn5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707956001; c=relaxed/simple;
	bh=j3Xontd6i5BDPaPURyWEjlhm3WvaGCmPbPpAXDAFP9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AzUJNioZY2OsPbVA+S79wx4y74jzB/oPkGCNdbXY6ykAB5X9y/VxiNb/xxne9tFnw+D/LdnEIqXeH6Mu8DihTKDE2XzXf3AzuCaW2GdXhX9WcS7EXncSX7zHKHJg6CChP0YfqiYKobR0wuG4GlSHu4/U3zzJMDgpNshz33vuY70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=kTQUk8u/; arc=none smtp.client-ip=66.163.190.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="kTQUk8u/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1707955998; bh=j3Xontd6i5BDPaPURyWEjlhm3WvaGCmPbPpAXDAFP9A=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=kTQUk8u/jzLVU2q9cvU0Nf8vZQ0onEFOgf7JmuY1xeUHV2Gz3h6Pq10whPfKqyLukn3jfd5pkTKhHJLSL94n2lAAvk/bVkRpy587SXfM5Meev0zB100ZVBTX7NsDP1KHnkhd966L8XwluumbFsEOZIC3xHRZbg5nh7nBQeB/RtdW7b7xquCQ5dGuXNc1tdmPX2+qT+3gwMmO9YXH1G/xD4mXjTioHcL2zCX/bAFy2UrMsGkvKuVTkDQqqiW1bYTjmDk8pUEQKECmKs82t2WwLCDraPsqQSdTPKBJY0tFCYgF9jUQexTOHdayXgI/+D1qlqluMYg+RsEQ/BSNCQDkRw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1707955998; bh=eTV1UlIAjxiRjunKwkSw7uPjo3h6FcjOS2LcNEjm+Sg=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=gO+ZkSMB1p4BheyIqUWC9mRmjwYR8QH2nHJF5UuPh315jrgpp2nEiv/aJvrKPIoHpXnnzvpk3KenGnsZwpbEuFcX6ijWxaKmG+muIgCb+2akSqBfDQi7rGblAcN5RClZSE2qotehwcIBlsyggmq4fiNIPNmdu5EOihif/c/z3sMZRkKICcJjuWf2RatOktonIpPuaKJEGferUDiwmwZWwvTyR2+ue7PKXoYhszGl+msYUDYm44QRYoNB/uN0WN7lV1cOfz5rOA+UFwb3SIcxEyRO/ItQPYJC6r5uxpAJVCl4z+/oS6CLtm6BcmwyiamyFI1/Na09mDiaQgBD8JJx4g==
X-YMail-OSG: BbRsyYQVM1lnj7e87c5ALW9F_iV6Pk15odZvTMCiLjU43iKBmIYi0erLdWtYhEW
 bBMJQqZ8D3S2yYHyjMgW_k7iyarh2mbLvvLEHeKJYyS85Byzi6O2iWoLkl1fQNVLnQAB1gmwPWun
 HYz.41lorEpgYEkgHKSHidjj19Itnbb5as9kZDY9TaVectWBEMIUL2m5DYf5rY8f7eM5HkmPhEKD
 XnNOMtFOVbS2wHY3kX3jzXWnyL4bXq3CoCrTpQdjOvdfS3GXe_aXF5s3.Lo4j3L2weuu8lTFf1sw
 aSScEAh6Y0Un0bSUvKqjFfkSUiS1vbLHj7Hq8b0DjRyTful12SsQBFGBVqFzdOFNbbYdqh2rqNdy
 zDQvgqD8UDZvhVs7bS_KCvw4V8DzXtfbXfpo8T5Y6Qs99JZAEKwf_ACuGFTZeDMO0nCQIefVCCEE
 mlZYpY8AIVBK3Vag96jngQLVcHtv9e853oRH7p2d4H9Kk0LSJ7Q5Yf7yuSeoXc2q8U5PO5d4rZ5U
 z64Bvk4yQhAfHEjqhECYioNb8O9ag1aVoCidp_phiA7xUV3Is97K5fDsXw5yveDMqXvym6zXH0OB
 4.9kDD_S0VtAhdqvDEEa719F2Fe_3J4kqaGfiMLMStspAEUP3_LmYBFL44h1i9LtZgLSG6Gz9dE0
 tQg5kM48roDBwDwHPZ1y.dFwRQm4M46.rEXQRq5Zi8xvOkN6SCMg5kiHr3GyfjV7WQMkw4T9athu
 PLRz6ntzx8Pgi9vDKGM7eRcwxLfXY8maq8JL0FF0tnhY.cnxHXqhDp8mAYKBgoUVjC1zMiz47DkR
 FyX8i50R_15gGHvwgve1aFj6ap2ZL4Mu5OeQms.RLblAZPbwzIVhyukcqaaY3EMcCmAPcIxOrTuA
 1WZznsZJg4P.gpo0IbenHgFWe7NkV_WtxNrbPryI2c.2n9i0EoRMi06e0pyYJLwucKyKENkQvuR5
 OAN_ryokYWOFiTCQQllbqqKMjareaBMTQKZWAehANZmYf2yg8g6QB.R2.1FZn9ng6wwg3YMbEvTi
 8cYnKJxVQE3V_nGdL.divz3t5NiTZ2QV8yIv6qi596cuslSjDIHDeFuL8jUv8wqLsYGnJnmorm6t
 lK2I4HdKKoWxrzGE6WdI0jWCZ_drEZpalhQ.uPORxMLdgcrai3WvSleY5.bFVb2loPh5mvN7cBa9
 ZMmeGl5B6zH2M8W2M2i_ScbZN1rhHMOe0N3Q7xP3tbouVesd6vpDysenaiQcTUtb29Fciec3uFCJ
 obJeOQdEihUbbWYko5zAbRiBlIgqhI8exk7s9Gm91dDKfnAcackmxeAu7tKzvS7BrSiPfx4vYLbV
 qQxDiOhyKi1ZMYWa3iR3D1SXA6T7f27y_4cjMZaBkjok1u5IBPy9w7FHB5W3MSMxVx.ns8voLqWk
 TlqbzA6Rugdp.abjLl45DSTlvJTuo7C_BnLJClKe6lfqD81Pv84Y_t8tjl5.SScXYY9I_uBinbzx
 RmzSjKIfy3.L0Y4SnMGtzwIoniK.AJeUUNRDGk_8yHhqgzzXa_mH5x3.MXjyXJX2DkK.T7Cn4oQ2
 zhU8RzWKIEF98162Aow.0qrPHRitGzu73VhdeVhYV4I.Kg.Rgu2PBjXDyxcU4mxSMxTiQ8f9Qdxn
 SUatrfyqVQktT5rgFoT2TzAOIZVwpFfSwZoKMWaojhES9FZes6PhN1OVZjJjqrV5dkqxoBhGBjQ9
 qLbsHBp_sBOSb0nI1Ln.hkaHkMnn1unTw25RFURDv9QW2pgaNbToqHVr410cDrYZQgqerEB6G9vJ
 3ETLHpn1uHBMM_RjxmyKQtAJcZyMosRyhUtCFje0OZGPJ1JfAXuY.vI22KMNgqcTVNKOGfjL4mLc
 M.4SKYthScg1GTR3iQn9x0Tc5a1zZ6C4BWklCN3w1vTIhp0ijjkt5TZN9TJrw0IEfQem7gWcPnfc
 mMPm7.DTR3SL6.OZNIy5JRYCk.gaxHaIkL7EdC_X4IOC5KbPPikFoc.jWbQ2Z4dmjcotS.3CM8GV
 6vYmLNe56d1OvEZloPdNnfbNwj3SBzvzJZiwENK5STOIRjtF0Gnm4_b3ERi5UioVz3B2ddCoFnpZ
 H1RlZTJO8Gea7MyxLiyllPW8redriNesm5FFdo2hSOdyNGxxz7OdtFDI2Zhpe38J8K6CkrCkLksI
 4RJe.2M6pmW3MzOLXLys_djN8tBGh8Y3ZbXjSdMWAJYFnpSNyqVw703XZXg0gqTl2WE2h0N2gexD
 021pJ6o3IFEiQ5R1Oh6HmCq.XPNfNZ.0dXi02mzVzSGxnilzLtYSI7e_eu9MxaqNSJ6dW20s_Yav
 JR3Lb9rF5E5iI
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 8ecab171-32ac-443f-93dc-368d08620b83
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Thu, 15 Feb 2024 00:13:18 +0000
Received: by hermes--production-gq1-5c57879fdf-llxbt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 05e4db47e75582b84121cf35eee76cd6;
          Thu, 15 Feb 2024 00:13:14 +0000 (UTC)
Message-ID: <6e00373a-a028-4575-b2cf-d4da366c2b6f@schaufler-ca.com>
Date: Wed, 14 Feb 2024 16:13:13 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: smack: Possible NULL pointer deref in cred_free hook.
Content-Language: en-US
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Paul Moore <paul@paul-moore.com>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <ad9dddfe-0fa1-40f6-9f8c-f2c01c7a0211@I-love.SAKURA.ne.jp>
 <fa719d6f-1960-491e-89c2-ed2c14d184fc@I-love.SAKURA.ne.jp>
 <2fa0a73a-1d03-4937-8599-e4560297af3f@schaufler-ca.com>
 <f15e4a73-02e1-4758-a8e6-0edd27224c0a@I-love.SAKURA.ne.jp>
 <757dc423-f914-44b7-98bb-fde5cd42d33b@schaufler-ca.com>
 <b240a8ad-240a-4bc5-9414-62bd417f0b92@schaufler-ca.com>
 <CAHC9VhRdqjWa0Zhw==U=kLNiSeYHDWnQyP8Yb4JNtTA7ki1gqw@mail.gmail.com>
 <8d093ada-995f-4291-9c31-35d9a62525b7@I-love.SAKURA.ne.jp>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <8d093ada-995f-4291-9c31-35d9a62525b7@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22077 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 2/14/2024 2:15 PM, Tetsuo Handa wrote:
> On 2024/02/15 3:55, Paul Moore wrote:
>>> Ah, but it turns out that the only LSM that can fail in _cred_prepare()
>>> is Smack. Even if smack_cred_prepare() fails it will have called
>>> init_task_smack(), so there isn't *currently* a problem. Should another
>>> LSM have the possibility of failing in whatever_cred_prepare() this
>>> could be an issue.
>> Let's make sure we fix this, even if it isn't a problem with the
>> current code, it is very possible it could become a problem at some
>> point in the future and I don't want to see us get surprised by this
>> then.
>>
> Anyone can built-in an out-of-tree LSM where whatever_cred_prepare() fails.
> An in-tree code that fails if an out-of-tree code (possibly BPF based LSM)
> is added should be considered as a problem with the current code.

Agreed. By the way, this isn't just a Smack problem. You get what looks
like the same failure on an SELinux system if security_prepare_creds() fails
using the suggested "fault injection". It appears that any failure in
security_prepare_creds() has the potential to be fatal.


