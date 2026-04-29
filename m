Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC3F37E2F8;
	Wed, 29 Apr 2026 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777487730; cv=none; b=G1I7mdUbkJz4zKfr/aAP/oU42OxmKAYLixNliBtCps52V6ZhTKhWZrSCpH9nmJAjjxXMgiWfa367JthstmToh96Oz0rZNgnaZNGaeTZX1NS86GSEcD9MUm89MsnrNqgLm6Gj3sg/DvzwLHUHmxiruIXYYKXb39iCRDT2EtOKyZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777487730; c=relaxed/simple;
	bh=u8ACEB8TOh8YyCtsgtMPCXvGa0iWXmGLp0lnBWuB2ws=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ptUbILZ0xL5Ikol5A9sdnl2Vjis0ExFyuwspmgyFvq9wVJ5l6JQbcCuz72bFfbTlxF8khgzICfrqY1GebouUTwB3cXSGPEgXy5cfywk3/6eK1cfwjd+w9bnH+zg/AwKPTWUB3+7Cx11uAC2yJHaAp2rGKpeVuBzfT2a1XdKOq5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AYhil/cO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AYhil/cO"
Received: from narnia (unknown [40.78.12.246])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5C8A320B716C;
	Wed, 29 Apr 2026 11:35:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5C8A320B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777487727;
	bh=gObx+19W107v1M+PeEyFKrNQvl9AhhQGjKnnpTVSCNI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AYhil/cOev9QsgsfiuS6DA3xswv6OxMGNWluR/XUbIMrJoqJ1Ulk85Fzu92gGJT/3
	 mevcAo8ICUliLx+czPcONpNXRpaa/SHG6t7tD1roHV0LZ0Slj9kX51Me74sJQ+O/ZF
	 5CMz7gOebBvA4F6DvxcGngn3VCRp1W4oju0LwJSQ=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Fan Wu <wufan@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BC?=
 =?utf-8?Q?nther?= Noack <gnoack@google.com>, "Dr.
 David Alan Gilbert" <linux@treblig.org>, Andrew Morton
 <akpm@linux-foundation.org>, James.Bottomley@hansenpartnership.com,
 dhowells@redhat.com, Fan Wu <wufan@kernel.org>, Ryan Foster
 <foster.ryan.r@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Song Liu
 <song@kernel.org>
Subject: Re: [PATCH v5 10/10] ipe: Add BPF program load policy enforcement
 via Hornet integration
In-Reply-To: <CAKtyLkEEjzcjptcN8DU70HfDJ7bw18S2mtgFPUyn9P46QUhsmQ@mail.gmail.com>
References: <20260420212653.438685-1-bboscaccy@linux.microsoft.com>
 <20260420212653.438685-11-bboscaccy@linux.microsoft.com>
 <CAKtyLkEEjzcjptcN8DU70HfDJ7bw18S2mtgFPUyn9P46QUhsmQ@mail.gmail.com>
Date: Wed, 29 Apr 2026 11:35:24 -0700
Message-ID: <87h5otk42b.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Fan Wu <wufan@kernel.org> writes:

> On Mon, Apr 20, 2026 at 2:27=E2=80=AFPM Blaise Boscaccy
> <bboscaccy@linux.microsoft.com> wrote:
>>
>> Add support for the bpf_prog_load_post_integrity LSM hook, enabling IPE
>> to make policy decisions about BPF program loading based on integrity
>> verdicts provided by the Hornet LSM.
>>
>> New policy operation:
>>   op=3DBPF_PROG_LOAD - Matches BPF program load events
>>
>> New policy properties:
>>   bpf_signature=3DNONE      - No Verdict
>>   bpf_signature=3DOK        - Program signature and map hashes verified
>>   bpf_signature=3DUNSIGNED  - No signature provided
>>   bpf_signature=3DPARTIALSIG - Signature OK but no map hash data
>>   bpf_signature=3DUNKNOWNKEY - Cert not trusted
>>   bpf_signature=3DUNEXPECTED - An unexpected hash value was encountered
>>   bpf_signature=3DFAULT      - System error during verification
>>   bpf_signature=3DBADSIG    - Signature or map hash verification failed
>>   bpf_keyring=3DBUILTIN     - Program was signed using a builtin keyring
>>   bpf_keyring=3DSECONDARY   - Program was signed using the secondary key=
ring
>>   bpf_keyring=3DPLATFORM    - Program was signed using the platform keyr=
ing
>>   bpf_kernel=3DTRUE         - Program originated from kernelspace
>>   bpf_kernel=3DFALSE        - Program originated from userspace
>>
>> These properties map directly to the lsm_integrity_verdict enum values
>> provided by the Hornet LSM through security_bpf_prog_load_post_integrity.
>>
>> The feature is gated on CONFIG_IPE_PROP_BPF_SIGNATURE which depends on
>> CONFIG_SECURITY_HORNET.
>>
>> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
>> ---
>
> ...
>
>> diff --git a/security/ipe/hooks.c b/security/ipe/hooks.c
>> index 0ae54a880405a..03541e5bb7f60 100644
>> --- a/security/ipe/hooks.c
>> +++ b/security/ipe/hooks.c
>> @@ -340,3 +340,40 @@ int ipe_inode_setintegrity(const struct inode *inod=
e,
>>         return -EINVAL;
>>  }
>>  #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
>> +
>> +#ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
>> +/**
>> + * ipe_bpf_prog_load_post_integrity() - ipe security hook for BPF progr=
am load.
>> + * @prog: Supplies the BPF program being loaded.
>> + * @attr: Supplies the bpf syscall attributes.
>> + * @token: Supplies the BPF token, if any.
>> + * @kernel: Whether the call originated from the kernel.
>> + * @lsmid: Supplies the LSM ID of the integrity provider.
>> + * @verdict: Supplies the integrity verdict from the provider (e.g. Hor=
net).
>> + *
>> + * This LSM hook is called after an integrity verification LSM (such as=
 Hornet)
>> + * has evaluated a BPF program's cryptographic signature. IPE uses the =
verdict
>> + * to make a policy-based allow/deny decision.
>> + *
>> + * Return:
>> + * * %0                - Success
>> + * * %-EACCES  - Did not pass IPE policy
>> + */
>> +int ipe_bpf_prog_load_post_integrity(struct bpf_prog *prog,
>> +                                    union bpf_attr *attr,
>> +                                    struct bpf_token *token,
>> +                                    bool kernel,
>> +                                    const struct lsm_id *lsmid,
>> +                                    enum lsm_integrity_verdict verdict)
>> +{
>> +       struct ipe_eval_ctx ctx =3D IPE_EVAL_CTX_INIT;
>> +
>> +       ctx.op =3D IPE_OP_BPF_PROG_LOAD;
>> +       ctx.hook =3D IPE_HOOK_BPF_PROG_LOAD;
>> +       ctx.bpf_verdict =3D verdict;
>> +       ctx.bpf_keyring_id =3D attr->keyring_id;
>> +       ctx.bpf_kernel =3D kernel;
>> +
>> +       return ipe_evaluate_event(&ctx);
>> +}
>> +#endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
>> diff --git a/security/ipe/hooks.h b/security/ipe/hooks.h
>> index 07db373327402..95b74f7899750 100644
>> --- a/security/ipe/hooks.h
>> +++ b/security/ipe/hooks.h
>> @@ -10,6 +10,7 @@
>>  #include <linux/security.h>
>>  #include <linux/blk_types.h>
>>  #include <linux/fsverity.h>
>> +#include <linux/bpf.h>
>>
>>  enum ipe_hook_type {
>>         IPE_HOOK_BPRM_CHECK =3D 0,
>> @@ -18,6 +19,7 @@ enum ipe_hook_type {
>>         IPE_HOOK_MPROTECT,
>>         IPE_HOOK_KERNEL_READ,
>>         IPE_HOOK_KERNEL_LOAD,
>> +       IPE_HOOK_BPF_PROG_LOAD,
>>         __IPE_HOOK_MAX
>>  };
>>
>> @@ -52,4 +54,13 @@ int ipe_inode_setintegrity(const struct inode *inode,=
 enum lsm_integrity_type ty
>>                            const void *value, size_t size);
>>  #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
>>
>> +#ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
>> +int ipe_bpf_prog_load_post_integrity(struct bpf_prog *prog,
>> +                                    union bpf_attr *attr,
>> +                                    struct bpf_token *token,
>> +                                    bool kernel,
>> +                                    const struct lsm_id *lsmid,
>> +                                    enum lsm_integrity_verdict verdict);
>> +#endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
>> +
>>  #endif /* _IPE_HOOKS_H */
>> diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
>> index 495bb765de1b8..6502d4ddc641c 100644
>> --- a/security/ipe/ipe.c
>> +++ b/security/ipe/ipe.c
>> @@ -60,6 +60,9 @@ static struct security_hook_list ipe_hooks[] __ro_afte=
r_init =3D {
>>  #ifdef CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG
>>         LSM_HOOK_INIT(inode_setintegrity, ipe_inode_setintegrity),
>>  #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
>> +#ifdef CONFIG_IPE_PROP_BPF_SIGNATURE
>> +       LSM_HOOK_INIT(bpf_prog_load_post_integrity, ipe_bpf_prog_load_po=
st_integrity),
>> +#endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
>>  };
>>
>
> IPE only registers bpf_prog_load_post_integrity(), which fires only
> when Hornet calls security_bpf_prog_load_post_integrity. If Hornet
> isn't enabled via lsm=3D, this hook never triggers, and an IPE policy
> like "DEFAULT op=3DBPF_PROG_LOAD action=3DDENY" silently allows every
> load.
>
> I think IPE should register bpf_prog_load() as well, post_integrity()
> should only store the verdict to a per-prog blob, and bpf_prog_load
> reads it and evaluates policy.
>

Sounds reasonable to me.=20

> -Fan
