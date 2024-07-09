Received: from sonic316-27.consmr.mail.ne1.yahoo.com (sonic316-27.consmr.mail.ne1.yahoo.com [66.163.187.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30BC1FA3
	for <linux-security-module@vger.kernel.org>; Tue,  9 Jul 2024 23:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720567763; cv=none; b=l+CckiGTuXeu4rvx9KcUNWnsXNS0nSp74HgExnqNSeMbjJkSVayCUo+WkJ7KboZGT9ZdqqQLBLuWNYq0WD1edt0hLHAISwXtvEPbYYKjJyEKKHs63R59egOUoZczKPfb6PVBcunj8VZV0nV4TN9DHRqdkcwbylgm4s3yN2tsBnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720567763; c=relaxed/simple;
	bh=D4QqHq0Smlh9kWEXCNEgrkLHldkLfT2QHQNDpUaOfj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CoKjKlPiSTf9nuFwkw/SQH4QVAGNnQNQDYUttfzZoFSyvi15KhtKN6XK/v5pnkLxanc0WyI4/Hxl3ThNymzuuNfNNnA7Q1qy7ufovKghfxtXVBiEDBiLpGXEq8IN/l+fse+w7stYbBO0UPtt68S8VAqm2CXF0nVsqUvl/VlWGS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=AQk/gr/k; arc=none smtp.client-ip=66.163.187.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="AQk/gr/k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720567760; bh=2kbytU94C9ET8BdmiNtibOr2X3EZ/dyFxV/PlrqOt2g=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=AQk/gr/kV6cd0I8CcIJfWUnxlncG8Nr/loYxblCshJ2utGdVdbIGEqfta8+bw22dPMFhV7RFQ4d11o39BCMsthOc0O/dGNz0N9ZmzfBjFQaobGM4TZofj4CoC1MGRYucMiu8YjKkblt5PU5WNOFgYUcC5w11bJRCL6Fb263QPUIvbn8xF/Fp/HOPKwci+NKTeZvp9Kdtt6kOVVGyBU9Z9MruADtzfdbIOWY9dcpYo/syds5LBeYejwtPDIpq64UMzI6P4ed41jhkEwVU1H6FvQeHOvXjzI1Ig0v9YdszUrFJK55o79iIrVTRD3nyCMXyLro1hE5o3chy7051fovi4g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1720567760; bh=Rk+BKWirh9uUBElKXprumKvtxdzwGPaLqjTvdeBFWgA=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=uIoZj6aghC3r5TsGIF/wU1Lp8ieZzLsWNzaDplqDct2lU51rnxxtWoz0c/QpgMaksVrmLfcKEeady1FvyUedHj68suBF90Pih1ZXsf9ZdG43cIdDmXRDht0UsThCu2W3S4ammJHFif+LOUNGEuVR8wsvEgP7Uy0g1Hu6LJ8VxA1rjnCbyEoHw3sFKxu3estdzmWUFLAORwrV3Jeem5euiF1psI3gJbJjRj77Xvg5+OrnJ9i+8CrwOK5OOynJnOIv4yjRj3znaEDue3/hqFS6DSFjT5i8uX4lTLHD/FVxXn3XhJ77hloqv1BTkJGf8jTkvS/c12jpQoUaJTSahUEFJA==
X-YMail-OSG: 7Ar4nS0VM1mGzewVDzuJQ6X_Nxefr9gNCLuLQzbykX9p22RYr1q7sj_jkdC_.da
 VVQA9KhCOiB.NjALTLLrNlteXy_D9vC2wdSwYS5JKs3EnP7511.lG.WaLU_AweicKjhnH_Ea9INc
 I62htVUrzN_pNJfv2tBAO_QAk5TXSQezjRWl5nNuPgd55_u9rBR..kbQADGvTV4A2XSh7N08CxK3
 jwjCYDWnT_kQNOXqquRbC4pOq8tCT07QtCcKhFSqUSAwmo9y_WeNv6KOKg3LGeqi6PHb9N4IIC_z
 y7BF_dnp36VMEqqzwxqOX3xzPd3P0OLEMFaUOj0EuP_Xfe113iKPNxaI9jdQKgFVNm64Zb2roKJc
 .KLEVWjS2XEhuhqpw_CGkst6ywI6m7bduoHhNnb3ZI.VY1ITPxcvfcTC1xhc4CuzA_95bGWUpHtz
 j6ED2.cnIQSNz3QcxkOYZct8b99nlCzPgdiyD2s6.9ARtGs_bfQtptKPmzgzFTuTxl87zfbH4H2n
 tvNHpVqMqlfJ9mObkOiq33buWLdbITuJsTNd0rwWR7TJgPPyOdm.QEDUpXqYCii4m6jy.HZ8FkZN
 UKX.nqu3GDCnw1zZVrQsUtPW1Avh9g9W9lQVD_a.YbKjE7YvD45DyW4L2oCFwDq1cqavfSZPHT2L
 bhpeJqnN0ajP8t1oknAMX1aBNByEqYztILZ4hA_ghInLE3xd0m5bQM_HCSgJKW7ueYR_u21.nuPV
 TK9DiA6fDkREEFXOc9ZcnxUh2Xt9.PaMBuB2AScRa91sQHiMKcgd2Ep9EaBVgSV9_5acKSN0AMSb
 eRJuLTVkU07fvmO_A4WAH7S6Q5zIjD0vrVbrQeDitIKwJcj0De.b9KchGBMSmshiVGtnGSMvXo2p
 5BFZEauJTWv3eNlCcriy3qFmoB.9u.4iF6Ca5RhcHD1bsZ9jSSHwZPs2BgeRhNvFWxhG0T57lLAn
 VGvLuZvmplEZoN6J5jrTHjAzDZvcAXqVWX3YngC2JViIJzRXnwmFmMnZA95maSHUwHxvpfYn_gy1
 npy6R8.Yw4jRsQKE1jaU4s05xFLc.2SxEu0aBSWwhyvlZb5qPvmZyGbU6YJ2ZdMNm20noJyAqB2h
 _JaEMrEE8fmiYyw3PiwiTcWT6B0XdiPRpbJeEmKI5if7Cjp0H20cdgeIrPMq7kXq_X4rdd4ls1im
 _epuY8Q.NZb2MOCUlroKNgo4OowmIGmcL2gc61E_Ka1_1IDbvg2YOFKMKQdGLJ9EPyqR7PQ_lr1s
 zZ5MDKsEnC7hy2Dty_FcXQewfikJ93LHIpUKzwaizaaE2Jc32j2yFlx8gcXBJsRvYVvasPWLiWFt
 2qqc61T0D3UW__.Z0sH3hUk87nf7hAN65IjPlOq3LxWSPd_PPmFV.yvUlCWkEV.ylrnihGig6mrl
 fSp0AcnK7HXZwIoN_id1fNNaFg7FHVAWd3LfAUyMeYc4UczDOGFgAeLDy9wKm54qKybG.dtilpZi
 hBlxemR_n8rPzMYkm9CENJPQkX7AUGjIkfiIPBex4LruF1PD0OTB70D311jcSh9Ek_rU0SYXsEWz
 tlsgo5aOBfhkzz30ZnESZzGDDyGPEgxKC.fxZa7AXC6.ONs9EdAszSpgWk7tahEP_vH.Ti9clepW
 8TsK1uhHMINZKMa70Q09XDYQsO1lcKtB1QTSbCTo_Qtj2g8KMBE49MBY3E9Yg.fsRgv44d4s_C33
 fxf84NQSnnOdyXp9.jqbwqTLQpRALxNYK6rrij6bUxz7qRouh7Sn5IlWWxguqpcdGTtphy4yUdt2
 oIXwDorL9a.FjzvuFIrhZyveja2LtaoZUogLH9dOnYywlLtTzfOAaeEY6FMsPM87FSXySH6Nefzz
 v87vQI0mNOcOKhDg4Vi5Vz2uNexhMRAhchMRDQ1Gic125qh1dysWcHkK9YhRDTd99fm_uPqZknzg
 amP0J4HiisNAwJ0R16Z3SvOlRupzfIpIFCwQJVSzueRbCEitRnT9gpKyhM8zYQfS4wWgre0SZKOY
 SnP7CLt2uIsWlpWOjwIsmg4BgRuiG1xxXPk6rKnikp6RxyZjYktYx4X338fLVtBYbt2v9GfX7Yba
 hHN_VHenpQI.XR8o7AI0ZGMMHiHWDIPtE6sXPQ1lLQ8GkqL1FhiWIc_ih_7SBA3pW_0pSfVth8Lb
 NUaPVNdy6yk7QKEYfxalLfmVU5EDTUPeYZVXV6sjR43oOkrN2S0VeYpa.Pk6np6pbOpWllCv5bal
 8lBi0lh22eN5H6qMtQwT4KLmWDvaBhURylTMQpxHoodBCmnYfveDVsNvIFhv3y19q8wTM8RsHvOY
 YbSRpmL08LQ--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: cdccb336-8414-4cb0-82f4-154895454d70
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Jul 2024 23:29:20 +0000
Received: by hermes--production-gq1-799bb7c8cf-zh7nt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9b6bd9bddf87b7cf998d00607d78f5f6;
          Tue, 09 Jul 2024 23:29:16 +0000 (UTC)
Message-ID: <b8744973-2236-4f1c-86cb-27c92e753bb2@schaufler-ca.com>
Date: Tue, 9 Jul 2024 16:29:14 -0700
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
 <f815cc68-ca2d-4bd0-b5fe-7093b5bc5e4a@schaufler-ca.com>
 <CAHC9VhRrKOcayQzY1GeExqufzs=COGQrkcnKeW-kAxKrrr0BeA@mail.gmail.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <CAHC9VhRrKOcayQzY1GeExqufzs=COGQrkcnKeW-kAxKrrr0BeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.22464 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/9/2024 4:05 PM, Paul Moore wrote:
> On Tue, Jul 9, 2024 at 7:00 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 7/9/2024 12:15 PM, Paul Moore wrote:
>>> On Mon, Jul 8, 2024 at 5:40 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>> Move management of the sock->sk_security blob out
>>>> of the individual security modules and into the security
>>>> infrastructure. Instead of allocating the blobs from within
>>>> the modules the modules tell the infrastructure how much
>>>> space is required, and the space is allocated there.
>>>>
>>>> Acked-by: Paul Moore <paul@paul-moore.com>
>>>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>>> Reviewed-by: John Johansen <john.johansen@canonical.com>
>>>> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>>>> ---
>>>>  include/linux/lsm_hooks.h         |  1 +
>>>>  security/apparmor/include/net.h   |  3 +-
>>>>  security/apparmor/lsm.c           | 17 +------
>>>>  security/apparmor/net.c           |  2 +-
>>>>  security/security.c               | 36 +++++++++++++-
>>>>  security/selinux/hooks.c          | 80 ++++++++++++++-----------------
>>>>  security/selinux/include/objsec.h |  5 ++
>>>>  security/selinux/netlabel.c       | 23 ++++-----
>>>>  security/smack/smack.h            |  5 ++
>>>>  security/smack/smack_lsm.c        | 70 +++++++++++++--------------
>>>>  security/smack/smack_netfilter.c  |  4 +-
>>>>  11 files changed, 133 insertions(+), 113 deletions(-)
>>> ..
>>>
>>>> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
>>>> index 7eed331e90f0..19346e1817ff 100644
>>>> --- a/security/selinux/hooks.c
>>>> +++ b/security/selinux/hooks.c
>>>> @@ -5495,8 +5488,8 @@ static void selinux_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk
>>>>
>>>>  static int selinux_mptcp_add_subflow(struct sock *sk, struct sock *ssk)
>>>>  {
>>>> -       struct sk_security_struct *ssksec = ssk->sk_security;
>>>> -       struct sk_security_struct *sksec = sk->sk_security;
>>>> +       struct sk_security_struct *ssksec = selinux_sock(ssk);
>>>> +       struct sk_security_struct *sksec = selinux_sock(sk);
>>>>
>>>>         ssksec->sclass = sksec->sclass;
>>>>         ssksec->sid = sksec->sid;
>>> That's new :)
>>>
>>> Unfortunately I merged a previous version of this patch into lsm/dev a
>>> couple of weeks ago (see below) which appears to have a bug based on
>>> the changes in this revision (lore link below).  While I'm generally
>>> adverse to popping patches off the lsm/dev branch so as to not upset
>>> any ongoing development work, given that we are at -rc7 it's probably
>>> okay and much cleaner than doing a full revert; I'll remove that
>>> commit now.
>> Sorry 'bout that. I had troubles with kernels built from lsm/dev crashing,
>> so I switched to linus' tree.
> No worries, that's fine, my policy is that I'll typically resolve
> merge conflicts so long as the patches are based on either Linus' or
> the subsystem tree.  In this case it turned out to be a good thing as
> it highlighted the MPTCP omission in the commit merged into lsm/dev.
>
> However, do you have any more detail on the lsm/dev crashes you are
> seeing?  I wonder if it is general v6.10-rc1 instability ...

Alas, no. My VMs just stopped hard, with no panic or traces.
The problem went away with rc3 (I did almost nothing with rc2)
so I shrugged it off and moved on.

