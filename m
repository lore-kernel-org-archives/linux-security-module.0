Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBCB46E017;
	Wed, 14 Oct 2026 06:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960114; cv=none; b=oEdJjCw+6/UUWi5hNYwJLlvdPpS8Qi7uUEERVqKoFavZOdYv7TiCclgfUEH8l0u3dOuqb4Komei43mk0GmRqPrKPRL71c57UOwAW8b3y+yrABsQyBSokt5weeZLtCHvGfMQ7g6ImOQr2tMviJ6TP4ivo6T7LSXFdo4CGEnEoHko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960114; c=relaxed/simple;
	bh=8JsaAJac8exDRiLZP+WuvxCaODlXs92VDBMSGrrj0ec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cf37GVIO07B9Dty2DMQANqN4/NZ07EFmDMMgd4ENiMUOb+zlMq093IloEArXSlGq5blOfLq77dzDCNNkP9i7u8L0Ge0JQXA1bI/Wnx/tDMAV+0CkIh09eGigcxA9EMvYuF42e3/o80++gHqk9KTdp6ngBvxwFDYM99cAedwItJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=emA7JWci; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="emA7JWci"
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <jemarch@gnu.org>)
	id 1xGsgF-000071-Rn; Wed, 14 Oct 2026 02:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:References:In-Reply-To:Subject:To:
	From; bh=TfdvLz23jbZAN8dixlMbudWM2BjDMFngjYqKr62cQ6w=; b=emA7JWciClgsXW/uXwnv
	adVQgBfxDgdDmCzUD5stngOjVpsFjJNFNrtHGNezxbz4D8dFnhO9zOqGFJzEYMqZw12q74/+zOPLU
	ri81KPpZVnWdT5TbLVdA144/XjNPrRWRpPQ/kjzL3LTjwhPQH41+RtAgoTggzHMQAF3oW50x9luX9
	cqW2L0G3oYfpR9ylSX7TIzxat7DfeIRsizWTF3+RDLIjU8//sBjTTYAdXfENu+UQWJubHTg1apS/O
	kviyfP4CJf6ckC/b2gs4IqEcJVJ5FVjlVh+FoP4fkDXmXYqJaAblJXi4U8cZqJrZIIA8NLhmGPKEj
	ZKjc8Psq92GxZA==;
From: "Jose E. Marchesi" <jemarch@gnu.org>
To: Justin Suess <utilityemal77@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,  Alexander Viro
 <viro@zeniv.linux.org.uk>,  Jan Kara <jack@suse.cz>,  NeilBrown
 <neil@brown.name>,  =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Andrii
 Nakryiko <andrii@kernel.org>,  Song Liu <song@kernel.org>,
  linux-fsdevel@vger.kernel.org,  bpf@vger.kernel.org,
  linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org,
  =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,  Paul Moore
 <paul@paul-moore.com>,
  James Morris <jmorris@namei.org>,  "Serge E . Hallyn" <serge@hallyn.com>,
  Martin KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Yonghong Song <yonghong.song@linux.dev>,  John
 Fastabend <john.fastabend@gmail.com>,  Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,  Jiri Olsa <jolsa@kernel.org>,  Jeff Layton
 <jlayton@kernel.org>,  Amir Goldstein <amir73il@gmail.com>,  Mateusz Guzik
 <mjguzik@gmail.com>,  Shuah Khan <shuah@kernel.org>,  Tingmao Wang
 <m@maowtm.org>,  jose.marchesi@oracle.com
Subject: Re: [PATCH bpf-next v1 06/11] selftests/bpf: exercise the path
 ancestor iterator
In-Reply-To: <as6GG4NMzLrnpKXK@zenbox>
References: <20261013164800.2906577-1-utilityemal77@gmail.com>
	<20261013164800.2906577-7-utilityemal77@gmail.com>
	<as6GG4NMzLrnpKXK@zenbox>
Date: Wed, 14 Oct 2026 08:41:12 +0200
Message-ID: <875wz43htj.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


> On Tue, Oct 13, 2026 at 12:=E2=80=8A47:=E2=80=8A55PM -0400, Justin Suess =
wrote: >
> Walk the ancestry of a mkdir's parent directory from a sleepable LSM
>> program and check that the iteration reaches the root: the
> temporary > directory, its parent and
> ZjQcmQRYFpfptBannerStart
> This Message Is From an External Sender
> This message came from outside your organization.
> Report Suspicious
>=20=20
> ZjQcmQRYFpfptBannerEnd
>
> On Tue, Oct 13, 2026 at 12:47:55PM -0400, Justin Suess wrote:
>> Walk the ancestry of a mkdir's parent directory from a sleepable LSM
>> program and check that the iteration reaches the root: the temporary
>> directory, its parent and / are visited, no position comes back
>> flagged, and the flags read back after the loop show it ended at the
>> root rather than on a failed allocation.
>>=20
>> Hold the first position across the rest of the walk and resolve its
>> pathname only once the loop is done and the iterator destroyed: the
>> acquired reference, not the walk's, is then all that keeps the
>> position alive.
>>=20
>> Signed-off-by: Justin Suess <utilityemal77@gmail.com>
>> ---
>>  .../selftests/bpf/prog_tests/path_ancestors.c | 57 ++++++++++++++
>>  .../selftests/bpf/progs/path_ancestors.c      | 74 +++++++++++++++++++
>>  2 files changed, 131 insertions(+)
>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/path_ancestor=
s.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/path_ancestors.c
>>=20
>> diff --git a/tools/testing/selftests/bpf/prog_tests/path_ancestors.c b/t=
ools/testing/selftests/bpf/prog_tests/path_ancestors.c
>> new file mode 100644
>> index 000000000000..d1bd26bce10b
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/path_ancestors.c
>> @@ -0,0 +1,57 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2026 Justin Suess */
>> +
>> +#include <sys/stat.h>
>> +#include <stdlib.h>
>> +#include <unistd.h>
>> +#include <test_progs.h>
>> +#include "path_ancestors.skel.h"
>> +
>> +void test_path_ancestors(void)
>> +{
>> +     char base[] =3D "/tmp/path_ancestors_XXXXXX";
>> +     struct path_ancestors *skel =3D NULL;
>> +     char suba[280], subb[280];
>> +
>> +     if (!ASSERT_OK_PTR(mkdtemp(base), "mkdtemp"))
>> +             return;
>> +     snprintf(suba, sizeof(suba), "%s/a", base);
>> +     snprintf(subb, sizeof(subb), "%s/a/b", base);
>> +     if (!ASSERT_OK(mkdir(suba, 0755), "mkdir_a"))
>> +             goto out_rm;
>> +
>> +     skel =3D path_ancestors__open_and_load();
>> +     if (!ASSERT_OK_PTR(skel, "open_and_load"))
>> +             goto out_rm;
>> +     skel->bss->monitored_pid =3D getpid();
>> +     if (!ASSERT_OK(path_ancestors__attach(skel), "attach"))
>> +             goto out;
>> +
>> +     /* mkdir b: the hook sees dir =3D=3D suba, whose ancestry is walke=
d. */
>> +     if (!ASSERT_OK(mkdir(subb, 0755), "mkdir_b"))
>> +             goto out;
>> +
>> +     /* suba, base, /tmp, / at least. */
>> +     ASSERT_GE(skel->bss->ref_count, 4, "ref_count");
>> +     ASSERT_EQ(skel->bss->ref_flags, 0, "ref_flags");
>> +     /*
>> +      * The referenced loop ended at the root, not on an allocation
>> +      * failure.
>> +      */
>> +     ASSERT_EQ(skel->bss->end_flags, 0, "end_flags");
>> +
>> +     /* The acquired second position, used after its step was taken. */
>> +     ASSERT_STREQ(skel->bss->second_path, base, "second_path");
>> +     ASSERT_EQ(skel->bss->second_len, strlen(base) + 1, "second_len");
>> +
>> +     /* The first position, used only after the walk itself was gone. */
>> +     ASSERT_STREQ(skel->bss->first_path, suba, "first_path");
>> +     ASSERT_EQ(skel->bss->first_len, strlen(suba) + 1, "first_len");
>> +
>> +out:
>> +     path_ancestors__destroy(skel);
>> +out_rm:
>> +     rmdir(subb);
>> +     rmdir(suba);
>> +     rmdir(base);
>> +}
>> diff --git a/tools/testing/selftests/bpf/progs/path_ancestors.c b/tools/=
testing/selftests/bpf/progs/path_ancestors.c
>> new file mode 100644
>> index 000000000000..6287f5099a18
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/path_ancestors.c
>> @@ -0,0 +1,74 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2026 Justin Suess */
>> +
>> +#include "vmlinux.h"
>> +#include <errno.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +#include "bpf_kfuncs.h"
>> +
>> +char _license[] SEC("license") =3D "GPL";
>> +
>> +__u32 monitored_pid;
>> +
>> +int ref_count;               /* positions seen by the pure referenced w=
alk */
>> +int ref_flags;               /* pos flags seen by the referenced walk */
>> +int end_flags;               /* flags after a referenced loop ended: 0 =
unless NOMEM */
>> +int second_len;              /* d_path length of the walk's second posi=
tion */
>> +int first_len;               /* d_path length of the first position, af=
ter the walk */
>> +char second_path[256];
>> +char first_path[256];
>> +
>> +static bool monitored(void)
>> +{
>> +     return (bpf_get_current_pid_tgid() >> 32) =3D=3D monitored_pid;
>> +}
>> +
>> +SEC("lsm.s/path_mkdir")
>> +int BPF_PROG(walk_modes, const struct path *dir, struct dentry *dentry,
>> +          umode_t mode)
>> +{
>> +     struct bpf_iter_path_ancestors it;
>> +     struct path *pos, *first =3D NULL;
>> +
>> +     /*
>> +      * Keep first's init opaque: gcc-bpf otherwise folds it into a
>> +      * preceding loop's exit value, which the verifier cannot track.
>> +      */
>> +     barrier_var(first);
>> +
> cc'ing Eduard Zingerman + Jose Marchesi
>
> This barrier_var line was necessary for this selftest to pass
> under GCC BPF.
>
> Othwise it will be rejected by the verifier:
>
>   84: (85) call bpf_iter_path_ancestors_rcu_next#63514
>   85: R0=3Drcu_ptr_path(id=3D30) ... depth=3D9
>   86: (bf) r6 =3D r0              ; R6=3Drcu_ptr_path(id=3D30)
>   88: (55) if r0 !=3D 0x0 goto pc-64
>   ...
>   101: (85) call bpf_rcu_read_unlock#64876
>        ^-- R6 downgraded rcu_ptr_ -> untrusted_ptr_
>   ...
>   146: (15) if r6 =3D=3D 0x0 goto pc+10     ; R6=3Duntrusted_ptr_path(id=
=3D30)
>   147: (bf) r1 =3D r6
>   151: (85) call bpf_path_d_path#64649
>   R1 must be referenced or trusted
>
> I think it's trying to optimize out the "struct path* first" and make it
> use the r6 register. It tries reusing the R6 register between the two
> loops, and doing so causes the program to fail to verify because it doesn=
't
> understand that the path was reinitialized with r6=3D0 from the previous
> exit.
>
> So I had to add the memory barrier to force struct path to be
> instantiated outside the register.
>
> There's nothing wrong from a *correctness* perspective with the code
> generated by GCC-BPF. But I'm not sure if this is a GCC-BPF bug or a
> bug in the SCEV widening series (merge 15b578b1715d). It depends on
> the contract BPF bytecode is supposed to meet.
>
> But clang works without the barrier, it's only GCC-BPF that produces
> this issue requiring the barrier.
>
> I can give more details if needed.

Please open a bugzilla at https://gcc.gnu.org/bugzilla so we can keep
track of this.  It would help to have a preprocessed reproducer based on
the selftest that could be used as a testcase in the GCC testsuite.

Thanks!

>
> Justin
>> [...]
