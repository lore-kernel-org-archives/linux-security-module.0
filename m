Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0459E175A67;
	Wed, 24 Jun 2026 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782315442; cv=none; b=haa3f+VxxhRhtcjV1NHJ8/66CylGO09f/El2BxETVoHBIaeAo7HbojB31f1TjX3Rsug0YO+qS0RqPbvRXs815RKA4gUiZxprBmgYCyBUPsKt3NB6ij32WjKJa5UqAFrVIf9vtT2Etc9cSWSWFi4990CqXRVUNmUgn2K9gyYQZzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782315442; c=relaxed/simple;
	bh=2F6qL5Nb1fcp4TeFOqfbcqOswzxRHQNQcRf6ac/IRBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SyR6UHgeMNFhV5RPd0rFjTT/CCH4NXTrdlEZbWFJRAt3CF6wp2hbQp19kZ1KBglW2tiCevzj4S7WZrJeB4WzndqZ8LDrrlOXMaVZK6hAdEYQRT+t0Dw/5s3UU9LpIE4amQty58OXyZQz+SZ596BwWxjyF6y2qKoa3NGz2Aura4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=FQIMIgDg; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="FQIMIgDg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=a+siFv2WANfaJo2mFkXJRFCoMVklUtYPOBRiRPigEvo=; b=FQIMIgDg8V10Vv5nHR4lw8Cj18
	Y4Jx+rEmR2mDgsWgNPNFzbtOIxfJ+jUXn2/VTpfgNs9Ow6x1x70vw3RzrjNeEOLhN1KcIZAyxYLvh
	/tRnFMasbyqxMdbEDPAuefNeLwE1uuSgQGMwypQhFBvBxELs3F07BMQQ//pQetuquPbqRysQIEvYn
	NW++RH68Gdb0LTOHUFvczhPH9Rj9BHM2sBzP5NXyL11xJF2x53BM14wYhHgS73P+Zgr3+C22nx1Ae
	6SjG53ICJBjm5Mdeo/QO6DuurCRKjfaVKdH9gUXL8N6Omq6Pz/mmTkTSYmDb2fQ5dbikGBEsupwQX
	VVsH+Jkg==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wcPfC-0004Up-2p;
	Wed, 24 Jun 2026 17:37:18 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wcPeE-000GFA-05;
	Wed, 24 Jun 2026 17:37:18 +0200
Message-ID: <603d0f6f-bf02-48ec-af90-f16a239bad85@iogearbox.net>
Date: Wed, 24 Jun 2026 17:37:17 +0200
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Verify signed loader metadata at
 load time
To: Paul Moore <paul@paul-moore.com>
Cc: ast@kernel.org, kpsingh@kernel.org,
 James.Bottomley@hansenpartnership.com, bboscaccy@linux.microsoft.com,
 memxor@gmail.com, torvalds@linux-foundation.org, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org
References: <20260624140301.93421-1-daniel@iogearbox.net>
 <20260624140301.93421-2-daniel@iogearbox.net>
 <CAHC9VhRar1x7kyjhgdmJ=Mfz4Msarv=wQ1821v723CaVdk1uTA@mail.gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <CAHC9VhRar1x7kyjhgdmJ=Mfz4Msarv=wQ1821v723CaVdk1uTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28041/Wed Jun 24 08:24:54 2026)

Hi Paul,

On 6/24/26 5:12 PM, Paul Moore wrote:
> On Wed, Jun 24, 2026 at 10:03 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
[...]
>>   include/linux/bpf_verifier.h |   1 +
>>   kernel/bpf/syscall.c         |  76 +---------------
>>   kernel/bpf/verifier.c        | 163 ++++++++++++++++++++++++++++++++++-
>>   3 files changed, 165 insertions(+), 75 deletions(-)
> 
> ...
> 
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index b44106c8ea75..026b61d78bdb 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -3189,10 +3121,6 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_at
>>          if (err < 0)
>>                  goto free_prog;
>>
>> -       err = security_bpf_prog_load(prog, attr, token, uattr.is_kernel);
>> -       if (err)
>> -               goto free_prog;
>> -
>>          /* run eBPF verifier */
>>          err = bpf_check(&prog, attr, uattr, attr_log);
>>          if (err < 0)
> 
> We must preserve the existing location of the call into the
> security_bpf_prog_load() hook as some users rely on this hook being
> called *before* the verifier runs.

Keep in mind that the verifier /at this point/ of the new location did
_not_ verify anything. So there is no heavy-duty work happening yet at
security_bpf_prog_load. The work that is done before security_bpf_prog_load
is basically setting up the env, initializing the verifier log, and doing
the process_fd_array which is resolving the map/BTF objects. But it did
not walk any instructions etc, so semantics of the security_bpf_prog_load
hook did not change from a user PoV.

>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 2abc79dbf281..9cd2b62da380 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -19758,11 +19895,28 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
>>          ret = bpf_vlog_init(&env->log, attr_log->level, attr_log->ubuf, attr_log->size);
>>          if (ret)
>>                  goto err_unlock;
>> +       if (env->check_signature) {
>> +               ret = bpf_prog_calc_tag(env->prog);
>> +               if (ret < 0)
>> +                       goto skip_full_check;
>> +       }
>>
>>          ret = process_fd_array(env, attr, uattr);
>>          if (ret)
>>                  goto skip_full_check;
>>
>> +       if (env->check_signature) {
>> +               ret = bpf_prog_verify_signature(env, attr, uattr.is_kernel);
>> +               if (ret)
>> +                       goto skip_full_check;
>> +               signed_map_cnt = env->used_map_cnt;
>> +       }
>> +
>> +       ret = security_bpf_prog_load(env->prog, attr, env->prog->aux->token,
>> +                                    uattr.is_kernel);
>> +       if (ret)
>> +               goto skip_full_check;
> 
> We can always create a new LSM hook for this call site, e.g.
> security_bpf_prog_verify_signature(...).
> 
>>          mark_verifier_state_clean(env);
>>
>>          if (IS_ERR(btf_vmlinux)) {
> 

