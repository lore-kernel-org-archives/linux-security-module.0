Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886234611F4
	for <linux-security-module@vger.kernel.org>; Wed,  8 Jul 2026 12:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783515126; cv=pass; b=nxyno4845YAMC4DDQtcf446g6dT5uR4akcFkJG1F1WKVBpL1sxB0VpP9J6E+HDJiw0SbL2S7RFZT0ypDtZ48o/GnJvnD5yh+KePC9rikI9dvE3665WPs4falkGDe0UQT1T6+dL42tPMmRbSgyYX2ntTYLscSu8Oiw3Wx2ksWk9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783515126; c=relaxed/simple;
	bh=LMcsBp3I2AM2BUc5Uv9PZXVaMxtMYi04e37upzRhQOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HYpU/vFdT7SHYU9/yiJdZWalwwtQ1I5Dc+ojMeeSaBaSHFicSqSzjy3JhgYAMbPuPHgMyAolG4DbdDwJLKOHCgz0WApaZDtznVEfVuu5Hh9oVPiSmU1AQOIpBW2LvnetOAH9v/hxNilPjIyBoNDwJb3qUWzJ69PKQVE4t3IJfes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJ8YmyNG; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJ8YmyNG"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8f1a8e914a9so4950666d6.1
        for <linux-security-module@vger.kernel.org>; Wed, 08 Jul 2026 05:52:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783515123; cv=none;
        d=google.com; s=arc-20260327;
        b=XT7szhBzA5gfvE5J2WdR9NlkL1bahLLBcgPzSFsf6n8IR3FqnmHPaalDwN8LdsFJba
         6Rq0IsoOMqxHRSI8zeO0Ag4z6Gumoqox/bwLuLWtmlViB3Q/Qapbmqku2r3PGXGlgZy6
         c198dmCpCgaRzzbVGGBcTF8iajYsj7xDcXvDHtGPns5hJNusSqhmZHNY3byK/g8MfB6V
         Gm0eC0HES9iV1WEB+PW6/cBJ5gZNnFoUaTfTT99bmHpSEHPYSXr9RGeikULS/3SiiVjj
         dFIhXifiEx0kNQzu8pNMkHhjwXBg8U9/sSAjlV6dhndfSCipDHDmpqp8SK51w8JA33TS
         oPEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LMcsBp3I2AM2BUc5Uv9PZXVaMxtMYi04e37upzRhQOQ=;
        fh=xvWbZlXcvtlztSdZ5UypZtnTDzbEnKSyxptn6C5++hU=;
        b=i+FD0jOhqJCvpXXXNcEsFqqfYeT1DJNn0/fmGmwna073pqwiJCQDlekDlXRg9m398B
         obC87UvUGt+WL+7khNSAtGAibcNnYLTBJuCC1T64wExa5lSAVPN16s+10HQ64QuyC25a
         SQVHqBVlsKO7vLpWOM3PUxx4s0XtEEz4974TpgTS9ixbRow32kOxCA/xCB0gSMaM55GE
         2nzcj5VCXAMT0nYdVoelnjBfAcNJqcAuP/p0+ZAa3cBWusF1S87rgYPanrvoypFoWt4H
         B05Ees0AlQirzq+yurBcBP/2JSM+dlzHhpdRNPYFrxYzzQ6dzPRJA0NZUTr8Uishky5a
         H/tA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783515123; x=1784119923; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LMcsBp3I2AM2BUc5Uv9PZXVaMxtMYi04e37upzRhQOQ=;
        b=cJ8YmyNGzcUVkugDcbDFSV9hG1XDIYcPXiertRg0HgzcUcju9zF9S1QddQvl1IpWUU
         4k5nyw2V0IVysz1RCrUdJrEDo/h/A2qbnGEkhOL3pMSeZq9aNdhek1gxoF3bPioxNI3d
         ggeFj1wflW8RofhZngweDB2Ewf+1+x6kpdbS6g61gDANdxSQ8inNYw98Euig7Tflxz79
         yJ8j6vynosLrChyjPyPwAlM/tzP8CcmxcP2N9+hHViX91g/XicWPJjt9i8qCxLFKR4ur
         hbNv49Trj68z0qWIkUNyQKuPp7su1TchELfMq/n41YFkTwA8KS5WkUEWYHQo3mp6OZbs
         /R0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783515123; x=1784119923;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LMcsBp3I2AM2BUc5Uv9PZXVaMxtMYi04e37upzRhQOQ=;
        b=Q45zGzSz3fg0RgX+mM/0rezj4ncwRcCtQ5C+ORYcyyzM2+Ffl1QWPumiZ/Wn4NTEe3
         3N1qMmFTCEFwVO/TDbJFR5jqeitYF6TS3eOnKeOCAjPrjRyMeK+rVD6EN5OCMGvekP4h
         YIZ/32imUXTrUJKq9xMuxkv4Q5XbeaEo5J+9PZH5g/3GXI8u/ET12KeP8CU0oNMD/YSm
         plWqNd2tLlDCLSICu0wS2eX+PxWXwAlvYUlOd6kIz9B1HcXc8q+VP0ADm0MUeY3ITuDf
         vSezqSkF+Xmq5ZXLJyisDEQpVGEGJEYW6GZfeVhGctPUAMAqQamJmkyy0Xas0eLxg2BG
         O5tA==
X-Forwarded-Encrypted: i=1; AHgh+RoJKHU4P+IWG56/gt60wBdSyRpafWn5vU197ouitUkDwBN6zaFIx4OfPT419IM14sUhkHtlJUgY2Vawxc/L4nYJWEbJxtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGcSnz0ivUargHjmOa2X1XIjuJI83p3Wj+7fKcqNbL7FROBmaa
	+FOH9bzPSiP+Y3Mh7MMH6G7Yx4M4Lg+ifEOwlC1OPTeygnjI+cxfHYhEcD9SAmMm5zIFEGIsEin
	V2ZCC6FC5q8BxKZkKXX37Bv7KxNdrVzM=
X-Gm-Gg: AfdE7ckgy6zNpSDCnLo2VP+KLewZwM5Na9ygdAFaEqV6Uv+s6rFFLBobtNwCmBJqlrw
	dhRarTkvfzjVfxS+RpQCBmYicp2wbRICDbZNZ0iVbrPRkzRvuGDemIo/xoCUJVrMTwYGjJ5GHFq
	9AjipRTTNRuCj1zK4ZFLJ7HV0PDYCzk32F0pJ5aDC+fy8usn96OtB9gJXJ8TmSYaYvdk5A64owc
	MhfvCs5Ux9ZgSsV5bWIMWBKgn/BhBbNvMNa/sK62Dc6fbgIbgFn3j9z1usbIS/fiuI+QyAnTIrI
	5zuqClOi6tAk69NCcggNDxC42vU=
X-Received: by 2002:a05:6214:328c:b0:8fd:6df3:b37a with SMTP id
 6a1803df08f44-8fec361db53mr20328306d6.62.1783515123475; Wed, 08 Jul 2026
 05:52:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708000956.46138-1-dwindsor@gmail.com> <DJSV0P2OINKE.34OCOC34KFEEF@gmail.com>
In-Reply-To: <DJSV0P2OINKE.34OCOC34KFEEF@gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Wed, 8 Jul 2026 08:51:52 -0400
X-Gm-Features: AVVi8CfU37Brxag2yfG62kEk96iHc-RKohKljtHAIy8Sn1Fk6Gh-XV62bqUwhO4
Message-ID: <CAEXv5_j96aUkmSEg4brvk2q-A3SyYzXZ7jyutoXfrc-oDykZYQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 0/3] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 11:12=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed Jul 8, 2026 at 2:09 AM CEST, David Windsor wrote:
> > Many in-kernel LSMs (SELinux, Smack, IMA) store security labels in
> > extended attributes. For these LSMs, atomic labeling during inode
> > creation is critical: if the inode becomes accessible before its xattr
> > is set, it is briefly unlabeled, which can disrupt LSMs making policy
> > decisions based on file labels.
> >
> > Existing LSMs solve this by setting xattrs directly in the
> > inode_init_security hook, which runs before the inode becomes
> > accessible. BPF LSM programs currently lack this capability because
> > the hook uses an output parameter (xattr_count) that BPF programs
> > cannot write to, and existing kfuncs like bpf_set_dentry_xattr
> > require a dentry that isn't available until after the inode is
> > accessible.
> >
> > This series introduces the bpf_init_inode_xattr() kfunc, which takes
> > the combined inode_init_security xattr context argument and claims a
> > slot in it via the new security_lsmxattr_add() LSM helper.
> >
>
> There are various CI failures in newly added tests, I don't think any of =
them
> are passing. Please fix before respinning.
>
> https://github.com/kernel-patches/bpf/pull/12730
>
> E.g. both test_init_inode_xattr and test_init_inode_xattr_slot do not hav=
e
> expected results.
>

This is happening because the path "/tmp" in bpf ci isn't mounted on
tmpfs, rather on 9p:

[ 5.813072] VFS: Mounted root (9p filesystem) on device 0:22.
[ 5.924390] vmtest: Mounting tmpfs at /dev/shm
[ 5.971012] vmtest: Mounting tmpfs at /run
[ 6.096271] vmtest: Mounting tmpfs at /mnt

... which doesn't call inode_init_security. Changing the test to
create its file in /dev/shm, which has a real tmpfs, fixes this. We
can update the test to skip on filesystems where the hook doesn't
fire.

I'll wait to gather feedback from Alexei and Paul before sending v6.

> pw-bot: cr
>
> > [...]
