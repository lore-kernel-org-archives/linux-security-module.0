Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519D537475D
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 20:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785529002; cv=none; b=odYK088P195099txRy8FC3p13LjTakGQ5pK2BcYV6wW6118FFS+RzU5gA+2PJUAeZ2EIgxUcPVJXReat32gYvVhtPu3bdjYWvHgttAWKtUn80FsOh5YBPDCtKB9+04n+EpJMQOTsCE2j4o8vR6sM1mBEpNdlOGxVBsJx5h1Tf0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785529002; c=relaxed/simple;
	bh=fT4Wh7zLimmN8YPV2rfhV4SibyXoX/Z38RLbsH3AQK4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=GlMPrweH/hAt5/SxkEPVPESIXeDPAOkj2uDgRAkr4SNh5PBLpv8HXzW5Q2s/2Uod0gsel+pCUfwvsxutK/2YgAoxE/Q++V/kx/W/2cs5TV94KZswD4EHbKHs75rT4J8HwKOQPScZlKzIvLTQjpzvGFrYA5V9xO/oiupUAmwqMWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qsTVrI0k; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qsTVrI0k"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-47f7f93b3d4so416585f8f.1
        for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 13:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785528997; x=1786133797; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jKBxHr4kakqx5giULQAhQrBpk8zyW3hvnaTsLQOKVHw=;
        b=qsTVrI0k9n+NaG5nRSTNcfGGTVu3qK0HTCtdPZzZ4nTOh0oiH+9HqnB+2YRwbMGrCJ
         mBTdljhXa3aHVXMBFKq1wkBkx/fs1RiufxfykPN8fX7wvmDunGFbHiZI3rwgsLZoskzd
         qiOH6zeAYvTQy54PtNPpu04WVBZIRx0/g0rcCUgZ8HiG57akUTRWRpiC9loFmoymXOAy
         c4ah1O5pK3kxmCgSUx1H/jRcOX/VZqCqlPNhYjX2OvxiKrl0FLZGkdb8LbhkRFnPapfF
         Vx1A2mPyIMb+5np+gO9GFTDQcMVXJP9pdPlP1BecWTcT8idK/mcLVxDQ2MvMmdpt8eLL
         tCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785528997; x=1786133797;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jKBxHr4kakqx5giULQAhQrBpk8zyW3hvnaTsLQOKVHw=;
        b=Zz6IhqIJYNwEFh7tk+HMoHfPOjEy0DxHialMMGbopCSQhBsX22omJr0EQJFTJZhd17
         YsGzxLySkAT9txkOAFLaqanO601QJyD8GcnmPKc4E0RzNqVAlBICfYqShtp8MdWdTXRt
         unI0f89DXx8oBPq+kobDvLqI1+G5eUKpbRJOc+sCD1LY+/w/z6qkHe1VDdZj/J3V0oJ+
         ss3FizgT/AT+n90jpnDQCdAIjKZgSW0Ix0+8CavMyxX8d7TaoVcGBe04FrWuIM+LN8tr
         A6NlsL9Kcoi8cuX2eDdzkNMrqr5caDILsxCsAMwJTQPV3UmmEnquxNflQNTi+9IdIDN5
         FViw==
X-Forwarded-Encrypted: i=1; AHgh+RrY1NVkzK4XMxWtwRYs4+v1yOBBeD/pUHihfA5XqsFjEAEQjdHnNZKRKP4qhykoL6CzPhKLS6dzhQMbHeBCdQr3Po9AhS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDGxoDUvhbjqQw2mr4F06TfIUCsLoV+72UV5V3t3mbM9vU41Ud
	rX8pZ5B7EnBqFCnXBns6t+susORSPoyBuzmbArnphW7ntVaBtWii+fUz
X-Gm-Gg: AR+sD10LxVAZtDfef/EZuEMB+rMIX5Ic8KAZLk2h0rK9kY/zopJ5P5NIpBAgQJG0zEI
	1rPG89FHzou7Fd1vPtaoFzCPNwxwKd9wv+enRiRUwWfrkHv6Jvix9VG3RMnYeOOpD99Bq62xxlM
	l7L2zV1FvqsJJzjiNLDB4AGRxZnAJnTJar6MOeI7SVcUz/Keyp+0hggVIHLsvF+nXjNGed0FOj7
	gaVo0IgvGiDKr9/Kfe8nxr/wqXdxT9UlsYwLCmiIEnqrQCxMcU1VFJ8yfOcyylsWoI+V1S5LQsm
	gw+C4oeIFZ0h6u0im3ZIEi+EWoi6HbuSEzTXcaiLFBeHJb1nnzamSlIv40daKmMtTULP71dQHCr
	8KA7IV85XRlxEPon2pLNgFQEhYZzwEWKZpzLzEexDcQfYIX0GKuwYgDh25F1k+0Db/M2YefV7BG
	cwj0i5whYhS0kw/idQu0u2Gpzs0hBjpFDICw+eF27tZrC9geutWLA83ZKiryLwCQ8VdTjc0zx6G
	Y7nXzfK4s48Fq9XuDko9aOAbGdUJ0ys5mNEG90mIYa/p8LuJGm/k3jKrrcTSn4sJRmOdCNdd5gw
	CUcUFoNc+w8Y0NdHmJF1HzgFblM=
X-Received: by 2002:a05:6000:4205:b0:47f:77a8:7e20 with SMTP id ffacd0b85a97d-47fd7308f0emr2136026f8f.35.1785528997285;
        Fri, 31 Jul 2026 13:16:37 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd458bf7csm8953678f8f.32.2026.07.31.13.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 13:16:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 31 Jul 2026 22:16:36 +0200
Message-Id: <DKD17D5H7N95.2VI5IOQBNTHGX@gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Paul Moore" <paul@paul-moore.com>
Cc: "David Windsor" <dwindsor@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Matt
 Bobrowski" <mattbobrowski@google.com>, "James Morris" <jmorris@namei.org>,
 "Serge E . Hallyn" <serge@hallyn.com>, "Casey Schaufler"
 <casey@schaufler-ca.com>, "Stephen Smalley"
 <stephen.smalley.work@gmail.com>, "Ondrej Mosnacek" <omosnace@redhat.com>,
 "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto Sassu"
 <roberto.sassu@huawei.com>, "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
 "Eric Snowberg" <eric.snowberg@oracle.com>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, "Shuah Khan" <shuah@kernel.org>,
 <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <selinux@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260730234533.1912709-1-dwindsor@gmail.com>
 <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
 <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com>
 <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
 <DKCVF3KRQSOJ.1WKITMP369I0R@gmail.com>
 <CAHC9VhR5yfw+sMfrYpy8Qm2uNoxqsTweh=KhDRZsU1CioHRDDQ@mail.gmail.com>
 <DKCWFKAD79IU.TMCNT9RUAJAU@gmail.com>
 <CAHC9VhRQWRKHi-hdtvSnYPD_dqgP7Q8RB_X4PEDLwPUe6EegYA@mail.gmail.com>
 <DKCYOLBUWJBZ.1N8JAXJ3QJYCE@gmail.com>
 <CAHC9VhRK38bVU5+rYxwLsvVt0oBBSWs4xKsjexbvc3TuA9LVNQ@mail.gmail.com>
 <DKCZDM2G8VHO.38SPG4I4JZTJI@gmail.com>
 <CAHC9VhR3AK4r4_0eqWxDmrA8UKOsbyQh6ZRRie99Pe6cW0EL8Q@mail.gmail.com>
 <DKD00NYVQQC9.OK8JEWHH1NUV@gmail.com>
 <CAHC9VhQ5vSr6JK0xtNnP2cre+3bbW9GUT7kXwLAcctwNpPzwrA@mail.gmail.com>
In-Reply-To: <CAHC9VhQ5vSr6JK0xtNnP2cre+3bbW9GUT7kXwLAcctwNpPzwrA@mail.gmail.com>

On Fri Jul 31, 2026 at 10:01 PM CEST, Paul Moore wrote:
> On Fri, Jul 31, 2026 at 3:20=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
>> On Fri Jul 31, 2026 at 9:05 PM CEST, Paul Moore wrote:
>> > On Fri, Jul 31, 2026 at 2:50=E2=80=AFPM Kumar Kartikeya Dwivedi
>> > <memxor@gmail.com> wrote:
>> >> On Fri Jul 31, 2026 at 8:42 PM CEST, Paul Moore wrote:
>> >> > On Fri, Jul 31, 2026 at 2:18=E2=80=AFPM Kumar Kartikeya Dwivedi
>> >> > <memxor@gmail.com> wrote:
>> >> >> On Fri Jul 31, 2026 at 6:59 PM CEST, Paul Moore wrote:
>> >> >> > On Fri, Jul 31, 2026 at 12:32=E2=80=AFPM Kumar Kartikeya Dwivedi
>> >> >> > <memxor@gmail.com> wrote:
>> >> >> >> On Fri Jul 31, 2026 at 6:02 PM CEST, Paul Moore wrote:
>> >> >> >> > On Fri, Jul 31, 2026 at 11:44=E2=80=AFAM Kumar Kartikeya Dwiv=
edi
>> >> >> >> > <memxor@gmail.com> wrote:
>> >> >> >> >> On Fri Jul 31, 2026 at 5:30 PM CEST, David Windsor wrote:
>> >> >> >> >> > On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <paul@=
paul-moore.com> wrote:
>> >> >
>> >> > ...
>> >> >
>> >> >> Yes, I understand you feel it should be placed under security/. Yo=
u are entitled
>> >> >> to your opinion.
>> >> >>
>> >> >> No, I do not think the newly added kfunc is a big enough layering =
violation such
>> >> >> that we need to do it ASAP, disregarding everything else outlined =
above. I am
>> >> >> sure you see that too. There are several other instances of simila=
r kfuncs.
>> >> >>
>> >> >> Therefore, please attempt to meet me halfway here.
>> >> >
>> >> > I'm happy to work with you, and/or anyone else, who wants to work o=
n
>> >> > finding a way to test kfuncs that live in security/bpf_lsm_kfuncs.c=
.
>> >>
>> >> Right, and for that file to exist, you need to get everyone (FS, BPF =
folks) to
>> >> agree on whether placing all such kfuncs there makes sense. It is not=
 for both
>> >> of us to decide on our own. So let's revisit this whole topic once yo=
u've done
>> >> that exercise.
>> >
>> > The kfunc that David has proposed must be located in
>> > security/bpf_lsm_kfuncs.c, similar to the VFS kfuncs and
>> > fs/bpf_fs_kfuncs.c.  If you read David's bpf_init_inode_xattr() kfunc
>>
>> Sigh.
>>
>> I now went and read the archives, and Christian already told you no befo=
re [0],
>> which I missed in my first read. So two people whom this code affects al=
ready
>> objected to your proposal.
>
> As mentioned previously, David's kfunc has nothing to do with the VFS.
> Look at the code if you haven't already and you'll see what I mean.
> The only relevance to the VFS is the fact that "inode" and "xattr" are
> used in the name; David's currently proposed kfunc is an LSM kfunc,
> not a VFS kfunc.

I am sorry, I read it and I don't see why it is an LSM kfunc. It is absolut=
ely a
VFS kfunc, that is using LSM APIs to some end. The LSM specific bits are al=
ready
in security/.

At the very least, it is a mix of both, but definitely not one or the other=
.
Therefore, the situation is already ideal, code owned by different people i=
s in
the files they signed up to maintain.

>
> If you find yourself required to abide by Christian's comment, despite
> this not being a VFS kfunc, that's fine, but this puts us at a
> stalemate and David will need to find another approach for his work.

Paul, let me remind you of another email you sent [0], in which you contrad=
ict
yourself. I don't know what caused you to get confused over the month.

In it, you tell David to move *LSM* bits into security_lsmxattr_add(), whic=
h has
been done in patch 2. Thus, by your own characterization, it means the rest=
 is
*not LSM* code.

Quoting you verbatim:
> As I said previously, if you absolutely insist on the kfunc being in
> the VFS kfunc file, the LSM specific bits need to be abstracted out
			^^^^^^^^^^^^^^^
> into an LSM function.

You yourself made the point in that same email that the kfunc can stay in t=
he
current file once LSM bits were moved out, and your request was honored.

At this point, anybody reading this thread will only see your position as a=
 way
to undermine David's work and waste everyone's time, such that you can grin=
d an
axe against BPF folks. It's a repeating pattern.

I tried my best to engage in good faith, but it is clearly not working.

 [0]: https://lore.kernel.org/bpf/CAHC9VhQd0-N1g=3Dg8gspeV7bhLz0LA6DF5HZyB7=
mW6VW_7oSt2w@mail.gmail.com
