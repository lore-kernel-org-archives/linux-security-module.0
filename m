Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD559332628
	for <linux-security-module@vger.kernel.org>; Wed,  2 Sep 2026 17:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.186.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788371516; cv=none; b=PGu/OBXs1KhnsNmZIiSV4zIOFrz4J28O3v202Oj4vNxIxh0burDitJVcGdU04QAjWrkGssI4UYbJrJwwIzQ5487q6Ijb1mUsZbCXjMbf1MXdlgtuc4FEBn2J+cjItPdN2X47aq9DeCSGWpOPiq2qU39bIeaQSmiARTCAzMOKatU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788371516; c=relaxed/simple;
	bh=01NkgqPri9QkZt8yaSdJzejO678xz3mKkHHLIIRZaBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GmHK6oyryIg7pCN8p0slUMaBYv69cLqxFuOKHYjdGXqxlvWv5oGBrbQ5JqNzFhH5XWk0RiQNRrY7qYGPSmcnr+gEC1BIr3HqARQYs/X/hoZmvXsxhpRqM2/xH7xeM+M6mvrqdK+NREvGZP1FOTg0IlKSybWHKmBtVYJYcDwN65k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=lUhZw/xA; arc=none smtp.client-ip=66.163.186.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="lUhZw/xA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1788371506; bh=gxFsNRHXXLDwPQyvTSmN22wePZIGILSYZV1ZgD67Y3Q=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=lUhZw/xAhamUj5gXhYnjtXvQP9DPt331BaDVNTmXtFt717keYzG355M0GqRwZhTdjhLLNgjgLlxvQPMaLEOFZucy0oWM6xE4HU2WukjWc5xXjlaJv2m7VBTM3Uvq/Y3LhuGnyeJzrxSVVIYj2XuCP97rAwH4eHX1jIW9hkccEO/ymYOh6URhLkkwvQ6dyYjLIAP0Ql8cwF3p63WC1BBxomJ4JBFL4qvhrVUNjcVfmt5FUNq8AkpqUtwaK6olhGx2sqBLdCTMdTCKOro23tIFP5tsodRnXoCseBvMj1ZaC9rdglbCSwxRXO6wOv5Koq8wyujFkJx67EUx+bsUdvX2rg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1788371506; bh=Bt9vHBpXIdOR2+BLZxcPit/xrxbEz3TjLATb0a1XYie=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=MudORhLPehutG8Ew8IQm0BW6a+on/g0nSzH0khBa4SbMnCCGT7PWQ5lQCGKo6UduVzGmeTAYJLIJ52/V2ZaHKWeG3q4QGnRv3Eb9ezegjXHWe5tah2jWSAH7gXgPe/GxChWKuaXWoyBheoXGT7OhLN/qXRF87k1B12CK8Uw4GJRt++vEMPt+kEoC6RTguyq/UGjVCR+b/fLbuLKm5BePXQQDkIbAlz9z6XdWdKHDTus9Kv2LS434VRf9roknibNfCONiYF+U3orVpCdZ5ubREzFgBuTR7ssOnaekaBDFMUXY+JQeW2FZhl78NipRVKVDVaeQRgv87vSVc6JC0h/9nQ==
X-YMail-OSG: f5eTvrAVM1m6N.3lr8gB0_BLRtAL9nxzWg4FkZ9CR4WaB5DGbQomPpLFZQ85Xe4
 YfHe0CM0a4H3jucJl6ExfnjeG3o2IMfLolc3rZPLLcUVgCYtdBtrkHOfLAg0TDAdTPVTn3PkKJYE
 4Xsa..qINRIzrl2BnDpipZgH_p5PrVBciMr66yF6jYFg.lLSQBDYJ1r58HUXinXgGiWxP8qoS4Xc
 T2P_f61SpCQGM3TJFLBbI88pEPwlCayzwt2EL4Bl1vypoxgoiMVObCXy6NrRW.2P7fYkCuQQZqgY
 HgW9eE9X2_rfTKqXMClnMSOJqHgRSCtf7HNNiJoVQx7xF.lRs1wzyPwSqqSEkQQxxY5j9uM74N4M
 AkMzk3M.lbSnfWVO0hPvme4AhE0lh76tVz2vycPJA10eNc9_iK3TiwppMmkrO65dbmg5F2Lup6dm
 HyIp9uUkEGjsYpdboIo15mYrFwtRCgX4eBxEOJlRAwVkYpXnrVv.eBaC60lJoNMrsVy98s4OOhNE
 PMkHOQeC6MjNciLtjsHHlrKJD.Nd3txmT9vxqOhU7RmFbeRH0uPhOja.xAl8ShAg2zgIr2Ybu0qw
 eoYJqovHOwcr5aPLrb0Mh0T1y5.HYIPG4Y_1hIUB0e_S0_OLw6ez2nPzQDeAHD8GgjXsnb14jW7f
 7lVqj0REaN65I3gfseRMiHZQVaxAKYo3haeTsgBt6c0wXTL0j.mGEwGwuN8oMTedRvz8uftq_OJc
 ks8lmMIIUPt0sAx.X3JxAZ7LYqfP2Hsp1ICgyHo5m8ORBSu3sOI2Pwdbu8WgS0ENq7tdHSdsTd0O
 cZ3zREMP9X7nZuNKXE2gVgvqnx_L4QwRTdT3HTvftMDT74bSbC8DFqd2i0mc7xBiKG8wqJi61R__
 xbdnJ.AtPMdsrndb0c20gO4TwUOYlngsHW1Cd26iL8HztcLkY9KBpOLZgcl10oJ3p2elHXkNEyZd
 KRIPCijKcJ5VLNMjsujUbsk5SJJnVhxnDKr5eDnzeRc4SMKbDhrFZTqn.ZgT5wtxyBD5NcZ.FROt
 IZiaMxcvY1NrDGtcH5bu3jEc6PPU_aNZw7Pnpsrz_T97pZjRvhDz0iOicAPI8OJvlvbctxOQjlKO
 r_8bMDA3SRAY3qwLLHgPZrqmHAqBxr0tB1voZjuuJqimbC.UpnH0p_m3rCh77nHODc1yOOdEYfnD
 cx.aLMXiGYUgK7l_NsrEWF2qVNZieXV0fPB7jNkMrkTNyJealLUiVir18.D4JW0PzjNLSt8eEuAp
 a.HHJEomKbiMz.zO.yenhjnEB5qxCc0BXYaJqZdS8KjDaxh5BAbttFuT7f0wltduh2vn13oxWAmt
 mM9g7CCRqrhtGObxJks8f_vCHrOMkph_0Mm.PjU5a5J_lFbpnUAhiGZM3S5IDobNQXEYHHFsumFV
 e26zRS5iC4ZPlBJ.u0Khhhj018wx_jHX3IzAW80SoKBJkf1r3NXr60SH2Ff320IoENQ4dPqgdcFf
 hAPX73rShL2wEDXwSvWL62uAEU.1EWlwqeLlmCd15qlw6eDHFV2Dvu2ktYP6MGKu9sUvRHjVy_vY
 Py0615tZPeTcE4C1X8qO07mQIfnkrPii57EXPlhfeWWOfsidAMCurDv.UTbYVqjA0nun_ZxOTVQI
 XgWJsprh6mjdBVHjmTGzuSKbBqhIdiQ.RlkFLBk6i0VKTHmHvUxy5PRHOzjAVwXhitxXzPXdwe4P
 9zuEv7ARZmGIjU199YjErafVxheZwF6uOrZwK_vyCRWCbxVatZk3vXmj6MNSvmDTxLpymLL_gJ00
 RtvQ5RzMAK7FKYhTCe35jXn_6E4HHOWAV.W7T8SlC7CBjF8HdgcsCKo72Zj5.KEP2CMBlPPKLN_p
 r_sG0ZfJ5XYnc02DNfFMBiFWuJhMdFUnwa5PsbWDlarB6N1kZuav91KhkfuC8VqXrhOsN9YnrCmu
 ZbTQlwkY2Sjkly3Qgk2EmdrrgJLwjhJeqQuU2coAn7Hv6Jzonr5faFWzF5OmYyZHXa42wtjb9rbC
 SEgeiTbOPVO63zk6MfqRZwculCD8NUAVDt4XaCfS2M9F6Hog.1m6WnKXsY2kP7fl3A8_EPr1NfXy
 9IFaf6kNBLGBWDvOOkHoqVk9klKQtV98vM6OYlXk4QopwACFDmmYfYCDdtjXoTc.hCkIOFz1LPwj
 NwFoTdnxXvws7jbSlWw0ZjCegX40.vEKpB3l3opBM7aQkhvBNtDO_It49Ad4M2bn2Z6l_ha3lX7C
 QLjnUaGbGR.nhUB3j8z0cbSMFxwp4DuHxpj7C60UydsxaPyU_MV9eeVKVPq7txNigHvwZ4OfEy69
 hy1M-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: acc49913-98b6-46d2-91e7-1c67ced76d18
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Wed, 2 Sep 2026 17:51:46 +0000
Received: by hermes--production-gq1-678d9dd684-wb2f9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 058aaa057072eb9ecb352bc480c66559;
          Wed, 02 Sep 2026 17:51:40 +0000 (UTC)
Message-ID: <298197df-1f92-40b8-8baf-8f52a3dcec20@schaufler-ca.com>
Date: Wed, 2 Sep 2026 10:51:37 -0700
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/15] lsm: Add the LSM policy object lifetime hooks
To: Justin Suess <utilityemal77@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
 paul@paul-moore.com, mic@digikod.net, viro@zeniv.linux.org.uk,
 brauner@kernel.org, kees@kernel.org
Cc: gnoack@google.com, jack@suse.cz, song@kernel.org,
 yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org,
 bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
References: <20260831145858.3869191-1-utilityemal77@gmail.com>
 <20260831145858.3869191-2-utilityemal77@gmail.com> <apgX1HKQ7b973YV-@zenbox>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <apgX1HKQ7b973YV-@zenbox>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26460 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 9/2/2026 6:05 AM, Justin Suess wrote:
> On Mon, Aug 31, 2026 at 10:58:43AM -0400, Justin Suess wrote:
>> Add struct lsm_policy_object, the identity an LSM embeds in a policy
>> object it shares with BPF programs, and the three hooks managing such
>> an object's lifetime:
>>
>>   policy_object_from_fd(fd, &object)
>>   policy_object_get(object)
>>   policy_object_put(object)
>>
>> The object records the owning LSM's LSM_ID_* value.  The BPF kfuncs
>> built on these hooks dispatch each call on an object to the one LSM
>> matching its lsmid, which resolves the containing object with
>> container_of(); the framework never interprets an object beyond its
>> lsmid.  The type field discriminates between the owning LSM's own
>> policy object kinds and is private to it, with 0 reserved as "unset"
>> so a zeroed, untagged object fails every type check.
>>
>> from_fd has no object to route by: the fd refers to a file set up
>> through the owning LSM's own userspace interface, so the fd itself
>> identifies its LSM.  The framework offers the fd to every
>> implementation in turn; an LSM declines a fd that is not one of its
>> policy objects with -EOPNOTSUPP, and any other error is a definitive
>> translation failure.
>>
>> The hooks back referenced BPF kptrs, which imposes the same lifetime
>> contract on every implementation: from_fd returns a reference on a
>> live object, get acquires with inc-not-zero semantics and fails with
>> -ENOENT once the count dropped to zero, put may be called from
>> contexts that cannot sleep (BPF drives it from map destructors), and
>> the containing object is freed only after an RCU grace period, as
>> programs load policy object kptrs from maps under RCU and may examine
>> an object concurrently with its last put.
>>
>> The hooks are excluded from the "bpf" LSM's attachment points.  The
>> object-routed hooks are unreachable there, as LSM_ID_BPF policy
>> objects cannot exist; for from_fd, whose walk visits every
>> implementation, a BPF program cannot fill the object out parameter,
>> so an attachment returning 0 would hand the caller an uninitialized
>> pointer.
>>
>> Cc: Paul Moore <paul@paul-moore.com>
>> Cc: Casey Schaufler <casey@schaufler-ca.com>
>> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
>> ---
>>  include/linux/lsm_hook_defs.h |  4 ++++
>>  include/linux/security.h      | 11 +++++++++++
>>  kernel/bpf/bpf_lsm.c          |  3 +++
>>  3 files changed, 18 insertions(+)
>>
>> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
>> index 65c9609ec207..d7684407737a 100644
>> --- a/include/linux/lsm_hook_defs.h
>> +++ b/include/linux/lsm_hook_defs.h
>> @@ -452,6 +452,10 @@ LSM_HOOK(int, 0, bpf_token_create, struct bpf_token *token, union bpf_attr *attr
>>  LSM_HOOK(void, LSM_RET_VOID, bpf_token_free, struct bpf_token *token)
>>  LSM_HOOK(int, 0, bpf_token_cmd, const struct bpf_token *token, enum bpf_cmd cmd)
>>  LSM_HOOK(int, 0, bpf_token_capable, const struct bpf_token *token, int cap)
>> +LSM_HOOK(int, -EOPNOTSUPP, policy_object_from_fd, int fd,
>> +	 struct lsm_policy_object **object)
>> +LSM_HOOK(int, -EOPNOTSUPP, policy_object_get, struct lsm_policy_object *object)
>> +LSM_HOOK(void, LSM_RET_VOID, policy_object_put, struct lsm_policy_object *object)
>>  #endif /* CONFIG_BPF_SYSCALL */
>>  
>>  LSM_HOOK(int, 0, locked_down, enum lockdown_reason what)
>> diff --git a/include/linux/security.h b/include/linux/security.h
>> index 153e9043058f..5e423bea080e 100644
>> --- a/include/linux/security.h
>> +++ b/include/linux/security.h
>> @@ -168,6 +168,17 @@ struct lsm_prop {
>>  	struct lsm_prop_bpf bpf;
>>  };
>>  
>> +/*
>> + * Identity of a policy object an LSM shares with BPF programs,
>> + * embedded in the LSM's own object.  @lsmid identifies the owning
>> + * LSM; @type discriminates that LSM's policy object types, with 0
>> + * reserved as "unset".
>> + */
>> +struct lsm_policy_object {
>> +	u64 lsmid;
>> +	u32 type;
>> +};
> For some clarity:
>
> lsm_policy_object is just a handle to a refcounted lsm-private struct.
>
> It can't be forged / created manually because it's a trusted kernel
> pointer, so the only way to get it is through policy_object_from_fd.
> And you cannot mutate any part of it from BPF.
>
> But it's what enables the generic model. Calling it a "policy object"
> may be short sighted though, that term is heavily overloaded in the LSM
> space. I don't want to prescribe any restrictions on what an LSM can use
> it for, after all some LSM have no notion of "policy" at all or have a
> different meaning for it.
>
> For SELinux, this "lsm_policy_object" could be an sid, for AppArmor an aa_label,
> for Smack a label, etc. The intention was to allow writing programs that
> don't care about any details of a particular LSM.

Why aren't you using an lsm_prop pointer? What if the operation you're
planning to perform is relevant to multiple active LSMs? Today you can't
use SELinux and AppArmor together on an upstream Linus kernel, but that
should be changing sometime this decade.

