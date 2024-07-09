Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28E51FA3
	for <linux-security-module@vger.kernel.org>; Tue,  9 Jul 2024 23:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720566045; cv=none; b=NM7457Fp6ngKiI4ts2qwTcAvvDRJ2iZ5AIlqgeVaBQpgGK3835l2Kg+yfsUofmdsztI54eBRfzwqBSVBFUsrvi15VMAE67foV5os/F7AjPV8Ij14ij15CHQaqzfxcGBUXD8pABKY9YVBx2YEc4Bz2Xaug210yi2q+9/yQt4HTaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720566045; c=relaxed/simple;
	bh=4JODEydsWkMnWjGD/kq7LyhWiMLWK+jw8CGDjGkCDik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CqySc0gApyWw8xT5fZheCcv84mOZZTQJ35B9voVUBxLo1svlnbczPBMcEaOLVdJjkn1GFmPttdjklLqmTUzBGel+taGRYxiN6HLHH/qKIBlHuwsWGIX6fUynzA9OD4OQfufqGmSxOxSNLIRPqicvRMCE9qBGka5ndwp7bSFiYRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=fNd6bgDn; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="fNd6bgDn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720566036; bh=NYs7nZOF1PR2THT/JOfNyFMktDrh9Z5oKxEx+Rj6M2Q=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=fNd6bgDn96yCZt0rnjmWC2s0iPWec1UHQH+q0Rxpixxt3GIK02oRKQNi5hz6izVHPDZKjnP2jk0CtlR6f1Dv1gcowkGawIwVwn1GsOpvTWkovsY89Cn0Ggo4y497riFgjCW70h3/NdwcyQRXLWLn9CYp1cRclz6upRv23f0BrDlTJTst10var6lAFOG4dlMJx5Zvvn3LsNXrI4V9WanRAEBnOV7nOxrRxzpqfLRPzPgyTUvvhEaIv+IsuLU0LsEAVNH1vE5oyU9DOHLjOdntqH8ezrOjMKQbE7GUdVIHBUYq6NA/gO58rqKqR+yItkqtamWcHvPMwVD2p1FikT2rGA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720566036; bh=9a/h1uRcfdUViSFpIfbQHhyg3zLv+hxIcKAD28/yJJ3=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=THDHimI1qcc7LFxFDkxFJhcOwKkOLJZGWc6SQPZpnbjjO/vf11E+M8Jn7ubi8auRM9iQozAuRY4+vAUJN7zLbHKTzD3A9LkXW2KjNi68QaOxLcQSaKXC6zoG/9kzakqwWfppCvMI4DhDZ+UZhaWZuf2hdcRLdBaS6ATi40a1Yj31zUnDhCTeRkzEcv6GAHMzg7Ay8BjAUC4r5wjP/cMjiUcdZlGkSLjn/hQ0SMw2SmuJJlgn5gT43lAWemX67T5KU1+Q7g7vlAhGoOlQWvef4ej/PfmyFvzABmIXIewtRt0eFwbnTsJ3lcaAA5UntwWHtqMipgMPRJBJbCJS/Grc+Q==
X-YMail-OSG: Z84olioVM1l.fNt__TexrI3vBF7eJlz2hGRoI19kM6nxEJf3EvqoNQT_7sP2_fX
 3GDGlnqacIGWRCGoJsLOnIyFjGOwb38uaC8ksOWojixxEg2VH1QWnzAXJUOK8ZDM9I3JhDCGWIqn
 VceAJ6quYOW_Xmc96Ag1EZ6wFi3t0_Hhj2Pw66rlN7TMdFAr9F7peda7eCt2mAdTvGqx9iulzw6n
 DIMIA03.zNe041n88vVs2XPWgVaU4lF6xoAsQPljfEd3QztOdLynzk.RcDXyc8yAMm.yjC20kM6M
 IZFPtpRbkYCDBQxiE8mXugtvubNGSyxxZEQ8hnrIlzIUY3yy7w48HgLGo303CmqRFgxYVrNRKmjW
 ritVPgJP9CTKKo29nEyHo.wmZpLklXy9REnIR9NHWu05hiHt.jQrqK0E7g_HN5W20XYersSAh2Gk
 1HVQHHsw3cWyw6iDy_0GpVsII6ZIHNqRJ0kgJhwP2xhpMF9Q4iQEh4EerR9UmZIiFre.LLNz0uqO
 XJLDJyrAZ_BIhMwBXfhII65EALw9yW2vZFXk3X8dgChSIbPTLjbwl_b3L0f46VGSZtgCIbL_zK3Q
 gBs8HisxWC5MsIOw6eGVy.WmqIGVkyiHlGK3cQ0sjNI5Z0Df8PXBumfeLaXOf41qYfsVsrSfmmiM
 bGTkWtWhXV8UnYCfgY_3nKIvyq.RKw8qHa6HCPnRdG1ol1Mym0AyZRdQqLwDW94FfvpmewNkDooD
 eAYUAreV4vGEgHxP.HSEBLuWcDiXfQN2Qnny0KgfrnMWhUyOPgfvQR0RZnMOvQI0ijleYwQ9bAqG
 OQKLkMtHPkEByj1IA5cebBnmH97he_pr0pr8xk.p8FD24kPvX1xrX0v4zzpH_Sw_kWZyL63PBM8q
 67wpiNYcDkKEI5hu9VUenZ58yGu5WDEM3DPJjywbwka5x3JafnLGe_KluWml9Q09lDxmojRykIdv
 oBPCfQ0UhPiCxgMfvk6uEvhvdO41WN7HKKJ8Rxb3yEY6v_gwjhpZAQFWroIVPZHdDtVL_ToA3mfi
 EuNycNmtAWz3lFYbtNNG245TyYbIZ2YYwZRgEwU6UxuQjWVOwf6BWdN0BMj0T5tEztH2_YGjrxTI
 NDtVzZnppJK09j4mzfRwdUGQWsrHTCfL1XkMOy22XdpR6EstOvMrW8trjI2SI77bf8ktaU99HoQk
 nb_pJWOvZIRUj6Oz3Xoq0XC3OvFIKdOmacje9rmsWLtjz9WVJxUvEFVj3xjQ11fpEvxCweMeD7p3
 Aom_V7LCWbfDs8tc0BCU9QOISVrStxS1r7WEaphSPdxZYkIkt0b9L1hE_kGKtYWemymrjmD4aHZk
 pYEZM6blgr5s.K9faK12G4hBiMwJci9PEM5ln1REZxlMYKmwVLJBbEAwQatzrRKv2EG_CRxMfseg
 yl2Xt1OCoRcO5xj31s728xVWHqpNBaXD2S1EWOuk744AreWwMfT4a5qDBa3hRbPVTs2.t1YFgXiW
 gS4pREETmHni67Bj7S70afsvw.pn73vPOe_GgZrMyMYScp99UBJTLpQx88qj4G_hyfdvdjj.6WW9
 84UCCOSdywQfx3DHJVS7jX8zdhuY7j3DmNNcVy4bPi2yQ8wpW.hNhlzMJ6KeDzIbvIANOMShb_0_
 ZqajdUth1wf5xn0FNzkYdRHfO_DH_WM_upiikFcG6MjlhurSaw4.ldinh.avMj.6sMLqXC94cNZL
 UNA6GVT1AoyUF5A25689A_qYAAXXRd9aFllX274wOsLJTDgxaVxp9o1or5lvFdomzarEv273yLcM
 5gtcjhC3Xq01NwVO96gkzaQDFnxWHOh.cKzdwkfku56WC8Yhee4E8iq3LZpZnUi_APAD7oj7ykdg
 abzBdTHHSAKrImr228P0h6pM5knS0YkZjdTaADfaX5_ANC_zF7vqh.GNzE9CnlEP6lHOIb6JRuuG
 hfWjI_EqZUOBCzUrYDrRDwNvSIe0eAPwzDaa9r_cemuPgm57awSWQgGpU.QfGaxDtzA1fTvgreeb
 8DZfEdzI..vFOMVdbWI7HkZHhNumG7MIwRaBRbZOSGPthQii24uVMZ2igxhl7xsXwNa0cDaXZWvd
 dC5dsJyeiIajZVnA2wCByp5oGcAKii6Ef1sfcV0HhTMhCezz4Z6jkEzrPYLYMQnutUKPIxkCkRcE
 DwknUAPaVpkiEy3O1K1Lis2ib.7f.zEwsz8Q2Y8qJ.ig7Yu8wDlSsbN9Wp3qsCHWNQe.Iqca18aR
 05Z0.uicY0VaJXJFIaJxytDMEsL.9_bHeW41DgXB.udleoSjypthnfP7Db3WyLhNLpf3OUOcgCe9
 c1H9YviP1
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 9200ace0-e159-4216-acc6-6ac9687b1259
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Jul 2024 23:00:36 +0000
Received: by hermes--production-gq1-5b4c49485c-sbfr9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0390a73f9f2614f1ebbe63609c46b3ff;
          Tue, 09 Jul 2024 23:00:34 +0000 (UTC)
Message-ID: <f815cc68-ca2d-4bd0-b5fe-7093b5bc5e4a@schaufler-ca.com>
Date: Tue, 9 Jul 2024 16:00:32 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] LSM: Infrastructure management of the sock security
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org,
 serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com,
 penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
 mic@digikod.net, Casey Schaufler <casey@schaufler-ca.com>
References: <20240708213957.20519-1-casey@schaufler-ca.com>
 <20240708213957.20519-2-casey@schaufler-ca.com>
 <CAHC9VhR-OOsjS-gB+Y35_bsLxTS__eJEwrYOrzLYou8gU10imw@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhR-OOsjS-gB+Y35_bsLxTS__eJEwrYOrzLYou8gU10imw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22464 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/9/2024 12:15 PM, Paul Moore wrote:
> On Mon, Jul 8, 2024 at 5:40 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> Move management of the sock->sk_security blob out
>> of the individual security modules and into the security
>> infrastructure. Instead of allocating the blobs from within
>> the modules the modules tell the infrastructure how much
>> space is required, and the space is allocated there.
>>
>> Acked-by: Paul Moore <paul@paul-moore.com>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Reviewed-by: John Johansen <john.johansen@canonical.com>
>> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>> ---
>>  include/linux/lsm_hooks.h         |  1 +
>>  security/apparmor/include/net.h   |  3 +-
>>  security/apparmor/lsm.c           | 17 +------
>>  security/apparmor/net.c           |  2 +-
>>  security/security.c               | 36 +++++++++++++-
>>  security/selinux/hooks.c          | 80 ++++++++++++++-----------------
>>  security/selinux/include/objsec.h |  5 ++
>>  security/selinux/netlabel.c       | 23 ++++-----
>>  security/smack/smack.h            |  5 ++
>>  security/smack/smack_lsm.c        | 70 +++++++++++++--------------
>>  security/smack/smack_netfilter.c  |  4 +-
>>  11 files changed, 133 insertions(+), 113 deletions(-)
> ..
>
>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>> index 7eed331e90f0..19346e1817ff 100644
>> --- a/security/selinux/hooks.c
>> +++ b/security/selinux/hooks.c
>> @@ -5495,8 +5488,8 @@ static void selinux_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk
>>
>>  static int selinux_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
>>  {
>> -       struct sk_security_struct *ssksec = ssk->sk_security;
>> -       struct sk_security_struct *sksec = sk->sk_security;
>> +       struct sk_security_struct *ssksec = selinux_sock(ssk);
>> +       struct sk_security_struct *sksec = selinux_sock(sk);
>>
>>         ssksec->sclass = sksec->sclass;
>>         ssksec->sid = sksec->sid;
> That's new :)
>
> Unfortunately I merged a previous version of this patch into lsm/dev a
> couple of weeks ago (see below) which appears to have a bug based on
> the changes in this revision (lore link below).  While I'm generally
> adverse to popping patches off the lsm/dev branch so as to not upset
> any ongoing development work, given that we are at -rc7 it's probably
> okay and much cleaner than doing a full revert; I'll remove that
> commit now.

Sorry 'bout that. I had troubles with kernels built from lsm/dev crashing,
so I switched to linus' tree. 

>
> https://lore.kernel.org/linux-security-module/CAHC9VhQeWF814h8+ho3uKuz+NvvFApwJo4FkdmoRvYpuTcrk4A@mail.gmail.com
>
