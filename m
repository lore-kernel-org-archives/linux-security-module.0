Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C6028E0F;
	Thu, 25 Jun 2026 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782419867; cv=none; b=ob6Zxx+BnBpp+2B4Q8VShkxVolYgOka05giIyNH5K8ovREESqn6vZXkVYoXb0da0PFIPBXiPu10VfiYSWdPj0vElvoitV5Q06gSoTJKTgrlcKdWkK/DrmloHiQNPdUXtpp0e2NvVU2Z9Fsqd2ubD0Df+6OM50S+Bvuv2EsuJAII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782419867; c=relaxed/simple;
	bh=ICt9AOGopoDy7ZhCxqi130jOxNAFt494U83cmY16+EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HpVW0PKeBPEhrIAEqj7uASS+e6VfJXZVNogm9QSap6CgvSaYzmzmPC2n8u6oMJ4Py3kt12EFEbp0edSmqq6t4KDCyNE10T6svrJPO2XRfojkOjDS2S650cTgAI+EFCJMG9Ak3IZY4gy9eCiiETm9WWKhK2Hm3xPkqKxs7Odh67g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=O6lAbtdN; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="O6lAbtdN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=2LhGvTHz4loMkIc67sPlEpW4aodz5KDrfueZWiShqqE=; b=O6lAbtdNL9uTsBCbtc4Ndi8Sbv
	AnaE+XG4Dp+HTGbz97vdcFeYHHFanWyvlgSyQ6AvfyeRmbBVcAnjkxGfTSoG0BIPkbM6RZMvwZkRt
	By4aAPfWd4X056QRPxG46xPZhXFojKX1pXuFGffFiBJjN5ej2I80ivuVa6cbZMKk+ugQqk1fH6Xid
	NuBpMbQG+V97sXP3WEvg7iWuTFgmNdH8t5+gDKe12E9Y8gjdPKtoeS/LF0RuQwYly4Vai6fGijPSP
	c+wk2m7Dh55+xFVQ9x0n/M6HKOIAMRmIwRZhkTpmFtsTbvFxK39xKO3Eh8OVuV66ecvy06+DF11Ju
	pEulYgFQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wcqpL-0007Pn-27;
	Thu, 25 Jun 2026 22:37:35 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wcqpL-000DqY-2Z;
	Thu, 25 Jun 2026 22:37:34 +0200
Message-ID: <c4dc3117-ad84-4c94-952a-cf0642cb42e7@iogearbox.net>
Date: Thu, 25 Jun 2026 22:37:34 +0200
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
 <603d0f6f-bf02-48ec-af90-f16a239bad85@iogearbox.net>
 <CAHC9VhTF6_VaSm0uOjW1eV05CvsaaL+2jimVuPTXHeLGEQcMPg@mail.gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <CAHC9VhTF6_VaSm0uOjW1eV05CvsaaL+2jimVuPTXHeLGEQcMPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28042/Thu Jun 25 08:27:10 2026)

On 6/24/26 8:42 PM, Paul Moore wrote:
> On Wed, Jun 24, 2026 at 11:37 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 6/24/26 5:12 PM, Paul Moore wrote:
>>> On Wed, Jun 24, 2026 at 10:03 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> [...]
>>>>    include/linux/bpf_verifier.h |   1 +
>>>>    kernel/bpf/syscall.c         |  76 +---------------
>>>>    kernel/bpf/verifier.c        | 163 ++++++++++++++++++++++++++++++++++-
>>>>    3 files changed, 165 insertions(+), 75 deletions(-)
>>>
>>> ...
>>>
>>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>>> index b44106c8ea75..026b61d78bdb 100644
>>>> --- a/kernel/bpf/syscall.c
>>>> +++ b/kernel/bpf/syscall.c
>>>> @@ -3189,10 +3121,6 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, struct bpf_log_at
>>>>           if (err < 0)
>>>>                   goto free_prog;
>>>>
>>>> -       err = security_bpf_prog_load(prog, attr, token, uattr.is_kernel);
>>>> -       if (err)
>>>> -               goto free_prog;
>>>> -
>>>>           /* run eBPF verifier */
>>>>           err = bpf_check(&prog, attr, uattr, attr_log);
>>>>           if (err < 0)
>>>
>>> We must preserve the existing location of the call into the
>>> security_bpf_prog_load() hook as some users rely on this hook being
>>> called *before* the verifier runs.
>>
>> Keep in mind that the verifier /at this point/ of the new location did
>> _not_ verify anything. So there is no heavy-duty work happening yet at
>> security_bpf_prog_load. The work that is done before security_bpf_prog_load
>> is basically setting up the env, initializing the verifier log, and doing
>> the process_fd_array which is resolving the map/BTF objects. But it did
>> not walk any instructions etc, so semantics of the security_bpf_prog_load
>> hook did not change from a user PoV.
> 
> There is still a reasonable amount of work between the existing and
> new call sites, and the existing location outside of bpf_check()
> offers an additional robustness benefit that future verifier changes
> are less likely to impact the hook.  If I'm completely honest, I also
> need to consider the events of the past year and a half; I'm now much
> less inclined to support LSM hook changes in the BPF subsystem because
> I'm very concerned about our ability to revert/modify those changes in
> the future if needed.  That doesn't mean I won't support LSM hook
> changes in BPF, but such changes are going to need to have a *very*
> strong advantage from a LSM perspective to offset the risk associated
> with the current BPF subsystem.

 From where you sit with regards to LSMs that is a natural stance towards
all kernel code, but coming back to the LSM hook, to me this is way too
excessive that we should add *yet another* LSM hook. So, just for loading
a *single* BPF program we would then need to pass through *four* layers of
LSM hooks:

   1) security_bpf (cmd=PROG_LOAD): for gating various bpf subcmds
   2) security_bpf_prog_load: historical admission hook (CAP/token,
      prog_type, attach point), pre-verification
   3) security_bpf_prog_verify_signature: newly asked admission hook,
      same role as 2), plus the BPF signature verdict
   4) security_bpf_prog: gate handing the prog fd back to userspace,
      verification done & signature verified

The use-cases of 2) and 3) conflate. I strongly prefer to just keep a
total of 3 LSM hooks (as-is today): 3) makes 2) incoherent given they
are the /same class/ of hook, that is, access-control admission on the
load and split only by _what_ they can see. Worse, with the split, for
a signed BPF program security_bpf_prog_load 2) admits a program whose
signature has not been checked, so a policy gating at 2) is structurally
unable to express "admit only verified" and every such policy is forced
onto 3) *anyway*. In other words, you don't get two complementary hooks,
but rather, you get one real admission hook aka 3) plus a now-degraded
/legacy/ hook 2) that can't answer the question operators actually want
to ask. So, no, we're not adding yet another LSM hook.

> Based on what I see in this patchset, the security_bpf_prog_load()
> call should remain in the current location.  If you need an additional
> hook after the bpf_prog_verify_signature() call I'm happy to work with
> you on that.

See above.

> I also have to bring up the same question I asked back in your v1
> posting: have you discussed this signature approach with Alexei?  Your
> patches abandon and remove KP's signature scheme in favor of what is
> effectively Blaise's signature scheme from last fall; Alexei argued
> very strongly against these changes in the past.  I'd hate to spend a
> lot more time reviewing and discussing patches that Alexei is simply
> going to NACK once again.

I think last time I already stated that this is not "effectively Blaise's
signature scheme" for couple of reasons: i) we sign over the raw bytes, not
the derived hash anymore, so the hashing is only used in the context to tie
the map to the loader program, but not anymore for the signature. ii) its one
/single scheme/ and not a parallel branch, so the main loader is built upon
the updated signing scheme rather than having this as an option on the side;
in other words, this replaces the in-loader check and there's a single
PKCS#7-over-bytes path, not an 'if (signature_maps_size)' fork; and iii)
given we expose the verification result in the BPF prog, we also don't need
a new LSM hook and can just piggy back on the existing security_bpf_prog
which also has the possibility to still reject late at this point.

 From where you started out back then, it was the stance that while the
original KP approach generically addresses all the use cases for loading
BPF related to relocations via the lskel loader, Blaise proposed a parallel
scheme which would only allow static programs (only insns, no maps) which
is 1% of use cases it covers for the BPF ecosystem and users are stuck on
figuring out which approach they need to go with. So when I took over the
BTF series with the extra kfunc that KP proposed, I was mainly looking at
that series trying to figure out how we can get away without pulling in BTF
complexity for the signed loader and with a compromise that would potentially
satisfy all parties under a unified signature scheme and having the kernel
side (rather than loader side) providing the hard guarantee. So I cannot
directly speak for Alexei/KP, but I think this proposal should satisfy all
parties under one roof. I've build out user space tooling in addition to
test real world BPF program to make sure they work in combination with maps
and BTF under this scheme as well as map-less BPF programs.

>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>> index 2abc79dbf281..9cd2b62da380 100644
>>>> --- a/kernel/bpf/verifier.c
>>>> +++ b/kernel/bpf/verifier.c
>>>> @@ -19758,11 +19895,28 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
>>>>           ret = bpf_vlog_init(&env->log, attr_log->level, attr_log->ubuf, attr_log->size);
>>>>           if (ret)
>>>>                   goto err_unlock;
>>>> +       if (env->check_signature) {
>>>> +               ret = bpf_prog_calc_tag(env->prog);
>>>> +               if (ret < 0)
>>>> +                       goto skip_full_check;
>>>> +       }
>>>>
>>>>           ret = process_fd_array(env, attr, uattr);
>>>>           if (ret)
>>>>                   goto skip_full_check;
>>>>
>>>> +       if (env->check_signature) {
>>>> +               ret = bpf_prog_verify_signature(env, attr, uattr.is_kernel);
>>>> +               if (ret)
>>>> +                       goto skip_full_check;
>>>> +               signed_map_cnt = env->used_map_cnt;
>>>> +       }
>>>> +
>>>> +       ret = security_bpf_prog_load(env->prog, attr, env->prog->aux->token,
>>>> +                                    uattr.is_kernel);
>>>> +       if (ret)
>>>> +               goto skip_full_check;
>>>
>>> We can always create a new LSM hook for this call site, e.g.
>>> security_bpf_prog_verify_signature(...).
>>>
>>>>           mark_verifier_state_clean(env);
>>>>
>>>>           if (IS_ERR(btf_vmlinux)) {
> 

