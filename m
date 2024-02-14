Received: from sonic306-27.consmr.mail.ne1.yahoo.com (sonic306-27.consmr.mail.ne1.yahoo.com [66.163.189.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D951460DE3
	for <linux-security-module@vger.kernel.org>; Wed, 14 Feb 2024 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930657; cv=none; b=Tc3xSTRmBMSeS9LRtvn8gJE5MlddY6oVqiaVN6irK52VIAEhbHIPmBDihRig33SdeDIcq6t7519V36mdempprv19CWDfoyXGUCOGvvU95KvwgFouFtFo1ne5z1hB8HN/oXR6XLpgWvpnwasKIABTMc2kqyfoKmgmezY6hDqqY+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930657; c=relaxed/simple;
	bh=4RaKoyRsq7SpA3u+pD0pmGxqhYfyg35bzgnliNy/Mwg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BXTEfCOOZoBNQJr5QsQoJKWj1rKYq4InyrN2IRubZE/atT3svCtZDW/9pezcy1R5FF0NwkiBQZi8ZnfN9HR97jtAXOD5xiphEyxlruRnU91hyiNZ+S/IkVT0Fan0g8zjjVy3QP9hNwY6BpmQkEWPEJ8X8J/nwKpjrTPglBtOexc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ckzcGEkM; arc=none smtp.client-ip=66.163.189.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ckzcGEkM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1707930654; bh=4RaKoyRsq7SpA3u+pD0pmGxqhYfyg35bzgnliNy/Mwg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ckzcGEkMy6EcqKL04TIpLwJeAHzcedy99iCj0hs7hhpyJDYzN5SehfQ53G/Dw8NO/UUDWzTUrzeoQQdsoDCe1Lkcaadefh4oUHLl/3Ushq92D1NNVeCcACaLjc6GlweTfvbYGoSfrVmWaEL1QJQY1T6TGsCqqoTJsUm73FXywDdQwI82txLpU/lBE1jWKTUw6e7UwBZ8qr049gVqiDJQxUO9XFguwjU+my1U1SNSths6ZjLjzDDEZjmqBunh+Sw2WoZQGiJxSuehMdsrpFfj/0DWrtoVyHpq0zXyI8cBeU6Piymj171k0LBSHkRbBoyzjf2dU9+l6wuPFyXbs44X8g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1707930654; bh=MiA3JkSfQFURIilrPMP0mq7fnjPEYYTn5j/wWaoUOtZ=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Z3/hrFXLbDYuQbO9a3GbESoBgpSbWKwUTr94WkUsP8b3b73uyUmYM+T55EMQJTMq5r+bl2AGC6CoLu9gbdpk+INEzoUZNMUr1UtW5WjV3x+v9adwA62piEDJYihirm4VMvR8zHSNPHVivde+E9ti4cHzY5Ceax64uHVVuJXAOgXaqd8faFDeWRUZvpDKXm4ds6DdBCOoqcQXqAlYHKXIUiWNrKzfnf9bpEhQ62MgyPEQHR0xjPry628vWYJJPC7E4gaw564G2KtHJGqL2WBa1M1G3FHfvbjiVDnYEqenKFkZL/bP5pU25CRypzYObZsId2ZRqLOnNrD93YuhQHdTVQ==
X-YMail-OSG: WUOLVJwVM1nC5UBukYsRJ9SA8tugkh_6oiMw64owwEf5XpGRFN8lFnxMFkigLaI
 lWG8rP7iKdtrDXB6DCjCbOA7nT5yQYc5JanQYyaRDqi.mtDirmF32wwunUrnDap3v38uN8fRiklb
 dEZPcm6dXKAwIsJxR0J.k6zly4GPOhXcvYkwoU8kj1V8v6OCcWhbwnrrano3lFgCc5x72Gwy54jg
 sr5T7KcGvgaLASRtyOZCIY5aXp39qgHBFMBJOPzqtflwn2y06Ae9LqtxcO7Eh4o_d16S7LK5jYPi
 02uNCPOb_uoCTk9ZGtx1WlDMV8tfql0s.1ns5d9JUZDLgrzHxVLAV2WuPy9drsorF8TFtUcyTs..
 ZredE0bhmJxn2lHrZm1Bd2Uz9yHYJpKOUkpAR.HtzKP1RQBgr0bFYkAl5oXTnnDyJ85JCU3gXUIz
 i38EhScgyZQxLteRbZrjOqal9dpmqfnE.sRirQCBUJJXnX.IQ6Z7vN.1XWQdFICtS0ZtqfrEfias
 wmOKrWFUpVG0HaRn5KH4bdYICxNlvUtAypK91fQGlf0e73i0tBuqDdl9PVNmalIh7ZbFx3htFswd
 ASBnNHiihxAtQmG2CmSbnLuDkCXH45NnKHzcQ0Xb9ey6rno_exU6j_yovpnkcLFGDGe76sUtDn1x
 qKOUGQCB_5O0aeGMDf4wd0LYCZ_J18BW7iwDuQsAb2aiP5NR3uRiMptRFTLzX7DtPrImTnq2JPyh
 sSER0E3H8SygjUSfWW.OXL6snA7jxJdo.frP8efI3AW5i4Ru41mwohSXSdcz6bJys8vfhgtYG7ml
 y.jtJRl4WfvDrSqOEXlP6e8cCd0fx73iQsl5coopFR2rBon3I49d8djpfYJbzJOyX6ZYyhakBdK8
 9crO5uIgO_Pi.oMyf1pgH72ZJ8hjUU3rWFuEvL7n7MjB_I.57VEcaXqUKhylygfDhFZiHdfSG7xI
 cq9qrhV0E9OMCYd5t0r4RXETmhzGLqg52UC3YhmXejtMupmOpq88SZtPhtfkCrGBKikf7bcCBB3h
 TTS1CKIsw8a7mvV4PJ5gkubfkDlRSvbTBvdNzMFoLBGIskbzPfyXxG6FaXH.8P2G7D3ZHZGCPT_Y
 DwjqRpMNO6iqteAr5opxKkMEBK54jz.6wcXEwxKvKjlX_q_YhecZRf6jVE7QWT1I0oYZBcKHt9OG
 Hpywui94Ptq9BEzn42FcVKvq7YoLsKoBmQ0B7luIJeaxRPJ6hMsxYiFv1XlTI66wZiLAX4uYjXL8
 UBsDQnIxHe7GJ1wOdhxm.kDWMB8LdHrFaCZPGAjyeb_6vd50bnfrTlmdjz9D8RQZj.BHXXE.iKGx
 4yR07A1I2lS0_vjmiF0EZ8_67sMVFpSqE2V6u2q7kQoEjTW9tSUgQCPpZN_HeFQ_LaNSXG2q2HG1
 o4Q6xyU_.7omUpGx.NyhrAUpTGwYouSi9bjiAIgmPeC.AiEWvawFdWEQPkAobWNWBsxPv8MOKxfM
 j8aM9XH80zE1o9BwWpUYF2a2pSr_Ua4vLA3e1mi1hvD8M6xjg_IQzaYC2Mw6F_sgrSkxfVTKfrJo
 EQHHRn4Vo.OcWuar8TtE1jCINKlNKaOkTowK3blI7mjCPzuKkVOwuVwwP.YiBwHdSg6uENxJOA7v
 oj8kNCEoH64hWo5rNeCtB4U8fGpn84dtlMbx7DGXNNo36.GN9UA5KxqnHvDdKjpSGgf6auP3whQH
 8dpyTg2m4l2nQP_l2zxloRds4Qx.neZCRPl6I5S5.3KOtHaKsVyqXbf6gh5ZrtA0rIWUHVDnaRE_
 RcNdSwUNdkiTr0F50_T2_dd.xC5t5MStEi47ZYNWT20U70Mcbd7jkW_vHTX3lj8V2HNLDO3mYMuS
 9_ge_nAGtEGMGpHkIBn6svqK1jr_gBDBKQiBrj1VutfvsxfJpqaLozmWxsM.rXUUl9X04n2.w.O.
 x4T3RkoGl51l9lp.pCTZRSnN.UYr2xBOR.X5P5cxGIhhLkWqtlUDKT4RoHZX8JCEIWG9bKP1iMgK
 DS_ksdT0VPAx5lgHsQXwL3nojUQLHqGterRfpfPWwP4MYkwElKu.BNjqZ_YbwPSqRECKJUxqIaYv
 gHNvmYqS5RbU90VOeQ98UDQJO2yoxAwlZYF254M.V1gykI_o.9y4G5hHqYg9we6IDIj4HmwS0Who
 gUxAbIIS3dpi0TdSqJbGHbQAI0FU5a2.Mvp41Gy_1s.QsHOpquJeA0twzMkiKJO3u0p6RSux_9mm
 hiQCXj25l6nQVxli2lgKMWdldYDFs8fqIvTS9TnktYmghQrpadNtZZuwo4egh4F9SpmTVTy_Dhr4
 ojlw-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: eb282d42-918a-4da4-8559-794adee9a6a0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Wed, 14 Feb 2024 17:10:54 +0000
Received: by hermes--production-gq1-5c57879fdf-wt62k (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 6ac691ce11c8ee7b15390f4c521fb96c;
          Wed, 14 Feb 2024 17:10:48 +0000 (UTC)
Message-ID: <b240a8ad-240a-4bc5-9414-62bd417f0b92@schaufler-ca.com>
Date: Wed, 14 Feb 2024 09:10:46 -0800
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: smack: Possible NULL pointer deref in cred_free hook.
Content-Language: en-US
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <ad9dddfe-0fa1-40f6-9f8c-f2c01c7a0211@I-love.SAKURA.ne.jp>
 <fa719d6f-1960-491e-89c2-ed2c14d184fc@I-love.SAKURA.ne.jp>
 <2fa0a73a-1d03-4937-8599-e4560297af3f@schaufler-ca.com>
 <f15e4a73-02e1-4758-a8e6-0edd27224c0a@I-love.SAKURA.ne.jp>
 <757dc423-f914-44b7-98bb-fde5cd42d33b@schaufler-ca.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <757dc423-f914-44b7-98bb-fde5cd42d33b@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22077 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 2/7/2024 10:53 AM, Casey Schaufler wrote:
> On 2/6/2024 6:54 PM, Tetsuo Handa wrote:
>> On 2024/02/07 10:39, Casey Schaufler wrote:
>>> On 2/6/2024 6:31 AM, Tetsuo Handa wrote:
>>>> Hello, Casey.
>>>>
>>>> I confirmed using fault injection shown below that smack_cred_free() is not
>>>> prepared for being called without successful smack_cred_prepare().
>>> The failure cases for smack_cred_prepare() result from memory allocation
>>> failures. Since init_task_smack() is called before either of the potential
>>> memory allocations the state of the cred will be safe for smack_cred_free().
>>> The fault you've described here removes the init_task_smack(), which will
>>> always succeed, and which is sufficient to prevent the smack_cred_free()
>>> failure below. Are you suggesting that there is a case where a cred will
>>> be freed without ever having been "prepared"?
>> Yes. If smack_cred_prepare() is not the first entry of the cred_prepare list
>> and the first entry of the cred_prepare list failed, smack_cred_prepare()
>> will not be called (and therefore init_task_smack() will not be called).

Ah, but it turns out that the only LSM that can fail in _cred_prepare()
is Smack. Even if smack_cred_prepare() fails it will have called
init_task_smack(), so there isn't *currently* a problem. Should another
LSM have the possibility of failing in whatever_cred_prepare() this
could be an issue.

Your "fault injection" is too aggressive. It should return an error
from smack_cred_prepare() after the call to init_task_smack() rather
than commenting out the call entirely.

> I see your point. Thank you for the insight. This is the first real
> case I've seen where the "bail on fail" approach leads to a problem.
> Now, on to the fix ...
>
>
